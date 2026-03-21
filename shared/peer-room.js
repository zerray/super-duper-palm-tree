(function () {
  function randomRoomId() {
    return Math.random().toString(36).slice(2, 8).toUpperCase();
  }

  function safeText(value) {
    return value || "";
  }

  window.createPeerRoom = function createPeerRoom(options) {
    const elements = options.elements || {};
    const state = {
      peer: null,
      connection: null,
      role: "local",
      roomId: "",
      connected: false,
      lastStatus: "Local mode."
    };

    function setStatus(message) {
      state.lastStatus = message;
      if (elements.status) {
        elements.status.textContent = message;
      }
      if (typeof options.onStatus === "function") {
        options.onStatus(message, getContext());
      }
    }

    function setRoomId(roomId) {
      state.roomId = safeText(roomId).toUpperCase();
      if (elements.roomCode) {
        elements.roomCode.textContent = state.roomId || "------";
      }
      if (elements.joinInput && !state.connected && state.role !== "guest") {
        elements.joinInput.value = state.roomId;
      }
    }

    function getContext() {
      return {
        role: state.role,
        roomId: state.roomId,
        connected: state.connected,
        isHost: state.role === "host",
        isGuest: state.role === "guest",
        isRemote: state.connected
      };
    }

    function refreshUi() {
      if (elements.mode) {
        const modeText = state.connected
          ? state.role === "host"
            ? "Host"
            : "Guest"
          : "Local";
        elements.mode.textContent = modeText;
      }

      if (elements.createButton) {
        elements.createButton.disabled = Boolean(state.peer) && state.role === "host";
      }
      if (elements.joinButton) {
        elements.joinButton.disabled = Boolean(state.peer) && state.role === "guest";
      }
      if (elements.leaveButton) {
        elements.leaveButton.disabled = !state.peer && !state.connection;
      }
      if (elements.copyButton) {
        elements.copyButton.disabled = !state.roomId;
      }
    }

    function closeConnection() {
      if (state.connection) {
        try {
          state.connection.close();
        } catch (error) {
          // Ignore close errors from torn-down peers.
        }
      }
      state.connection = null;
      state.connected = false;
    }

    function destroyPeer() {
      if (state.peer) {
        try {
          state.peer.destroy();
        } catch (error) {
          // Ignore teardown errors from PeerJS.
        }
      }
      state.peer = null;
    }

    function leaveRoom(notify = false) {
      const hadRemoteSession = state.connected || state.role !== "local";
      closeConnection();
      destroyPeer();
      state.role = "local";
      setRoomId("");
      refreshUi();
      setStatus("Local mode.");
      if (hadRemoteSession && typeof options.onDisconnected === "function") {
        options.onDisconnected(getContext());
      }
      if (notify && typeof options.onLeave === "function") {
        options.onLeave(getContext());
      }
    }

    function attachConnection(connection) {
      state.connection = connection;

      connection.on("open", function () {
        state.connected = true;
        refreshUi();
        setStatus(
          state.role === "host"
            ? "Peer connected. Multiplayer session is live."
            : "Connected to host. Waiting for sync."
        );
        if (typeof options.onConnected === "function") {
          options.onConnected(getContext());
        }
      });

      connection.on("data", function (payload) {
        if (typeof options.onMessage === "function") {
          options.onMessage(payload, getContext());
        }
      });

      connection.on("close", function () {
        leaveRoom();
      });

      connection.on("error", function () {
        setStatus("Connection error. Returning to local mode.");
        leaveRoom();
      });
    }

    function createPeer(peerId) {
      if (!window.Peer) {
        setStatus("PeerJS failed to load. Multiplayer is unavailable.");
        return null;
      }

      destroyPeer();
      state.peer = peerId ? new window.Peer(peerId) : new window.Peer();

      state.peer.on("open", function (openedId) {
        if (state.role === "host") {
          setRoomId(openedId);
          refreshUi();
          setStatus("Room created. Share the code and wait for a guest.");
        } else if (state.role === "guest") {
          refreshUi();
          setStatus("Guest ready. Opening room connection...");
          const connection = state.peer.connect(state.roomId, { reliable: true });
          attachConnection(connection);
        }
      });

      state.peer.on("connection", function (connection) {
        if (state.role !== "host" || state.connection) {
          connection.close();
          return;
        }
        attachConnection(connection);
      });

      state.peer.on("error", function () {
        setStatus("PeerJS signaling failed. Returning to local mode.");
        leaveRoom();
      });

      return state.peer;
    }

    function createRoom() {
      if (state.peer || state.connection) {
        leaveRoom();
      }
      state.role = "host";
      setRoomId(randomRoomId());
      refreshUi();
      setStatus("Creating room...");
      createPeer(state.roomId);
    }

    function joinRoom() {
      const nextRoomId = safeText(elements.joinInput && elements.joinInput.value).trim().toUpperCase();
      if (!nextRoomId) {
        setStatus("Enter a room code to join.");
        return;
      }
      if (state.peer || state.connection) {
        leaveRoom();
      }
      state.role = "guest";
      setRoomId(nextRoomId);
      refreshUi();
      setStatus("Preparing guest connection...");
      createPeer();
    }

    async function copyRoomCode() {
      if (!state.roomId || !navigator.clipboard) {
        return;
      }
      try {
        await navigator.clipboard.writeText(state.roomId);
        setStatus("Room code copied to clipboard.");
      } catch (error) {
        setStatus("Copy failed. Select the room code manually.");
      }
    }

    function send(payload) {
      if (!state.connection || !state.connected) {
        return false;
      }
      state.connection.send(payload);
      return true;
    }

    if (elements.createButton) {
      elements.createButton.addEventListener("click", createRoom);
    }
    if (elements.joinButton) {
      elements.joinButton.addEventListener("click", joinRoom);
    }
    if (elements.leaveButton) {
      elements.leaveButton.addEventListener("click", function () {
        leaveRoom(true);
      });
    }
    if (elements.copyButton) {
      elements.copyButton.addEventListener("click", copyRoomCode);
    }

    refreshUi();
    setRoomId("");
    setStatus("Local mode.");

    return {
      createRoom,
      joinRoom,
      leaveRoom,
      send,
      getContext
    };
  };
}());
