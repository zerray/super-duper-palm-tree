(function () {
  const STYLE_ID = "peer-multiplayer-style";

  function ensureStyle() {
    if (document.getElementById(STYLE_ID)) {
      return;
    }

    const style = document.createElement("style");
    style.id = STYLE_ID;
    style.textContent = `
      .peer-multiplayer-panel {
        position: fixed;
        right: 18px;
        bottom: 18px;
        z-index: 1000;
        width: min(320px, calc(100vw - 36px));
        padding: 14px;
        border-radius: 18px;
        background: rgba(18, 24, 35, 0.92);
        color: #f5f7fb;
        box-shadow: 0 16px 36px rgba(0, 0, 0, 0.28);
        border: 1px solid rgba(255, 255, 255, 0.12);
        font: 14px/1.45 "Trebuchet MS", "Segoe UI", sans-serif;
      }

      .peer-multiplayer-panel h2,
      .peer-multiplayer-panel p {
        margin: 0;
      }

      .peer-multiplayer-panel h2 {
        font-size: 1rem;
      }

      .peer-multiplayer-panel p {
        color: rgba(245, 247, 251, 0.78);
      }

      .peer-multiplayer-stack {
        display: grid;
        gap: 10px;
        margin-top: 10px;
      }

      .peer-multiplayer-row {
        display: flex;
        gap: 8px;
      }

      .peer-multiplayer-row > * {
        flex: 1 1 0;
      }

      .peer-multiplayer-panel button,
      .peer-multiplayer-panel input {
        font: inherit;
      }

      .peer-multiplayer-panel button {
        min-height: 40px;
        border: 0;
        border-radius: 999px;
        cursor: pointer;
        font-weight: 700;
      }

      .peer-multiplayer-primary {
        color: #102033;
        background: linear-gradient(180deg, #9fe7ff 0%, #67bfd9 100%);
      }

      .peer-multiplayer-secondary {
        color: #f5f7fb;
        background: rgba(255, 255, 255, 0.12);
      }

      .peer-multiplayer-panel input {
        width: 100%;
        min-height: 40px;
        border-radius: 12px;
        border: 1px solid rgba(255, 255, 255, 0.16);
        background: rgba(8, 12, 18, 0.42);
        color: #f5f7fb;
        padding: 0 12px;
      }

      .peer-multiplayer-room {
        padding: 10px 12px;
        border-radius: 12px;
        background: rgba(255, 255, 255, 0.08);
        border: 1px solid rgba(255, 255, 255, 0.12);
        word-break: break-all;
      }

      .peer-multiplayer-room strong {
        display: block;
        color: #9fe7ff;
        margin-top: 4px;
      }

      .peer-multiplayer-status {
        min-height: 2.9em;
      }
    `;
    document.head.appendChild(style);
  }

  function createPanel(title, subtitle) {
    ensureStyle();
    const panel = document.createElement("section");
    panel.className = "peer-multiplayer-panel";
    panel.innerHTML = `
      <h2>${title}</h2>
      <p>${subtitle}</p>
      <div class="peer-multiplayer-stack">
        <div class="peer-multiplayer-row">
          <button type="button" class="peer-multiplayer-primary" data-action="create-room">Create Room</button>
          <button type="button" class="peer-multiplayer-secondary" data-action="disconnect">Disconnect</button>
        </div>
        <div class="peer-multiplayer-room">
          Room Code
          <strong data-role="room-code">Local only</strong>
        </div>
        <div class="peer-multiplayer-row">
          <input type="text" maxlength="80" placeholder="Enter room code" data-role="room-input">
          <button type="button" class="peer-multiplayer-secondary" data-action="join-room">Join</button>
        </div>
        <p class="peer-multiplayer-status" data-role="status-text">Online multiplayer is optional. Create a room or join an existing one.</p>
      </div>
    `;
    document.body.appendChild(panel);
    return {
      panel,
      createButton: panel.querySelector('[data-action="create-room"]'),
      disconnectButton: panel.querySelector('[data-action="disconnect"]'),
      joinButton: panel.querySelector('[data-action="join-room"]'),
      roomCode: panel.querySelector('[data-role="room-code"]'),
      roomInput: panel.querySelector('[data-role="room-input"]'),
      statusText: panel.querySelector('[data-role="status-text"]')
    };
  }

  function destroyPeer(state) {
    if (state.connection) {
      state.connection.close();
      state.connection = null;
    }
    if (state.peer) {
      state.peer.destroy();
      state.peer = null;
    }
  }

  window.createPeerMultiplayer = function createPeerMultiplayer(options) {
    const config = options || {};
    const ui = createPanel(config.title || "Online Multiplayer", config.subtitle || "Share a room code to play together.");
    const state = {
      peer: null,
      connection: null,
      connected: false,
      role: "local",
      roomCode: ""
    };

    function setStatus(message) {
      ui.statusText.textContent = message;
    }

    function snapshot() {
      return {
        connected: state.connected,
        role: state.role,
        roomCode: state.roomCode
      };
    }

    function updateUi() {
      ui.roomCode.textContent = state.roomCode || "Local only";
      ui.disconnectButton.disabled = !state.peer && !state.connection;
    }

    function handleDisconnect(message) {
      const wasConnected = state.connected;
      destroyPeer(state);
      state.connected = false;
      state.role = "local";
      state.roomCode = "";
      updateUi();
      setStatus(message || "Returned to local mode.");
      if (typeof config.onDisconnect === "function") {
        config.onDisconnect({ wasConnected });
      }
    }

    function attachConnection(connection, role) {
      if (state.connection && state.connection !== connection) {
        connection.close();
        return;
      }

      state.connection = connection;
      state.role = role;

      connection.on("open", function () {
        state.connected = true;
        setStatus(role === "host" ? "Guest connected. Online match is live." : "Connected to host. Waiting for synchronized board state.");
        updateUi();
        if (typeof config.onConnect === "function") {
          config.onConnect(snapshot(), api);
        }
      });

      connection.on("data", function (payload) {
        if (typeof config.onMessage === "function") {
          config.onMessage(payload, api);
        }
      });

      connection.on("close", function () {
        handleDisconnect("Peer disconnected. Returned to local mode.");
      });

      connection.on("error", function () {
        handleDisconnect("Connection error. Returned to local mode.");
      });
    }

    function attachPeer(peer, role, roomCode) {
      state.peer = peer;
      state.role = role;
      state.roomCode = roomCode || "";
      updateUi();

      peer.on("error", function () {
        handleDisconnect("Peer connection failed. Returned to local mode.");
      });
    }

    function createRoom() {
      if (typeof window.Peer !== "function") {
        setStatus("PeerJS is unavailable. Open this page online to enable multiplayer.");
        return;
      }

      destroyPeer(state);
      state.connected = false;
      state.connection = null;
      state.roomCode = "";
      state.role = "host";
      updateUi();
      setStatus("Opening host room...");

      const peer = new window.Peer();
      attachPeer(peer, "host", "");

      peer.on("open", function (id) {
        state.roomCode = id;
        updateUi();
        setStatus("Room ready. Share the code and wait for a guest.");
      });

      peer.on("connection", function (connection) {
        attachConnection(connection, "host");
      });
    }

    function joinRoom() {
      const roomCode = ui.roomInput.value.trim();
      if (!roomCode) {
        setStatus("Enter a room code before joining.");
        return;
      }

      if (typeof window.Peer !== "function") {
        setStatus("PeerJS is unavailable. Open this page online to enable multiplayer.");
        return;
      }

      destroyPeer(state);
      state.connected = false;
      state.connection = null;
      state.roomCode = roomCode;
      state.role = "guest";
      updateUi();
      setStatus("Connecting to room...");

      const peer = new window.Peer();
      attachPeer(peer, "guest", roomCode);

      peer.on("open", function () {
        const connection = peer.connect(roomCode, { reliable: true });
        attachConnection(connection, "guest");
      });
    }

    const api = {
      send(message) {
        if (state.connection && state.connected) {
          state.connection.send(message);
        }
      },
      disconnect(message) {
        handleDisconnect(message);
      },
      getState() {
        return snapshot();
      },
      isConnected() {
        return state.connected;
      },
      isHost() {
        return state.connected && state.role === "host";
      },
      isGuest() {
        return state.connected && state.role === "guest";
      },
      isMultiplayer() {
        return state.connected;
      },
      setStatus
    };

    ui.createButton.addEventListener("click", createRoom);
    ui.joinButton.addEventListener("click", joinRoom);
    ui.disconnectButton.addEventListener("click", function () {
      handleDisconnect("Disconnected. Returned to local mode.");
    });

    updateUi();
    return api;
  };
})();
