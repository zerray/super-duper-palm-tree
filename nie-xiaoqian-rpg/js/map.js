(function () {
  const TILE_SIZE = 48;

  const maps = {
    outskirts: {
      id: "outskirts",
      name: "郊外",
      palette: {
        skyTop: "#27435b",
        skyBottom: "#0e1622",
        mist: "rgba(180, 208, 220, 0.10)",
        groundA: "#4c5f3d",
        groundB: "#39432e",
        path: "#7d6a4f",
        lantern: "#f2cb79",
      },
      width: 14,
      height: 10,
      playerStart: { x: 2, y: 7 },
      exits: [
        { x: 12, y: 2, target: "temple", targetX: 1, targetY: 7, note: "雾气后显出兰若寺的残瓦。", once: false },
      ],
      npcs: [
        {
          id: "yan",
          x: 4,
          y: 5,
          type: "mentor",
          label: "燕赤霞",
          scene: "yan-warning",
        },
      ],
      encounters: [
        {
          x: 9,
          y: 6,
          type: "battle",
          enemy: "wandering-wisp",
          scene: "forest-encounter",
          repeatable: false,
        },
      ],
      blocked: [
        "0,0", "1,0", "2,0", "3,0", "4,0", "5,0", "6,0", "7,0", "8,0", "9,0", "10,0", "11,0", "12,0", "13,0",
        "0,1", "0,2", "0,3", "0,4", "0,5", "0,6", "0,7", "0,8", "0,9",
        "13,1", "13,2", "13,3", "13,4", "13,5", "13,6", "13,7", "13,8", "13,9",
        "1,9", "2,9", "3,9", "4,9", "5,9", "6,9", "7,9", "8,9", "9,9", "10,9", "11,9", "12,9",
        "7,3", "8,3", "8,4", "9,4"
      ],
    },
    temple: {
      id: "temple",
      name: "兰若寺",
      palette: {
        skyTop: "#1f1f33",
        skyBottom: "#090a12",
        mist: "rgba(194, 207, 239, 0.10)",
        groundA: "#55604a",
        groundB: "#414937",
        path: "#6d6156",
        lantern: "#f0d38a",
      },
      width: 14,
      height: 10,
      playerStart: { x: 1, y: 7 },
      exits: [
        { x: 1, y: 8, target: "outskirts", targetX: 11, targetY: 2, note: "你从寺门退回郊外。", once: false },
      ],
      npcs: [
        {
          id: "nie",
          x: 9,
          y: 4,
          type: "ghost",
          label: "聂小倩",
          scene: "nie-meeting",
        },
      ],
      encounters: [
        {
          x: 10,
          y: 2,
          type: "battle",
          enemy: "black-mountain",
          scene: "boss-encounter",
          repeatable: false,
        },
      ],
      blocked: [
        "0,0", "1,0", "2,0", "3,0", "4,0", "5,0", "6,0", "7,0", "8,0", "9,0", "10,0", "11,0", "12,0", "13,0",
        "0,1", "0,2", "0,3", "0,4", "0,5", "0,6", "0,7", "0,8", "0,9",
        "13,1", "13,2", "13,3", "13,4", "13,5", "13,6", "13,7", "13,8", "13,9",
        "1,9", "2,9", "3,9", "4,9", "5,9", "6,9", "7,9", "8,9", "9,9", "10,9", "11,9", "12,9",
        "4,2", "5,2", "6,2", "7,2", "4,3", "7,3", "4,4", "7,4", "4,5", "7,5", "6,6"
      ],
    },
  };

  function tileKey(x, y) {
    return x + "," + y;
  }

  function getMap(id) {
    return maps[id];
  }

  function isBlocked(map, x, y) {
    if (x < 0 || y < 0 || x >= map.width || y >= map.height) {
      return true;
    }

    return map.blocked.includes(tileKey(x, y));
  }

  function getNpcAt(map, x, y) {
    return map.npcs.find((npc) => npc.x === x && npc.y === y) || null;
  }

  function getEncounterAt(map, x, y) {
    return map.encounters.find((encounter) => encounter.x === x && encounter.y === y) || null;
  }

  function getExitAt(map, x, y) {
    return map.exits.find((exit) => exit.x === x && exit.y === y) || null;
  }

  function drawParallax(ctx, map, frame) {
    const { width, height, palette } = map;
    const sceneWidth = width * TILE_SIZE;
    const sceneHeight = height * TILE_SIZE;

    const sky = ctx.createLinearGradient(0, 0, 0, sceneHeight);
    sky.addColorStop(0, palette.skyTop);
    sky.addColorStop(1, palette.skyBottom);
    ctx.fillStyle = sky;
    ctx.fillRect(0, 0, sceneWidth, sceneHeight);

    ctx.fillStyle = palette.mist;
    for (let i = 0; i < 5; i += 1) {
      const offset = (frame * (0.2 + i * 0.08) + i * 90) % (sceneWidth + 180);
      ctx.beginPath();
      ctx.ellipse(sceneWidth - offset, 100 + i * 54, 160, 42, 0, 0, Math.PI * 2);
      ctx.fill();
    }

    ctx.fillStyle = "rgba(15, 14, 22, 0.75)";
    for (let i = 0; i < 3; i += 1) {
      ctx.beginPath();
      ctx.moveTo(i * 220, sceneHeight * 0.58);
      ctx.lineTo(100 + i * 220, sceneHeight * 0.26);
      ctx.lineTo(220 + i * 220, sceneHeight * 0.58);
      ctx.closePath();
      ctx.fill();
    }
  }

  function drawMap(ctx, map, player, frame) {
    drawParallax(ctx, map, frame);

    for (let y = 0; y < map.height; y += 1) {
      for (let x = 0; x < map.width; x += 1) {
        const px = x * TILE_SIZE;
        const py = y * TILE_SIZE;
        const isPath = map.id === "outskirts"
          ? ((y === 7 && x > 1) || (x === 12 && y < 8))
          : ((y === 7 && x > 0 && x < 12) || (x === 8 && y > 1 && y < 8));
        const shade = (x + y) % 2 === 0 ? map.palette.groundA : map.palette.groundB;
        ctx.fillStyle = isPath ? map.palette.path : shade;
        ctx.fillRect(px, py, TILE_SIZE, TILE_SIZE);
        ctx.strokeStyle = "rgba(255,255,255,0.04)";
        ctx.strokeRect(px, py, TILE_SIZE, TILE_SIZE);
      }
    }

    if (map.id === "temple") {
      ctx.fillStyle = "rgba(27, 22, 19, 0.86)";
      ctx.fillRect(4 * TILE_SIZE, 2 * TILE_SIZE, 4 * TILE_SIZE, 4 * TILE_SIZE);
      ctx.fillStyle = "#87725f";
      ctx.fillRect(5 * TILE_SIZE, 3 * TILE_SIZE, 2 * TILE_SIZE, 2 * TILE_SIZE);
      ctx.fillStyle = map.palette.lantern;
      ctx.beginPath();
      ctx.arc(6 * TILE_SIZE, 3.2 * TILE_SIZE, 8, 0, Math.PI * 2);
      ctx.fill();
    }

    map.npcs.forEach((npc) => {
      drawCharacter(ctx, npc.x, npc.y, npc.type === "ghost" ? "#d9f0ff" : "#f5c876", npc.label[0]);
    });

    drawCharacter(ctx, player.x, player.y, "#8dd0a2", "宁");

    ctx.fillStyle = "rgba(255,255,255,0.08)";
    ctx.fillRect(0, map.height * TILE_SIZE - 44, map.width * TILE_SIZE, 44);
    ctx.fillStyle = "#f7ead4";
    ctx.font = "18px serif";
    ctx.fillText("地图：" + map.name, 18, map.height * TILE_SIZE - 16);
  }

  function drawCharacter(ctx, tileX, tileY, color, glyph) {
    const px = tileX * TILE_SIZE + 10;
    const py = tileY * TILE_SIZE + 8;
    ctx.fillStyle = "rgba(0, 0, 0, 0.25)";
    ctx.beginPath();
    ctx.ellipse(px + 14, py + 28, 15, 6, 0, 0, Math.PI * 2);
    ctx.fill();
    ctx.fillStyle = color;
    ctx.fillRect(px + 6, py + 8, 16, 20);
    ctx.fillStyle = "#1a1620";
    ctx.fillRect(px + 9, py + 3, 10, 10);
    ctx.fillStyle = "#1e1722";
    ctx.font = "12px sans-serif";
    ctx.fillText(glyph, px + 9, py + 22);
  }

  window.NieMap = {
    TILE_SIZE,
    getMap,
    isBlocked,
    getNpcAt,
    getEncounterAt,
    getExitAt,
    drawMap,
  };
})();
