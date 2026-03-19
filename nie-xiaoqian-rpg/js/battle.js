(function () {
  const enemyCatalog = {
    "wandering-wisp": {
      name: "游魂小鬼",
      hp: 36,
      maxHp: 36,
      attack: 9,
      speed: 8,
      color: "#88d7e8",
    },
    "black-mountain": {
      name: "黑山老妖",
      hp: 90,
      maxHp: 90,
      attack: 14,
      speed: 6,
      color: "#d17373",
    },
  };

  function createParty() {
    return [
      { id: "ning", name: "宁采臣", hp: 60, maxHp: 60, mp: 12, attack: 11, speed: 7, guard: false },
      { id: "nie", name: "聂小倩", hp: 44, maxHp: 44, mp: 18, attack: 12, speed: 10, guard: false, locked: true },
      { id: "yan", name: "燕赤霞", hp: 72, maxHp: 72, mp: 16, attack: 15, speed: 9, guard: false, locked: true },
    ];
  }

  function createController() {
    let state = null;

    function start(enemyId, party, options) {
      state = {
        enemy: Object.assign({}, enemyCatalog[enemyId]),
        party: party,
        turn: 0,
        options: options || {},
      };
    }

    function isActive() {
      return Boolean(state);
    }

    function activeMembers() {
      return state.party.filter((member) => !member.locked && member.hp > 0);
    }

    function perform(action) {
      if (!state) {
        return { done: false, log: [] };
      }

      const logs = [];
      const actors = activeMembers().map((member) => ({ side: "party", unit: member }));
      actors.push({ side: "enemy", unit: state.enemy });
      actors.sort((a, b) => b.unit.speed - a.unit.speed);

      activeMembers().forEach((member) => {
        member.guard = false;
      });

      actors.forEach((actor) => {
        if (state.enemy.hp <= 0) {
          return;
        }

        if (actor.side === "party") {
          if (actor.unit.hp <= 0) {
            return;
          }
          if (action === "guard") {
            actor.unit.guard = true;
            logs.push(actor.unit.name + "摆出防御架势。");
            return;
          }
          if (action === "spell" && actor.unit.mp >= 4) {
            actor.unit.mp -= 4;
            const amount = actor.unit.attack + 6;
            state.enemy.hp = Math.max(0, state.enemy.hp - amount);
            logs.push(actor.unit.name + "施放清心咒，造成" + amount + "点伤害。");
            return;
          }

          const damage = actor.unit.attack + state.turn + (actor.unit.id === "yan" ? 2 : 0);
          state.enemy.hp = Math.max(0, state.enemy.hp - damage);
          logs.push(actor.unit.name + "攻击" + state.enemy.name + "，造成" + damage + "点伤害。");
          return;
        }

        const targets = activeMembers();
        if (targets.length === 0) {
          return;
        }

        const target = targets[state.turn % targets.length];
        const baseDamage = Math.max(5, state.enemy.attack - (target.guard ? 5 : 0));
        target.hp = Math.max(0, target.hp - baseDamage);
        logs.push(state.enemy.name + "反击" + target.name + "，造成" + baseDamage + "点伤害。");
      });

      state.turn += 1;

      const allDown = activeMembers().length === 0;
      const enemyDown = state.enemy.hp <= 0;
      if (action === "run" && state.enemy.name !== "黑山老妖") {
        state = null;
        return { done: true, escaped: true, log: ["宁采臣趁乱退回安全处。"] };
      }

      if (enemyDown) {
        const enemyName = state.enemy.name;
        state = null;
        return { done: true, victory: true, enemyName: enemyName, log: logs.concat(enemyName + "被击退。") };
      }

      if (allDown) {
        state = null;
        return { done: true, defeat: true, log: logs.concat("众人力竭倒地。") };
      }

      return { done: false, log: logs };
    }

    function draw(ctx, width, height) {
      if (!state) {
        return;
      }

      ctx.fillStyle = "rgba(0, 0, 0, 0.52)";
      ctx.fillRect(0, 0, width, height);

      const gradient = ctx.createLinearGradient(0, 0, width, height);
      gradient.addColorStop(0, "#1d1622");
      gradient.addColorStop(1, "#08090d");
      ctx.fillStyle = gradient;
      ctx.fillRect(48, 48, width - 96, height - 96);

      ctx.strokeStyle = "rgba(241, 209, 138, 0.4)";
      ctx.strokeRect(48, 48, width - 96, height - 96);

      ctx.fillStyle = state.enemy.color;
      ctx.beginPath();
      ctx.ellipse(width - 250, 210, 86, 110, 0, 0, Math.PI * 2);
      ctx.fill();
      ctx.fillStyle = "#f8ead6";
      ctx.font = "28px serif";
      ctx.fillText(state.enemy.name, width - 340, 110);
      ctx.font = "20px serif";
      ctx.fillText("HP " + state.enemy.hp + "/" + state.enemy.maxHp, width - 340, 140);

      activeMembers().forEach((member, index) => {
        const y = 170 + index * 110;
        ctx.fillStyle = index === 0 ? "#8dd0a2" : index === 1 ? "#d7efff" : "#f1c876";
        ctx.fillRect(130, y, 48, 64);
        ctx.fillStyle = "#f8ead6";
        ctx.font = "22px serif";
        ctx.fillText(member.name, 200, y + 24);
        ctx.font = "18px serif";
        ctx.fillText("HP " + member.hp + "/" + member.maxHp + "  MP " + member.mp, 200, y + 52);
      });

      ctx.font = "20px serif";
      ctx.fillText("操作：1 攻击  2 防御  3 法术  4 逃跑", 120, height - 72);
    }

    return {
      start,
      perform,
      draw,
      isActive,
    };
  }

  window.NieBattle = {
    createParty,
    createController,
  };
})();
