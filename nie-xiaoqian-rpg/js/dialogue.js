(function () {
  const scenes = {
    "yan-warning": {
      label: "郊外",
      steps: [
        { speaker: "燕赤霞", text: "前方就是兰若寺。夜里有鬼魅出没，你若执意前去，须先定住心神。" },
        {
          speaker: "燕赤霞",
          text: "遇见貌美而神色凄然的女子，先别急着逃。她未必害你，真正作恶的另有其人。",
        },
      ],
    },
    "forest-encounter": {
      label: "薄雾",
      steps: [
        { speaker: "旁白", text: "郊外阴风乍起，一只小鬼从雾里扑来。宁采臣只得提灯应战。" },
      ],
    },
    "nie-meeting": {
      label: "兰若寺",
      steps: [
        { speaker: "聂小倩", text: "公子，你不该留在这里。姥姥逼我诱人害命，可我早已厌倦这般日子。" },
        {
          speaker: "宁采臣",
          text: "若你并非恶鬼，我愿助你脱困。黑山老妖在何处？",
        },
        {
          speaker: "聂小倩",
          text: "他潜伏在寺后阴殿，若得燕赤霞相助，也许能破此劫。",
          choices: [
            { text: "答应相助", effect: "ally-nie" },
            { text: "先行退避", effect: "retreat" },
          ],
        },
      ],
    },
    "boss-encounter": {
      label: "阴殿",
      steps: [
        { speaker: "旁白", text: "地脉震动，黑山老妖的影子吞没残殿。聂小倩与燕赤霞同时现身，决定联手一战。" },
      ],
    },
    "ending-good": {
      label: "尾声",
      steps: [
        { speaker: "旁白", text: "黑山老妖溃散，兰若寺的阴气逐渐散去。聂小倩得以摆脱束缚，含笑向宁采臣告别。" },
      ],
    },
  };

  function createController(elements) {
    let state = null;

    function hide() {
      state = null;
      elements.box.hidden = true;
      elements.choices.innerHTML = "";
    }

    function show(sceneId, onComplete) {
      const scene = scenes[sceneId];
      if (!scene) {
        hide();
        if (onComplete) {
          onComplete(null);
        }
        return;
      }

      state = {
        scene,
        index: 0,
        visibleChars: 0,
        lastTick: 0,
        completed: false,
        onComplete,
      };
      elements.box.hidden = false;
      render();
    }

    function update(now) {
      if (!state || state.completed) {
        return;
      }

      const step = state.scene.steps[state.index];
      if (!step) {
        return;
      }

      if (state.visibleChars < step.text.length && now - state.lastTick > 22) {
        state.visibleChars += 1;
        state.lastTick = now;
        render();
      }
    }

    function advance(choiceEffect) {
      if (!state) {
        return;
      }

      const step = state.scene.steps[state.index];
      if (step && state.visibleChars < step.text.length) {
        state.visibleChars = step.text.length;
        render();
        return;
      }

      if (typeof choiceEffect !== "undefined") {
        finish(choiceEffect);
        return;
      }

      state.index += 1;
      state.visibleChars = 0;
      state.lastTick = 0;

      if (state.index >= state.scene.steps.length) {
        finish(null);
        return;
      }

      render();
    }

    function finish(effect) {
      const callback = state && state.onComplete;
      hide();
      if (callback) {
        callback(effect);
      }
    }

    function render() {
      if (!state) {
        return;
      }

      const step = state.scene.steps[state.index];
      elements.speaker.textContent = step.speaker;
      elements.label.textContent = state.scene.label;
      elements.text.textContent = step.text.slice(0, state.visibleChars);
      elements.choices.innerHTML = "";

      if (state.visibleChars >= step.text.length && step.choices) {
        step.choices.forEach((choice) => {
          const button = document.createElement("button");
          button.type = "button";
          button.textContent = choice.text;
          button.addEventListener("click", function () {
            advance(choice.effect);
          });
          elements.choices.appendChild(button);
        });
      }
    }

    return {
      show,
      hide,
      update,
      advance,
      isActive: function () {
        return Boolean(state);
      },
    };
  }

  window.NieDialogue = {
    createController,
  };
})();
