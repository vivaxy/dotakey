;;	Made By Vivaxy
;;	12-09-2011

If !A_IsAdmin
{
	Run, *RunAs "%A_ScriptFullPath%", , UseErrorLevel, 
	ExitApp
}

version = 1.6

#SingleInstance force
#HotkeyInterval 0
#MaxThreads 255
#InstallKeybdHook
#InstallMouseHook
#UseHook On
SetKeyDelay , -1, -1
SetBatchLines, -1
CoordMode, Mouse, Screen


Menu, Tray, NoStandard
Menu, Tray, Tip, DotAKey %version%
Menu, Tray, Add, Pause/Resume, PPause
Menu, Tray, Add
Menu, Tray, Add, Exit, Exit


kaiguan := true


;鼠标左上角启用aero flip
SetTimer, Flip, 0


;pause键为总开关
pause::
	suspend permit
	if (kaiguan == false)
	{
		suspend toggle
		kaiguan := true
		SoundPlay *48
	}
	else
	{
		suspend toggle
		kaiguan := false
		SoundPlay *64
	}
	return


;在魔兽不启动的情况下不会使用快捷键
#ifWinActive ahk_class Warcraft III


;物品快捷键
F1::
	send {Numpad7}
	return

F2::
	send {Numpad8}
	return

F3::
	send {Numpad4}
	return

F4::
	send {Numpad5}
	return

F5::
	send {Numpad1}
	return

F6::
	send {Numpad2}
	return

Alt::
	send {Numpad1}
	return

Mbutton::
	send {Numpad2}
	return


;屏蔽滑轮上下
WheelUp::
	return

WheelDown::
	return


;o键改到CapsLock m键改到左win
CapsLock::
	send {o}
	return

Lwin::
	send {m}
	return


;按住右键会持续点击，方便卡位，幽鬼之径
$s::
	Loop
	{
		if not GetKeyState("s","P")
		break
		send s
		sleep 200
	}
	return

$RButton::
	Loop
	{
		if not GetKeyState("RButton","P")
		break
		send {Click right}
		sleep 200
	}
	return


;召唤师改键
^Y::
	Send {q}{q}{q}{r}
	return

^V::
	Send {q}{q}{w}{r}
	return

^X::
	Send {w}{w}{q}{r}
	return

^D::
	Send {e}{e}{w}{r}
	return

^B::
	Send {q}{w}{e}{r}
	return

^F::
	Send {e}{e}{q}{r}
	return

^T::
	Send {e}{e}{e}{r}
	return

^C::
	Send {w}{w}{w}{r}
	return

^Z::
	Send {w}{w}{e}{r}
	return

^G::
	Send {q}{q}{e}{r}
	return

^Q::
	Send {q}{q}{q}
	return

^W::
	Send {w}{w}{w}
	return

^E::
	Send {e}{e}{e}
	return



;一键喊话
!1::
	temp = %clipboard%
	clipboard = -refresh
	Send {Enter}
	Send ^v
	Sleep 100
	Send {Enter}
	clipboard = %temp%
	return

!2::
	temp = %clipboard%
	clipboard = whosyourdaddy
	Send {Enter}
	Send ^v
	Sleep 100
	Send {Enter}
	clipboard = %temp%
	return


Flip:
	If WinActive("ahk_class Flip3D") or WinActive("ahk_class Warcraft III") or !kaiguan
	return
	else
	{
		MouseGetPos, mouseX, mouseY
		pst := mouseX*mouseX+mouseY*mouseY
		If (pst<40)
		{
			Run rundll32.exe dwmapi #105
		}
	}
	return


PPause:
	suspend permit
	if (kaiguan == false)
	{
		suspend toggle
		kaiguan := true
		SoundPlay *48
	}
	else
	{
		suspend toggle
		kaiguan := false
		SoundPlay *64
	}
	return


Exit:
	ExitApp


/*
功能介绍：
1.	| F1 | F2 |			| 7 | 8 |
	| F3 | F4 |		=	| 4 | 5 |
	| F5 | F6 |			| 1 | 2 |
2.鼠标中键			=	小键盘2	即F6
3.左Alt			=	小键盘1	即F5
4.左win			=	m
5.Ctrl+召唤师技能快捷键	=	切出技能
6.CapsLock		=	o		(便于学习技能)
7.长按s或鼠标右键		=	0.2秒按一次s或右键	(便于卡位等)
8.鼠标放在屏幕左上角，开启Windows Flip3D
————————————————————————————————————
*Pause	暂停/启动本程序
*本软件改键功能仅在魔兽窗口下有效，pause开关和Flip3D全局有效

————————————————————————————————————
————————————————————————————————————
改动日志：
2011-09-13
·修复Windows Flip3D在未开启UAC的Win7系统上的问题
————————————————————————————————————
2011-09-03
·增加自动管理员模式下运行
·完善图标
·完善托盘菜单
————————————————————————————————————
2011-03-15
·图标改为白色，与win7更契合
·增加鼠标放在屏幕左上角，开启Windows Flip3D
————————————————————————————————————
2011-01-26
·改变改建习惯：
	| F1 | F2 |			| 7 | 8 |
	| F3 | F4 |		=	| 4 | 5 |
	| F5 | F6 |			| 1 | 2 |
左Alt			=	小键盘1	即F5
————————————————————————————————————
2011-01-16
·增加功能：【感谢dark.88】
长按s或鼠标右键		=	0.2秒按一次s或右键	(便于卡位等)
————————————————————————————————————
2010-12-29
·增加功能：
CapsLock			=	o		(便于学习技能)
————————————————————————————————————
2010-12-21
原有功能	| Q | W |			| 7 | 8 |
·Alt+	| A  | S  |		=	| 4 | 5 |
	| Z  | X  |			| 1 | 2 |
·鼠标中键			=	小键盘2	即Alt+x
·左win			=	m
·Ctrl+召唤师技能快捷键	=	切出技能

作者：vivaxy
*/