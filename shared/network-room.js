(function () {
  class PeerRoomController {
    constructor(options = {}) {
      this.createButton = options.createButton || null;
      this.joinButton = options.joinButton || null;
      this.leaveButton = options.leaveButton || null;
      this.roomInput = options.roomInput || null;
      this.roomCode = options.roomCode || null;
      this.statusLabel = options.statusLabel || null;
      this.modeLabel = options.modeLabel || null;
      this.peer = null;
      this.connection = null;
      this.isHost = false;
      this.connected = false;
      this.roomId = "";
      this.onMessage = options.onMessage || function () {};
      this.onOpen = options.onOpen || function () {};
      this.onClose = options.onClose || function () {};
      this.onError = options.onError || function () {};
      this.onRoleChange = options.onRoleChange || function () {};

      if (this.createButton) {
        this.createButton.addEventListener("click", () => this.createRoom());
      }
      if (this.joinButton) {
        this.joinButton.addEventListener("click", () => {
          const roomId = this.roomInput ? this.roomInput.value.trim() : "";
          this.joinRoom(roomId);
        });
      }
      if (this.leaveButton) {
        this.leaveButton.addEventListener("click", () => this.disconnect());
      }

      this.setStatus("Local mode. Create or join a room to play online.");
      this.setMode("Local");
    }

    hasPeerJs() {
      return typeof window.Peer === "function";
    }

    setStatus(message) {
      if (this.statusLabel) {
        this.statusLabel.textContent = message;
      }
    }

    setMode(message) {
      if (this.modeLabel) {
        this.modeLabel.textContent = message;
      }
    }

    updateRoomCode() {
      if (this.roomCode) {
        this.roomCode.textContent = this.roomId || "Offline";
      }
    }

    createPeer() {
      if (!this.hasPeerJs()) {
        this.setStatus("PeerJS failed to load. Online multiplayer is unavailable.");
        return null;
      }
      this.teardownPeer();
      this.peer = new window.Peer();
      this.peer.on("error", (error) => {
        this.setStatus(`Network error: ${error.type || "unknown"}.`);
        this.onError(error);
      });
      this.peer.on("disconnected", () => {
        this.setStatus("Disconnected from signaling. Reconnect or create a new room.");
      });
      return this.peer;
    }

    createRoom() {
      const peer = this.createPeer();
      if (!peer) {
        return;
      }

      this.isHost = true;
      this.setMode("Hosting");
      this.setStatus("Creating room...");
      this.onRoleChange({ connected: false, isHost: true, role: "host" });

      peer.on("open", (id) => {
        this.roomId = id;
        this.updateRoomCode();
        this.setStatus("Room ready. Share the code and wait for a guest.");
      });

      peer.on("connection", (connection) => {
        if (this.connection && this.connection.open) {
          connection.close();
          return;
        }
        this.bindConnection(connection);
      });
    }

    joinRoom(roomId) {
      if (!roomId) {
        this.setStatus("Enter a room code first.");
        return;
      }

      const peer = this.createPeer();
      if (!peer) {
        return;
      }

      this.isHost = false;
      this.roomId = roomId;
      this.updateRoomCode();
      this.setMode("Joining");
      this.setStatus("Connecting to room...");
      this.onRoleChange({ connected: false, isHost: false, role: "guest" });

      peer.on("open", () => {
        const connection = peer.connect(roomId, { reliable: true });
        this.bindConnection(connection);
      });
    }

    bindConnection(connection) {
      this.connection = connection;

      connection.on("open", () => {
        this.connected = true;
        this.setMode(this.isHost ? "Online Host" : "Online Guest");
        this.setStatus(this.isHost ? "Guest connected." : "Connected to host.");
        this.onRoleChange({
          connected: true,
          isHost: this.isHost,
          role: this.isHost ? "host" : "guest"
        });
        this.onOpen({
          connected: true,
          isHost: this.isHost,
          role: this.isHost ? "host" : "guest",
          roomId: this.roomId
        });
      });

      connection.on("data", (message) => {
        this.onMessage(message);
      });

      connection.on("close", () => {
        this.connected = false;
        this.connection = null;
        this.setMode("Local");
        this.setStatus("Remote player disconnected. Local mode restored.");
        this.onClose({ connected: false, isHost: this.isHost });
        this.onRoleChange({ connected: false, isHost: this.isHost, role: "local" });
      });

      connection.on("error", (error) => {
        this.setStatus(`Connection error: ${error.type || "unknown"}.`);
        this.onError(error);
      });
    }

    send(message) {
      if (!this.connection || !this.connection.open) {
        return false;
      }
      this.connection.send(message);
      return true;
    }

    disconnect() {
      if (this.connection) {
        this.connection.close();
      }
      this.teardownPeer();
      this.connected = false;
      this.isHost = false;
      this.roomId = "";
      this.updateRoomCode();
      this.setMode("Local");
      this.setStatus("Local mode. Create or join a room to play online.");
      this.onRoleChange({ connected: false, isHost: false, role: "local" });
    }

    teardownPeer() {
      if (this.peer) {
        this.peer.destroy();
        this.peer = null;
      }
      this.connection = null;
    }
  }

  window.PeerRoomController = PeerRoomController;
})();
