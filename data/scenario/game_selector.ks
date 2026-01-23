*game_selector_start|游戏选择界面
@startanchor

; 设置背景
@backlay
@loadbg storage="_24_5" page=back
@current page=back
@cm
@layopt layer=message0 page=back visible=true
@nowait
@history output=false
@style align=center
[font size=40 color=0x00ffff]Kirikiri SDL2[resetfont][r]
[font size=20 color=0x00ffff]游戏选择界面[resetfont][r]
[r]
请选择要运行的游戏：[r]
[r]

; 内置演示游戏
[link target="*start_demo"]内置演示游戏[endlink][r]
[link target="*start_demo"]Kirikiri/KAG 介绍演示[endlink][r]
[r]

; 这里可以添加更多游戏选项
; [link target="*start_game2"]游戏2[endlink][r]
; [link target="*start_game3"]游戏3[endlink][r]

[r]
[link exp="kag.shutdown()" color=0xff0000 hint="退出 Kirikiri SDL2"]退出[endlink]

@endnowait
@history output=true
@current page=fore

; 过渡效果
@trans method=crossfade time=800
@wt

; 记录位置
@record

; 等待选择
@s

*start_demo|启动演示游戏
@cm
正在启动演示游戏...
@wait time=500
; 跳转到演示脚本的开始标签
@jump storage="first.ks" target="*syokai_start"

; 这里可以添加其他游戏的启动代码
; *start_game2
; @cm
; 正在启动游戏2...
; @wait time=500
; @jump storage="game2/first.ks"

; *start_game3
; @cm
; 正在启动游戏3...
; @wait time=500
; @jump storage="game3/start.ks"