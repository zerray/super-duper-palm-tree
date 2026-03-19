(function () {
  const canvas = document.getElementById("game");
  const ctx = canvas.getContext("2d");
  const titleOverlay = document.getElementById("title-overlay");
  const startButton = document.getElementById("start-button");
  const logBox = document.getElementById("log");
  const statsBox = document.getElementById("stats");
  const dialogue = window.NieDialogue.createController({
    box: document.getElementById("dialogue-box"),
    speaker: document.getElementById("speaker"),
    label: document.getElementById("scene-label"),
    text: document.getElementById("dialogue-text"),
    choices: document.getElementById("dialogue-choices"),
  });
  const battle = window.NieBattle.createController();

  const state = {
    scene: "title",
    mapId: "outskirts",
    player: { x: 2, y: 7, facingX: 1, facingY: 0 },
    frame: 0,
    party: window.NieBattle.createParty(),
    completedEvents: {},
    log: ["夜色渐深，宁采臣来到郭北县郊外。"],
    moveCooldown: 0,
    pendingBattle: null,
  };

  const actions = {
    ArrowUp: { x: 0, y: -1 },
    ArrowDown: { x: 0, y: 1 },
    ArrowLeft: { x: -1, y: 0 },
    ArrowRight: { x: 1, y: 0 },
    w: { x: 0, y: -1 },
    s: { x: 0, y: 1 },
    a: { x: -1, y: 0 },
    d: { x: 1, y: 0 },
  };

  function addLog(text) {
    state.log.unshift(text);
    state.log = state.log.slice(0, 7);
    logBox.innerHTML = state.log.join("<br>");
  }

  function syncStats() {
    const map = window.NieMap.getMap(state.mapId);
    statsBox.innerHTML = "";
    state.party.forEach((member) => {
      if (member.locked) {
        return;
      }
      const card = document.createElement("div");
      card.className = "stat-card";
      card.innerHTML =
        '<div class="stat-row"><strong>' + member.name + '</strong><span>' + map.name + '</span></div>' +
        '<div class="stat-row"><span>HP ' + member.hp + '/' + member.maxHp + '</span><span>MP ' + member.mp + '</span></div>';
      statsBox.appendChild(card);
    });
  }

  function unlock(effect) {
    if (effect === "ally-nie") {
      const nie = state.party.find((member) => member.id === "nie");
      const yan = state.party.find((member) => member.id === "yan");
      nie.locked = false;
      yan.locked = false;
      addLog("聂小倩与燕赤霞决定同行，共抗黑山老妖。");
      syncStats();
      return;
    }
    if (effect === "retreat") {
      addLog("宁采臣决定暂退，但终究还是回到了寺中。");
    }
  }

  function triggerDialogue(sceneId) {
    state.scene = "dialogue";
    dialogue.show(sceneId, function (effect) {
      if (effect) {
        unlock(effect);
      }
      if (sceneId === "boss-encounter") {
        startBattle("black-mountain");
        return;
      }
      if (sceneId === "forest-encounter") {
        startBattle("wandering-wisp");
        return;
      }
      if (sceneId === "ending-good") {
        state.scene = "ending";
        titleOverlay.style.display = "grid";
        titleOverlay.querySelector("h2").textContent = "故事终章";
        titleOverlay.querySelector("p").textContent = "兰若寺阴霾散尽，聂小倩的故事暂告一段落。刷新页面可重玩。";
        titleOverlay.querySelector("button").textContent = "重新开始";
        return;
      }
      state.scene = "explore";
    });
  }

  function startBattle(enemyId) {
    battle.start(enemyId, state.party);
    state.scene = "battle";
    addLog("战斗开始：" + (enemyId === "black-mountain" ? "黑山老妖" : "游魂小鬼"));
  }

  function markEvent(mapId, x, y) {
    state.completedEvents[mapId + ":" + x + ":" + y] = true;
  }

  function isEventDone(mapId, x, y) {
    return Boolean(state.completedEvents[mapId + ":" + x + ":" + y]);
  }

  function tryMove(dx, dy) {
    const map = window.NieMap.getMap(state.mapId);
    const nx = state.player.x + dx;
    const ny = state.player.y + dy;
    state.player.facingX = dx;
    state.player.facingY = dy;

    if (window.NieMap.isBlocked(map, nx, ny)) {
      addLog("前路被残墙与阴影阻住。");
      return;
    }

    state.player.x = nx;
    state.player.y = ny;

    const exit = window.NieMap.getExitAt(map, nx, ny);
    if (exit) {
      state.mapId = exit.target;
      state.player.x = exit.targetX;
      state.player.y = exit.targetY;
      addLog(exit.note);
    }

    const encounter = window.NieMap.getEncounterAt(window.NieMap.getMap(state.mapId), state.player.x, state.player.y);
    if (encounter && !isEventDone(state.mapId, state.player.x, state.player.y)) {
      markEvent(state.mapId, state.player.x, state.player.y);
      triggerDialogue(encounter.scene);
    }

    syncStats();
  }

  function interact() {
    const map = window.NieMap.getMap(state.mapId);
    const tx = state.player.x + state.player.facingX;
    const ty = state.player.y + state.player.facingY;
    const npc = window.NieMap.getNpcAt(map, tx, ty) || window.NieMap.getNpcAt(map, state.player.x, state.player.y);
    if (npc) {
      triggerDialogue(npc.scene);
      return;
    }
    addLog("四下无声，只有风吹过枯木。");
  }

  function handleBattleInput(key) {
    const actionMap = {
      "1": "attack",
      "2": "guard",
      "3": "spell",
      "4": "run",
    };
    const action = actionMap[key];
    if (!action) {
      return;
    }

    const result = battle.perform(action);
    result.log.forEach(addLog);
    syncStats();

    if (result.victory) {
      if (result.enemyName === "黑山老妖") {
        triggerDialogue("ending-good");
      } else {
        state.scene = "explore";
      }
      return;
    }

    if (result.defeat || result.escaped) {
      state.scene = "explore";
    }
  }

  function drawTitleHint() {
    if (state.scene !== "title") {
      return;
    }
    ctx.fillStyle = "rgba(0,0,0,0.48)";
    ctx.fillRect(0, 0, canvas.width, canvas.height);
  }

  function render() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    const map = window.NieMap.getMap(state.mapId);
    window.NieMap.drawMap(ctx, map, state.player, state.frame);
    if (state.scene === "battle") {
      battle.draw(ctx, canvas.width, canvas.height);
    }
    drawTitleHint();
  }

  function tick(now) {
    state.frame = now / 16.7;
    if (dialogue.isActive()) {
      dialogue.update(now);
    }
    render();
    requestAnimationFrame(tick);
  }

  document.addEventListener("keydown", function (event) {
    const key = event.key;
    if (state.scene === "title") {
      return;
    }
    if (dialogue.isActive()) {
      if (key === " " || key === "Enter") {
        event.preventDefault();
        dialogue.advance();
      }
      return;
    }
    if (state.scene === "battle") {
      handleBattleInput(key);
      return;
    }

    if (key === " " || key === "Enter") {
      event.preventDefault();
      interact();
      return;
    }

    const move = actions[key];
    if (move) {
      event.preventDefault();
      tryMove(move.x, move.y);
    }
  });

  startButton.addEventListener("click", function () {
    state.scene = "explore";
    titleOverlay.style.display = "none";
    addLog("宁采臣踏入雾夜，故事开始。");
    syncStats();
  });

  addLog(state.log[0]);
  syncStats();
  requestAnimationFrame(tick);
})();
