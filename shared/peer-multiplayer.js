(function attachPeerMultiplayer(global) {
  function noop() {}

  function safeClose(target) {
    if (!target || typeof target.close !== "function") {
      return;
    }
    try {
      target.close();
    } catch (error) {
      // Ignore teardown errors during disconnect/reset.
    }
  }

  global.createPeerMultiplayer = function createPeerMultiplayer(options) {
    const config = options || {};
    const elements = config.elements || {};
    const onMessage = config.onMessage || noop;
    const onRoleChange = config.onRoleChange || noop;
    const onResetLocal = config.onResetLocal || noop;
    const getSnapshot = config.getSnapshot || null;
    const applySnapshot = config.applySnapshot || noop;

    const state = {
      peer: null,
      connection: null,
      role: "local",
      connected: false,
      roomCode: "",
      status: "Local mode. Create a room or join one."
    };

    function renderUi() {
      if (elements.roomCode) {
        elements.roomCode.textContent = state.roomCode || "Not connected";
      }
      if (elements.role) {
        elements.role.textContent =
          state.role === "host"
            ? "Host"
            : state.role === "guest"
              ? "Guest"
              : "Local";
      }
      if (elements.status) {
        elements.status.textContent = state.status;
      }
      if (elements.createButton) {
        elements.createButton.disabled = state.role !== "local";
      }
      if (elements.joinButton) {
        elements.joinButton.disabled = state.role !== "local";
      }
      if (elements.roomInput) {
        elements.roomInput.disabled = state.role !== "local";
      }
      if (elements.disconnectButton) {
        elements.disconnectButton.disabled = state.role === "local";
      }
    }

    function setStatus(message) {
      state.status = message;
      renderUi();
    }

    function destroyPeerObjects() {
      safeClose(state.connection);
      safeClose(state.peer);
      state.connection = null;
      state.peer = null;
    }

    function resetToLocal(message) {
      destroyPeerObjects();
      state.role = "local";
      state.connected = false;
      state.roomCode = "";
      state.status = message || "Local mode. Create a room or join one.";
      renderUi();
      onRoleChange(state.role, false);
      onResetLocal(state.status);
    }

    function send(message) {
      if (!state.connected || !state.connection || !state.connection.open) {
        return false;
      }
      state.connection.send(message);
      return true;
    }

    function attachConnection(connection) {
      state.connection = connection;
      connection.on("open", () => {
        state.connected = true;
        if (state.role === "guest") {
          setStatus("Connected. Waiting for host state sync.");
          send({ type: "sync-request" });
        } else {
          setStatus("Opponent connected. Match is live.");
          if (getSnapshot) {
            send({ type: "snapshot", snapshot: getSnapshot() });
          }
        }
        renderUi();
        onRoleChange(state.role, true);
      });
      connection.on("data", (message) => {
        if (!message || typeof message !== "object") {
          return;
        }
        if (message.type === "sync-request") {
          if (state.role === "host" && getSnapshot) {
            send({ type: "snapshot", snapshot: getSnapshot() });
          }
          return;
        }
        if (message.type === "snapshot") {
          applySnapshot(message.snapshot);
          return;
        }
        onMessage(message, state.role);
      });
      connection.on("close", () => {
        resetToLocal("Connection closed. Back in local mode.");
      });
      connection.on("error", () => {
        resetToLocal("Connection failed. Back in local mode.");
      });
    }

    function wirePeerEvents(peer) {
      peer.on("open", (id) => {
        if (state.role === "host") {
          state.roomCode = id;
          setStatus("Room ready. Share the code and wait for your opponent.");
          renderUi();
          return;
        }

        setStatus("Joining room...");
        attachConnection(peer.connect(state.roomCode, { reliable: true, serialization: "json" }));
      });

      peer.on("connection", (connection) => {
        if (state.role !== "host") {
          safeClose(connection);
          return;
        }
        setStatus("Opponent joining...");
        attachConnection(connection);
      });

      peer.on("error", (error) => {
        if (error && error.type === "peer-unavailable") {
          resetToLocal("Room code not found. Check the code and try again.");
          return;
        }
        resetToLocal("PeerJS is unavailable right now. Staying in local mode.");
      });

      peer.on("disconnected", () => {
        if (state.connected) {
          resetToLocal("Peer disconnected. Back in local mode.");
        }
      });
    }

    function createRoom() {
      if (!global.Peer) {
        setStatus("PeerJS did not load. Multiplayer needs internet access.");
        return;
      }
      destroyPeerObjects();
      state.role = "host";
      state.connected = false;
      state.roomCode = "";
      setStatus("Creating room...");
      renderUi();
      state.peer = new global.Peer();
      wirePeerEvents(state.peer);
      onRoleChange(state.role, false);
    }

    function joinRoom(roomCode) {
      if (!global.Peer) {
        setStatus("PeerJS did not load. Multiplayer needs internet access.");
        return;
      }
      const nextRoomCode = String(roomCode || "").trim();
      if (!nextRoomCode) {
        setStatus("Enter a room code before joining.");
        return;
      }
      destroyPeerObjects();
      state.role = "guest";
      state.connected = false;
      state.roomCode = nextRoomCode;
      setStatus("Starting client...");
      renderUi();
      state.peer = new global.Peer();
      wirePeerEvents(state.peer);
      onRoleChange(state.role, false);
    }

    if (elements.createButton) {
      elements.createButton.addEventListener("click", () => createRoom());
    }
    if (elements.joinButton) {
      elements.joinButton.addEventListener("click", () => {
        joinRoom(elements.roomInput ? elements.roomInput.value : "");
      });
    }
    if (elements.disconnectButton) {
      elements.disconnectButton.addEventListener("click", () => {
        resetToLocal("Disconnected. Back in local mode.");
      });
    }

    renderUi();

    return {
      createRoom,
      joinRoom,
      resetToLocal,
      send,
      isConnected() {
        return state.connected;
      },
      isHost() {
        return state.role === "host";
      },
      isGuest() {
        return state.role === "guest";
      },
      getRole() {
        return state.role;
      },
      getRoomCode() {
        return state.roomCode;
      },
      setStatus
    };
  };
})(window);
