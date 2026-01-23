# Kirikiri SDL2 Switch 版本 - 游戏选择界面说明

## 概述

这个版本的 Kirikiri SDL2 包含了一个游戏选择界面，允许用户选择要运行的不同游戏。

## 内置游戏

- **内置演示游戏**: Kirikiri/KAG 的介绍演示，包含完整的教程和功能展示

## 如何添加新游戏

### 1. 准备游戏数据

将你的游戏数据放在 `data/` 目录下的单独文件夹中，例如：

```
data/
├── mygame1/
│   ├── scenario/
│   ├── bgimage/
│   ├── fgimage/
│   ├── system/
│   └── startup.tjs (可选)
└── mygame2/
    └── ...
```

### 2. 修改游戏选择界面

编辑 `data/scenario/game_selector.ks` 文件，添加新的游戏选项：

```ks
; 添加新游戏选项
[link target="*start_mygame1"]我的游戏1[endlink][r]
[link target="*start_mygame1"]My Game 1[endlink][r]
[r]
```

然后添加对应的启动标签：

```ks
*start_mygame1|启动我的游戏1
@cm
正在启动我的游戏1...
@wait time=500
; 设置游戏特定的路径
Storages.clearAutoPath();
Storages.addAutoPath("mygame1/scenario/");
Storages.addAutoPath("mygame1/bgimage/");
; ... 添加其他路径
@jump storage="mygame1/start.ks"
```

### 3. 游戏数据结构

每个游戏应该有以下结构：

- `scenario/` - 包含 .ks 脚本文件
- `bgimage/` - 背景图片
- `fgimage/` - 前景图片
- `image/` - 其他图片
- `bgm/` - 背景音乐
- `sound/` - 音效
- `system/` - 系统文件（如果需要覆盖默认设置）

## 系统兼容性

- 支持最新版本的 Nintendo Switch 系统
- 使用 Atmosphere 自定义固件
- 完全兼容 Kirikiri Z 的游戏数据

## 安装说明

1. 将 `krkrsdl2.nro` 复制到 Switch SD 卡的 `sdmc:/switch/krkrsdl2/`
2. 从 hbmenu 启动应用程序
3. 在游戏选择界面中选择要运行的游戏

## 注意事项

- 游戏数据应该与 Kirikiri/KAG 3.x 兼容
- 支持 XP3 存档格式
- 自动路径解析支持游戏特定的资源文件夹
