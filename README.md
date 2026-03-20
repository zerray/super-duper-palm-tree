# Agent Factory

This repository contains a simple agent-factory workflow for planning and completing repository tasks with Claude and Codex agents.

## Conway's Game of Life

新增 `game-of-life/index.html`，提供一个可直接在浏览器中打开的康威生命游戏模拟器，包含：

- 可缩放、可平移的大型 Canvas 网格
- 点击或拖拽绘制/擦除细胞
- 播放、暂停、单步、随机填充、清空等控制
- 经典图案下拉菜单，可放置 Glider、Pulsar、Gosper Glider Gun 等种子

直接用浏览器打开 `game-of-life/index.html` 即可运行。

## 聂小倩 HD-2D RPG

新增 `nie-xiaoqian-rpg/index.html`，提供一个可直接在浏览器中打开的轻量 RPG 原型，包含：

- 郊外、兰若寺两张地图探索
- 聂小倩、燕赤霞相关剧情对话
- 小鬼伏击与黑山老妖两场回合制战斗

直接用浏览器打开 `nie-xiaoqian-rpg/index.html` 即可游玩。方向键或 `WASD` 移动，`Enter` / 空格确认或推进对话。

## Typing Speed Test

新增 `typing-speed-test/index.html`，提供一个无需构建步骤、可直接在浏览器中运行的打字速度测试，包含：

- 至少 15 段内置英文短文，随机抽取进行测试
- 实时 WPM、准确率、计时与错误数统计
- 逐字符高亮显示：正确为绿色、错误为红色、未输入为灰色
- 完成后结果弹层，以及重试当前段落或切换新段落
- 使用 `localStorage` 保存并展示个人最佳 WPM

直接用浏览器打开 `typing-speed-test/index.html` 即可开始测试。

## Pixel Landscape Generator

新增 `pixel-landscape/index.html`，提供一个无需构建步骤、可直接在浏览器中打开的程序化像素风景生成器，包含：

- 基于 seeded RNG 与 1D 噪声生成的山体、丘陵、水线与云层
- 通过滑块调整 biome、time of day 与 palette variant，并即时重绘
- `Regenerate` 生成新种子场景，`Export PNG` 导出当前画面

直接用浏览器打开 `pixel-landscape/index.html` 即可运行。

## Sound Palette

新增 `sound-palette/index.html`，提供一个无需构建步骤、可直接在浏览器中打开的音乐步进音序器玩具，包含：

- 8x8 可点击网格，可逐格开关音符
- 自动循环的播放头，会按列触发当前激活节点
- 基于 Web Audio API 振荡器的五声音阶音高映射
- BPM 滑块调速、节点触发高亮，以及一键清空

直接用浏览器打开 `sound-palette/index.html` 即可运行。

## Sokoban Warehouse

新增 `sokoban-game/index.html`，提供一个无需构建步骤、可直接在浏览器中打开的 Sokoban 推箱子游戏，包含：

- 10 个逐步加难的内置关卡与关卡选择
- 键盘方向键 / `WASD` 移动，`Z` 撤销上一步
- Canvas 渲染、步数统计、通关提示与已解锁关卡持久化

直接用浏览器打开 `sokoban-game/index.html` 即可游玩。

## Gem Mine Clicker

新增 `gem-mine-clicker/index.html`，提供一个无需构建步骤、可直接在浏览器中打开的放置点击游戏，包含：

- 点击矿石获得宝石，并带有粒子爆裂与飘字反馈
- 可购买的点击与自动采矿升级，产量会持续指数增长
- `requestAnimationFrame` 驱动的挂机收益、Prestige 重生倍率与 `localStorage` 存档

直接用浏览器打开 `gem-mine-clicker/index.html` 即可游玩。
