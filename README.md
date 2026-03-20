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

## Hex Territory Capture

新增 `hex-territory/index.html`，提供一个无需构建步骤、可直接在浏览器中打开的回合制六边形领土争夺游戏，包含：

- 约 127 格的小型六边形棋盘与 SVG 渲染
- 点击空白六边形落子，被完全包围的敌方连通块会被翻转占领
- 使用“优先最大化吃子，其次最大化己方邻接数”的贪心 AI 对手
- 棋盘填满后自动结算胜负，并支持 `New Game` 立即重开

直接用浏览器打开 `hex-territory/index.html` 即可游玩。

## Rhythm Tap Reflex

新增 `rhythm-tap/index.html`，提供一个无需构建步骤、可直接在浏览器中打开的节奏点击反应游戏，包含：

- 4 条按键轨道，使用 `D` / `F` / `J` / `K` 击打下落音符
- 连击、分数、失误与速度实时显示
- 基于 `requestAnimationFrame` 的音符滚动与程序化节拍生成
- 使用 Web Audio API 振荡器生成 hit / miss 音效
- 随时间提升滚动速度与音符密度，失误达到上限后显示结算界面

直接用浏览器打开 `rhythm-tap/index.html` 即可游玩。

## Orbital Slingshot

新增 `slingshot-game/index.html`，提供一个无需构建步骤、可直接在浏览器中打开的重力弹弓物理玩具，包含：

- 每关至少 3 个引力星体与可视化 gravity well
- 点击拖拽瞄准发射，飞船实时受行星引力影响
- 发射前提供 ghost trajectory 预览线，发射后保留完整飞行轨迹
- 命中右侧目标区域后自动进入下一关，并增加场上星体数量

直接用浏览器打开 `slingshot-game/index.html` 即可游玩。

## Gravity Slingshot Orbiter

新增 `gravity-slingshot/index.html`，提供一个无需构建步骤、可直接在浏览器中打开的引力弹弓轨道收集玩具，包含：

- 3 到 7 个程序化生成的行星 / 卫星与可视化重力扭曲网格
- 点击拖拽瞄准发射，飞船以 60fps 牛顿引力模拟飞行并留下彩色轨迹
- 分布在星系中的水晶收集目标、剩余数量统计与发射次数统计
- 飞船撞击星体、飞出画面或手动点击 `Reset System` 时立即重置当前局面

直接用浏览器打开 `gravity-slingshot/index.html` 即可游玩。

## Gem Mine Clicker

新增 `gem-mine-clicker/index.html`，提供一个无需构建步骤、可直接在浏览器中打开的 idle gem mine clicker，包含：

- 点击矿脉获取宝石，并带有粒子爆裂与飘字反馈
- 4 种可购买升级，分别强化点击收益与被动产出
- 基于 `requestAnimationFrame` 的挂机收益与动画循环
- Prestige 重置机制，重开后获得永久倍率提升
- 使用 `localStorage` 持久化保存当前进度

直接用浏览器打开 `gem-mine-clicker/index.html` 即可游玩。

## Hex Chain Reaction

新增 `hex-chain-reaction/index.html`，提供一个无需构建步骤、可直接在浏览器中打开的六边形连锁反应策略游戏，包含：

- 默认 7x7 的 SVG 六边形棋盘，使用轴坐标与 `Map` 保存格子状态
- 双人热座模式：只能点击空格或己方格子落子
- 当 token 数量超过该格实际邻居数时触发爆裂，并以短延迟逐步播放连锁反应
- 当前玩家提示、重新开始按钮，以及一方占据所有已占用格子后的胜利结算

直接用浏览器打开 `hex-chain-reaction/index.html` 即可游玩。

## Kaleidoscope Drawing Toy

新增 `kaleidoscope/index.html`，提供一个无需构建步骤、可直接在浏览器中打开的万花筒绘画玩具，包含：

- 鼠标或触摸绘制的自由线条会实时按 N 条对称轴旋转并镜像复制
- 可调节 symmetry（3-12）、笔刷粗细、描边颜色与背景颜色
- `Clear` 清空画布，`Export PNG` 导出当前作品

直接用浏览器打开 `kaleidoscope/index.html` 即可运行。

## Pixel Biome Terrarium

新增 `pixel-biome-terrarium/index.html`，提供一个无需构建步骤、可直接在浏览器中打开的像素生态箱模拟器，包含：

- 64x64 网格 Canvas，区分空地、草、食草动物与捕食者
- 持续运行的生态演化：草扩散、移动觅食、能量消耗、繁殖与死亡
- 实时种群折线图，追踪草、食草动物、捕食者数量变化
- 点击投放食物或生成生物，并可切换降雨来提升草生长速度
- Tick 速度滑块，可在单个浏览器标签页内持续观察系统波动

直接用浏览器打开 `pixel-biome-terrarium/index.html` 即可运行。

## Gravity Well Sandbox

新增 `gravity-well/index.html`，提供一个无需构建步骤、可直接在浏览器中打开的重力井物理沙盒，包含：

- 左键放置 attractor、右键放置 repulsor，并实时影响粒子轨迹
- 可调节 gravity strength、particle spawn rate、trail length
- 基于粒子速度的 HSL 彩色拖尾、清空重置与 PNG 导出

直接用浏览器打开 `gravity-well/index.html` 即可运行。

## Particle Life Explorer

新增 `particle-life/index.html`，提供一个无需构建步骤、可直接在浏览器中打开的粒子生命生成艺术玩具，包含：

- 360 个粒子与 5 种颜色 species，基于 attraction / repulsion 矩阵实时演化
- 可拖拽调节的 5x5 交互矩阵，以及 `Randomize Rules` / `Reset Particles` 控制
- `Wrap Edges` 与 `Bounce Walls` 边界模式切换
- Canvas 2D 发光粒子与半透明残影效果，便于观察聚团、链状与细胞样结构

直接用浏览器打开 `particle-life/index.html` 即可运行。

## Gravity Golf

新增 `gravity-golf/index.html`，提供一个无需构建步骤、可直接在浏览器中打开的轨道迷你高尔夫游戏，包含：

- 5 个固定关卡，逐步引入 attractor、repulsor、orbiting planet、gravity toggle 与 black hole hazard
- 点击并向后拖拽小球发射，发射前会显示 dotted trajectory preview
- 基于简单 Newtonian inverse-square gravity 的 Canvas 2D 物理模拟
- 每洞与总计 stroke counter、进洞后的视觉 / 音频提示，以及下一洞流程

直接用浏览器打开 `gravity-golf/index.html` 即可游玩。

## Hex Color Idle Factory

新增 `hex-color-idle-factory/index.html`，提供一个无需构建步骤、可直接在浏览器中打开的颜色混合 idle factory，包含：

- 红、绿、蓝三条主色生产线，基于时间自动累积资源
- 选择两条主色流解锁紫、黄、青等二级混色产线
- 至少 3 种可购买升级，按指数成本曲线提升产出效率
- 订单传送带系统，完成发货后获得全局生产倍率奖励
- 使用 `localStorage` 持久化保存进度，并适配移动端窄屏布局

直接用浏览器打开 `hex-color-idle-factory/index.html` 即可游玩。

## Pixel Pulse Sequencer

新增 `pixel-pulse-sequencer/index.html`，提供一个无需构建步骤、可直接在浏览器中打开的像素步进音序器玩具，包含：

- 8x16 可点击网格，按行映射 5 条音色与 3 条打击乐
- 自动循环播放头，使用 Web Audio API 提前调度触发以减少抖动
- 60 到 180 BPM 实时调速、波形切换、主题切换与一键清空
- 激活格在播放头经过时会发光脉冲

直接用浏览器打开 `pixel-pulse-sequencer/index.html` 即可运行。

## Soundscape Garden

新增 `soundscape-garden/index.html`，提供一个无需构建步骤、可直接在浏览器中打开的生成式音景花园，包含：

- 点击 SVG 花园放置 4 种不同花朵，每种花朵拥有独立视觉造型与 Web Audio 音色
- 邻近花朵会通过音量、声像与轻微 detune 互相影响，形成持续演化的环境音乐
- Tempo、scale、reverb / delay 全局控制，以及基于 `localStorage` 的花园持久化

直接用浏览器打开 `soundscape-garden/index.html` 即可运行。左键种植，右键移除花朵。
