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


;������Ͻ�����aero flip
SetTimer, Flip, 0


;pause��Ϊ�ܿ���
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


;��ħ�޲�����������²���ʹ�ÿ�ݼ�
#ifWinActive ahk_class Warcraft III


;��Ʒ��ݼ�
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


;���λ�������
WheelUp::
	return

WheelDown::
	return


;o���ĵ�CapsLock m���ĵ���win
CapsLock::
	send {o}
	return

Lwin::
	send {m}
	return


;��ס�Ҽ��������������㿨λ���Ĺ�֮��
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


;�ٻ�ʦ�ļ�
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



;һ������
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
���ܽ��ܣ�
1.	| F1 | F2 |			| 7 | 8 |
	| F3 | F4 |		=	| 4 | 5 |
	| F5 | F6 |			| 1 | 2 |
2.����м�			=	С����2	��F6
3.��Alt			=	С����1	��F5
4.��win			=	m
5.Ctrl+�ٻ�ʦ���ܿ�ݼ�	=	�г�����
6.CapsLock		=	o		(����ѧϰ����)
7.����s������Ҽ�		=	0.2�밴һ��s���Ҽ�	(���ڿ�λ��)
8.��������Ļ���Ͻǣ�����Windows Flip3D
������������������������������������������������������������������������
*Pause	��ͣ/����������
*������ļ����ܽ���ħ�޴�������Ч��pause���غ�Flip3Dȫ����Ч

������������������������������������������������������������������������
������������������������������������������������������������������������
�Ķ���־��
2011-09-13
���޸�Windows Flip3D��δ����UAC��Win7ϵͳ�ϵ�����
������������������������������������������������������������������������
2011-09-03
�������Զ�����Աģʽ������
������ͼ��
���������̲˵�
������������������������������������������������������������������������
2011-03-15
��ͼ���Ϊ��ɫ����win7������
��������������Ļ���Ͻǣ�����Windows Flip3D
������������������������������������������������������������������������
2011-01-26
���ı�Ľ�ϰ�ߣ�
	| F1 | F2 |			| 7 | 8 |
	| F3 | F4 |		=	| 4 | 5 |
	| F5 | F6 |			| 1 | 2 |
��Alt			=	С����1	��F5
������������������������������������������������������������������������
2011-01-16
�����ӹ��ܣ�����лdark.88��
����s������Ҽ�		=	0.2�밴һ��s���Ҽ�	(���ڿ�λ��)
������������������������������������������������������������������������
2010-12-29
�����ӹ��ܣ�
CapsLock			=	o		(����ѧϰ����)
������������������������������������������������������������������������
2010-12-21
ԭ�й���	| Q | W |			| 7 | 8 |
��Alt+	| A  | S  |		=	| 4 | 5 |
	| Z  | X  |			| 1 | 2 |
������м�			=	С����2	��Alt+x
����win			=	m
��Ctrl+�ٻ�ʦ���ܿ�ݼ�	=	�г�����

���ߣ�vivaxy
*/