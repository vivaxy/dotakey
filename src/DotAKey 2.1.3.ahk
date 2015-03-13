;;DotAKey
;;Made by Vivaxy
;;AutoHotKey

m_Date = 03-11-2011

m_Version = 2.1.3

If !A_IsAdmin
{
	Run, *RunAs "%A_ScriptFullPath%", , UseErrorLevel, 
	ExitApp
}

#SingleInstance Force
#MaxThreads 255
#HotkeyInterval 0
#InstallKeybdHook
#InstallMouseHook
#UseHook On
#NoEnv
Process, Priority, , High
SetKeyDelay, -1, -1,
SetBatchLines, -1
CoordMode, Mouse, Screen

m_Switch := True

Gosub, M_Load

Gosub, M_Menu

SetTimer, O_Flip, 200

SetTimer, M_CheckIME, 200

Gosub, M_Main

Pause::
	Suspend
	If (m_Switch = False)
	{
		m_Switch := True
		SoundPlay *48
		Menu, Tray, Rename, Resume, Pause
	}
	Else
	{
		m_Switch := False
		SoundPlay *64
		Menu, Tray, Rename, Pause, Resume
	}
	Return

Return



M_Main:
	#If (m_CheckIME = "0" and WinActive("ahk_class Warcraft III"))
	{
		If (i_Enable = "1")
		{
			If (i_Inventory1 != "")
				Hotkey, %i_Inventory1%, I_Inventory1
			If (i_Inventory2 != "")
				Hotkey, %i_Inventory2%, I_Inventory2
			If (i_Inventory3 != "")
				Hotkey, %i_Inventory3%, I_Inventory3
			If (i_Inventory4 != "")
				Hotkey, %i_Inventory4%, I_Inventory4
			If (i_Inventory5 != "")
				Hotkey, %i_Inventory5%, I_Inventory5
			If (i_Inventory6 != "")
				Hotkey, %i_Inventory6%, I_Inventory6
		}
		If (r_Enable = "1")
		{
			If (r_RemapTo1 != "")
			{
				If (r_RemapFrom1 = "")
					Hotkey, %r_RemapTo1%, M_DisableKey
				Else
					Hotkey, %r_RemapTo1%, R_Remap1
			}
			If (r_RemapTo2 != "")
			{
				If (r_RemapFrom2 = "")
					Hotkey, %r_RemapTo2%, M_DisableKey
				Else
					Hotkey, %r_RemapTo2%, R_Remap2
			}
				If (r_RemapTo3 != "")
			{
				If (r_RemapFrom3 = "")
					Hotkey, %r_RemapTo3%, M_DisableKey
				Else
					Hotkey, %r_RemapTo3%, R_Remap3
			}
			If (r_RemapTo4 != "")
			{
				If (r_RemapFrom4 = "")
					Hotkey, %r_RemapTo4%, M_DisableKey
				Else
					Hotkey, %r_RemapTo4%, R_Remap4
			}
			If (r_RemapTo5 != "")
			{
				If (r_RemapFrom5 = "")
					Hotkey, %r_RemapTo5%, M_DisableKey
				Else
					Hotkey, %r_RemapTo5%, R_Remap5
			}
			If (r_RemapTo6 != "")
			{
				If (r_RemapFrom6 = "")
					Hotkey, %r_RemapTo6%, M_DisableKey
				Else
					Hotkey, %r_RemapTo6%, R_Remap6
			}
		}
		If (n_Enable = "1")
		{
			Hotkey, ^Y, N_Y
			Hotkey, ^V, N_V
			Hotkey, ^X, N_X
			Hotkey, ^D, N_D
			Hotkey, ^B, N_B
			Hotkey, ^F, N_F
			HotKey, ^T, N_T
			Hotkey, ^C, N_C
			Hotkey, ^Z, N_Z
			Hotkey, ^G, N_G
			Hotkey, ^Q, N_Q
			Hotkey, ^W, N_W
			Hotkey, ^E, N_E
		}
		If (e_Enable = "1")
		{
			If (e_Hotkey1 != "")
			{
				If (e_Message1 = "")
					Hotkey, %e_Hotkey1%, M_DisableKey
				Else
					Hotkey, %e_Hotkey1%, E_Message1
			}
			If (e_Hotkey2 != "")
			{
				If (e_Message2 = "")
					Hotkey, %e_Hotkey2%, M_DisableKey
				Else
					Hotkey, %e_Hotkey2%, E_Message2
			}
			If (e_Hotkey3 != "")
			{
				If (e_Message3 = "")
					Hotkey, %e_Hotkey3%, M_DisableKey
				Else
					Hotkey, %e_Hotkey3%, E_Message3
			}
			If (e_Hotkey4 != "")
			{
				If (e_Message4 = "")
					Hotkey, %e_Hotkey4%, M_DisableKey
				Else
					Hotkey, %e_Hotkey4%, E_Message4
			}
		}
		If (o_EnableDiablo = "1")
		{
			Hotkey, S, O_S
			Hotkey, RButton, O_RButton
		}
	}
	Return


M_Menu:
	Menu, Tray, NoStandard
	Menu, Tray, Tip, DotAKey %m_Version%
	Menu, Tray, Add, Configuration, M_Configuration
	Menu, Tray, Default, Configuration
	Menu, Tray, Click, 1
	Menu, Tray, Add
	Menu, Tray, Add, Pause, Pause
	Menu, Tray, Add
	Menu, Tray, Add, Reload, M_Reload
	Menu, Tray, Add, Exit, M_Exit
	If (o_EnableTrayTip = "1")
		TrayTip, DotAKey, DotAKey %m_Version%, , 4
	Return


M_Save:
	Gui, Submit
	IniWrite, %i_Enable%, %A_WorkingDir%\DotAKey.ini, Inventory, EnableInventory
	Loop 6
	{
		m_IniWrite1 := i_Inventory%A_Index%
		IniWrite, %m_IniWrite1%, %A_WorkingDir%\DotAKey.ini, Inventory, Inventory%A_Index%
	}
	IniWrite, %r_Enable%, %A_WorkingDir%\DotAKey.ini, Remap, EnableRemap
	Loop 6
	{
		m_IniWrite1 := r_RemapFrom%A_Index%
		m_IniWrite2 := r_RemapTo%A_Index%
		IniWrite, %m_IniWrite1%, %A_WorkingDir%\DotAKey.ini, Remap, RemapFrom%A_Index%
		IniWrite, %m_IniWrite2%, %A_WorkingDir%\DotAKey.ini, Remap, RemapTo%A_Index%
	}
	IniWrite, %n_Enable%, %A_WorkingDir%\DotAKey.ini, Invoker, EnableInvoker
	IniWrite, %e_Enable%, %A_WorkingDir%\DotAKey.ini, Message, EnableMessage
	Loop 6
	{
		m_IniWrite1 := e_Message%A_Index%
		m_IniWrite2 := e_Hotkey%A_Index%
		m_IniWrite3 := e_ToAll%A_Index%
		IniWrite, %m_IniWrite1%, %A_WorkingDir%\DotAKey.ini, Message, Message%A_Index%
		IniWrite, %m_IniWrite2%, %A_WorkingDir%\DotAKey.ini, Message, Hotkey%A_Index%
		IniWrite, %m_IniWrite3%, %A_WorkingDir%\DotAKey.ini, Message, ToAll%A_Index%
	}
	IniWrite, %o_EnableFlip%, %A_WorkingDir%\DotAKey.ini, Other, EnableFlip
	IniWrite, %o_EnableDiablo%, %A_WorkingDir%\DotAKey.ini, Other, EnableDiablo
	IniWrite, %o_DiabloPer%, %A_WorkingDir%\DotAKey.ini, Other, DiabloPerMS
	IniWrite, %o_EnableTrayTip%, %A_WorkingDir%\DotAKey.ini, Other, EnableToolTip
	Gosub, M_Reload
	Return


M_Load:
	IniRead, i_Enable, %A_WorkingDir%\DotAKey.ini, Inventory, EnableInventory, 1
	IniRead, i_Inventory1, %A_WorkingDir%\DotAKey.ini, Inventory, Inventory1, F1
	IniRead, i_Inventory2, %A_WorkingDir%\DotAKey.ini, Inventory, Inventory2, F2
	IniRead, i_Inventory3, %A_WorkingDir%\DotAKey.ini, Inventory, Inventory3, F3
	IniRead, i_Inventory4, %A_WorkingDir%\DotAKey.ini, Inventory, Inventory4, F4
	IniRead, i_Inventory5, %A_WorkingDir%\DotAKey.ini, Inventory, Inventory5, Alt
	IniRead, i_Inventory6, %A_WorkingDir%\DotAKey.ini, Inventory, Inventory6, Mbutton
	Loop 6
	{
		If (i_Inventory%A_Index% = "ERROR")
			i_Inventory%A_Index% := A_Space
	}
	IniRead, r_Enable, %A_WorkingDir%\DotAKey.ini, Remap, EnableRemap, 1
	IniRead, r_RemapFrom1, %A_WorkingDir%\DotAKey.ini, Remap, RemapFrom1, O
	IniRead, r_RemapFrom2, %A_WorkingDir%\DotAKey.ini, Remap, RemapFrom2, M
	IniRead, r_RemapFrom3, %A_WorkingDir%\DotAKey.ini, Remap, RemapFrom3, %A_Space%
	IniRead, r_RemapFrom4, %A_WorkingDir%\DotAKey.ini, Remap, RemapFrom4, %A_Space%
	IniRead, r_RemapFrom5, %A_WorkingDir%\DotAKey.ini, Remap, RemapFrom5, Numpad1
	IniRead, r_RemapFrom6, %A_WorkingDir%\DotAKey.ini, Remap, RemapFrom6, Numpad2
	IniRead, r_RemapTo1, %A_WorkingDir%\DotAKey.ini, Remap, RemapTo1, CapsLock
	IniRead, r_RemapTo2, %A_WorkingDir%\DotAKey.ini, Remap, RemapTo2, LWin
	IniRead, r_RemapTo3, %A_WorkingDir%\DotAKey.ini, Remap, RemapTo3, WheelUp
	IniRead, r_RemapTo4, %A_WorkingDir%\DotAKey.ini, Remap, RemapTo4, WheelDown
	IniRead, r_RemapTo5, %A_WorkingDir%\DotAKey.ini, Remap, RemapTo5, F5
	IniRead, r_RemapTo6, %A_WorkingDir%\DotAKey.ini, Remap, RemapTo6, F6
	Loop 6
	{
		If (r_RemapTo%A_Index% = "ERROR")
			r_RemapTo%A_Index% := A_Space
	}
	IniRead, n_Enable, %A_WorkingDir%\DotAKey.ini, Invoker, EnableInvoker, 1
	IniRead, e_Enable, %A_WorkingDir%\DotAKey.ini, Message, EnableMessage, 1
	IniRead, e_Message1, %A_WorkingDir%\DotAKey.ini, Message, Message1, -refresh
	IniRead, e_Hotkey1, %A_WorkingDir%\DotAKey.ini, Message, HotKey1, !1
	IniRead, e_ToAll1, %A_WorkingDir%\DotAKey.ini, Message, ToAll1, 0
	IniRead, e_Message2, %A_WorkingDir%\DotAKey.ini, Message, Message2, %A_Space%
	IniRead, e_Hotkey2, %A_WorkingDir%\DotAKey.ini, Message, HotKey2, %A_Space%
	IniRead, e_ToAll2, %A_WorkingDir%\DotAKey.ini, Message, ToAll2, 0
	IniRead, e_Message3, %A_WorkingDir%\DotAKey.ini, Message, Message3, %A_Space%
	IniRead, e_Hotkey3, %A_WorkingDir%\DotAKey.ini, Message, HotKey3, %A_Space%
	IniRead, e_ToAll3, %A_WorkingDir%\DotAKey.ini, Message, ToAll3, 0
	IniRead, e_Message4, %A_WorkingDir%\DotAKey.ini, Message, Message4, %A_Space%
	IniRead, e_Hotkey4, %A_WorkingDir%\DotAKey.ini, Message, HotKey4, %A_Space%
	IniRead, e_ToAll4, %A_WorkingDir%\DotAKey.ini, Message, ToAll4, 0
	Loop 6
	{
		If (e_Message%A_Index% = "ERROR")
			e_Message%A_Index% := A_Space
		If (e_Hotkey%A_Index% = "ERROR")
			e_Hotkey%A_Index% := A_Space
	}
	IniRead, o_EnableFlip, %A_WorkingDir%\DotAKey.ini, Other, EnableFlip, 1
	IniRead, o_EnableDiablo, %A_WorkingDir%\DotAKey.ini, Other, EnableDiablo, 1
	IniRead, o_DiabloPer, %A_WorkingDir%\DotAKey.ini, Other, DiabloPerMS, 200
	IniRead, o_EnableTrayTip, %A_WorkingDir%\DotAKey.ini, Other, EnableToolTip, 1
	m_IniFile = %A_ScriptDir%\DotAKey.ini
	If not FileExist(m_IniFile)
	Gosub, M_Save
	Return


M_Reload:
	Reload
	Return


M_Hide:
	Gui, Hide
	Return


M_Exit:
	ExitApp


M_Configuration:
	If m_GuiCreated
	{
		Gui, Show
	}
	Else
	{
		m_GuiCreated = 1

		Gui, Font, S10, Tahoma
		Gui, Font, S10, Microsoft YaHei
		Gui, Font, S10, Î¢ÈíÑÅºÚ
		Gui, Add, Tab, X0 Y0 W353 H218, Inventory|Remap|Invoker|Message|Other|About
		Gui, Show, W353 H218, DotAKey %m_Version%
		
		Gui, Tab, Inventory
		Gui, Font, S9, Tahoma
		Gui, Font, S9, Microsoft YaHei
		Gui, Font, S9, Î¢ÈíÑÅºÚ
		Gui, Add, Checkbox, Checked%i_Enable% vi_Enable gI_ChangeInvisibility X23 Y35, Enable Inventory Hotkeys
		Gui, Add, Text, vi_a1 X23 Y+10, Num7 :
		Gui, Add, Button, vi_b1 gM_SetHotkey X+10 Yp+0 W90, %i_Inventory1%
		Gui, Add, Text, vi_a2 X195 Yp+0, Num8 :
		Gui, Add, Button, vi_b2 gM_SetHotkey X+10 Yp+0 W90, %i_Inventory2%
		Gui, Add, Text, vi_a3 X23 Y+7, Num4 :
		Gui, Add, Button, vi_b3 gM_SetHotkey X+10 Yp+0 W90, %i_Inventory3%
		Gui, Add, Text, vi_a4 X195 Yp+0, Num5 :
		Gui, Add, Button, vi_b4 gM_SetHotkey X+10 Yp+0 W90, %i_Inventory4%
		Gui, Add, Text, vi_a5 X23 Y+7, Num1 :
		Gui, Add, Button, vi_b5 gM_SetHotkey X+10 Yp+0 W90, %i_Inventory5%
		Gui, Add, Text, vi_a6 X195 Yp+0, Num2 :
		Gui, Add, Button, vi_b6 gM_SetHotkey X+10 Yp+0 W90, %i_Inventory6%
		Gosub, I_ChangeInvisibility
		Gui, Font, S10, Tahoma
		Gui, Font, S10, Microsoft YaHei
		Gui, Font, S10, Î¢ÈíÑÅºÚ
		Gui, Add, Button, gPause X15 Y175 W50, Switch
		Gui, Add, Button, gM_Save X70 Y175 W63, Save
		Gui, Add, Button, gM_Reload X138 Y175 W63, Reload
		Gui, Add, Button, gM_Hide X206 Y175 W63, Hide
		Gui, Add, Button, gM_Exit X274 Y175 W63, Exit

		Gui, Tab, Remap
		Gui, Font, S9, Tahoma
		Gui, Font, S9, Microsoft YaHei
		Gui, Font, S9, Î¢ÈíÑÅºÚ
		Gui, Add, CheckBox, Checked%r_Enable% vr_Enable gR_ChangeInvisibility X23 Y35, Enable Remap Hotkeys
		Gui, Add, Hotkey, vr_RemapFrom1 gR_SetRemapFrom X23 Y+10 W60, %r_RemapFrom1%
		Gui, Add, Text, vr_b1 X+5 Yp+0, :
		Gui, Add, Button, vr_c1 gM_SetHotkey X+5 Yp+0 W70, %r_RemapTo1%
		Gui, Add, Hotkey, vr_RemapFrom2 gR_SetRemapFrom X195 Yp+0 W60, %r_RemapFrom2%
		Gui, Add, Text, vr_b2 X+5 Yp+0, :
		Gui, Add, Button, vr_c2 gM_SetHotkey X+5 Yp+0 W70, %r_RemapTo2%
		Gui, Add, Hotkey, vr_RemapFrom3 gR_SetRemapFrom X23 Y+7 W60, %r_RemapFrom3%
		Gui, Add, Text, vr_b3 X+5 Yp+0, :
		Gui, Add, Button, vr_c3 gM_SetHotkey X+5 Yp+0 W70, %r_RemapTo3%
		Gui, Add, Hotkey, vr_RemapFrom4 gR_SetRemapFrom X195 Yp+0 W60, %r_RemapFrom4%
		Gui, Add, Text, vr_b4 X+5 Yp+0, :
		Gui, Add, Button, vr_c4 gM_SetHotkey X+5 Yp+0 W70, %r_RemapTo4%
		Gui, Add, Hotkey, vr_RemapFrom5 gR_SetRemapFrom X23 Y+7 W60, %r_RemapFrom5%
		Gui, Add, Text, vr_b5 X+5 Yp+0, :
		Gui, Add, Button, vr_c5 gM_SetHotkey X+5 Yp+0 W70, %r_RemapTo5%
		Gui, Add, Hotkey, vr_RemapFrom6 gR_SetRemapFrom X195 Yp+0 W60, %r_RemapFrom6%
		Gui, Add, Text, vr_b6 X+5 Yp+0, :
		Gui, Add, Button, vr_c6 gM_SetHotkey X+5 Yp+0 W70, %r_RemapTo6%
		Gosub, R_ChangeInvisibility
		Gui, Font, S10, Tahoma
		Gui, Font, S10, Microsoft YaHei
		Gui, Font, S10, Î¢ÈíÑÅºÚ
		Gui, Add, Button, gPause X15 Y175 W50, Switch
		Gui, Add, Button, gM_Save X70 Y175 W63, Save
		Gui, Add, Button, gM_Reload X138 Y175 W63, Reload
		Gui, Add, Button, gM_Hide X206 Y175 W63, Hide
		Gui, Add, Button, gM_Exit X274 Y175 W63, Exit

		Gui, Tab, Invoker
		Gui, Font, S9, Tahoma
		Gui, Font, S9, Microsoft YaHei
		Gui, Font, S9, Î¢ÈíÑÅºÚ
		Gui, Add, CheckBox, Checked%n_Enable% vn_Enable gN_ChangeInvisibility X23 Y35, Enable Invoker Hotkeys
		Gui, Add, Text, vn_a1 , Ctrl + Skills Keys = Summon Skills
		Gosub, N_ChangeInvisibility
		Gui, Font, S10, Tahoma
		Gui, Font, S10, Microsoft YaHei
		Gui, Font, S10, Î¢ÈíÑÅºÚ
		Gui, Add, Button, gPause X15 Y175 W50, Switch
		Gui, Add, Button, gM_Save X70 Y175 W63, Save
		Gui, Add, Button, gM_Reload X138 Y175 W63, Reload
		Gui, Add, Button, gM_Hide X206 Y175 W63, Hide
		Gui, Add, Button, gM_Exit X274 Y175 W63, Exit

		Gui, Tab, Message
		Gui, Font, S9, Tahoma
		Gui, Font, S9, Microsoft YaHei
		Gui, Font, S9, Î¢ÈíÑÅºÚ
		Gui, Add, CheckBox, Checked%e_Enable% ve_Enable gE_ChangeInvisibility X23 Y35, Enable Message Hotkeys
		Gui, Add, Text, ve_ToAll0 X300 Yp+0, To All
		Gui, Add, Edit, ve_Message1 X23 Y+5 W200, %e_Message1%
		Gui, Add, Text, ve_b1 X+5 Yp+0, :
		Gui, Add, Button, ve_c1 gM_SetHotkey X+5 Yp+0 W70, %e_Hotkey1%
		Gui, Add, CheckBox, Checked%e_ToAll1% ve_ToAll1 gE_ChangeToAll X315 Yp+5
		Gui, Add, Edit, ve_Message2 X23 Y+6 W200, %e_Message2%
		Gui, Add, Text, ve_b2 X+5 Yp+0, :
		Gui, Add, Button, ve_c2 gM_SetHotkey X+5 Yp+0 W70, %e_Hotkey2%
		Gui, Add, CheckBox, Checked%e_ToAll2% ve_ToAll2 gE_ChangeToAll X315 Yp+5
		Gui, Add, Edit, ve_Message3 X23 Y+6 W200, %e_Message3%
		Gui, Add, Text, ve_b3 X+5 Yp+0, :
		Gui, Add, Button, ve_c3 gM_SetHotkey X+5 Yp+0 W70, %e_Hotkey3%
		Gui, Add, CheckBox, Checked%e_ToAll3% ve_ToAll3 gE_ChangeToAll X315 Yp+5
		Gui, Add, Edit, ve_Message4 X23 Y+6 W200, %e_Message4%
		Gui, Add, Text, ve_b4 X+5 Yp+0, :
		Gui, Add, Button, ve_c4 gM_SetHotkey X+5 Yp+0 W70, %e_Hotkey4%
		Gui, Add, CheckBox, Checked%e_ToAll4% ve_ToAll4 gE_ChangeToAll X315 Yp+5
		Gosub, E_ChangeInvisibility
		Gui, Font, S10, Tahoma
		Gui, Font, S10, Microsoft YaHei
		Gui, Font, S10, Î¢ÈíÑÅºÚ
		Gui, Add, Button, gPause X15 Y175 W50, Switch
		Gui, Add, Button, gM_Save X70 Y175 W63, Save
		Gui, Add, Button, gM_Reload X138 Y175 W63, Reload
		Gui, Add, Button, gM_Hide X206 Y175 W63, Hide
		Gui, Add, Button, gM_Exit X274 Y175 W63, Exit

		Gui, Tab, Other
		Gui, Font, S9, Tahoma
		Gui, Font, S9, Microsoft YaHei
		Gui, Font, S9, Î¢ÈíÑÅºÚ
		Gui, Add, Button, X20 Y35 W70, Pause
		Gui, Add, Text, X+5 Yp+5, to pause or resume the program.
		Gui, Add, CheckBox, Checked%o_EnableFlip% vo_EnableFlip X23 Y+10, Enable Windows Flip3D.
		Gui, Add, CheckBox, Checked%o_EnableDiablo% vo_EnableDiablo gO_ChangeInvisibility X23 Y+5, Enable Diablo-Style Movement.
		Gui, Add, Text, vo_EnableDiablo1 X+5 Yp+0, Per
		Gui, Add, Edit, vo_DiabloPer X+5 Yp+0 W50, %o_DiabloPer%
		Gui, Add, Text, vo_EnableDiablo2 X+5 Yp+0, ms.
		Gui, Add, CheckBox, Checked%o_EnableTrayTip% vo_EnableTrayTip X23 Y+5, Enable Tray Tool Tip.
		Gui, Font, S10, Tahoma
		Gui, Font, S10, Microsoft YaHei
		Gui, Font, S10, Î¢ÈíÑÅºÚ
		Gui, Add, Button, gPause X15 Y175 W50, Switch
		Gui, Add, Button, gM_Save X70 Y175 W63, Save
		Gui, Add, Button, gM_Reload X138 Y175 W63, Reload
		Gui, Add, Button, gM_Hide X206 Y175 W63, Hide
		Gui, Add, Button, gM_Exit X274 Y175 W63, Exit

		Gui, Tab, About
		Gui, Add, Text, X15 Y35, DotAKey `n Version %m_Version% `n Made by vivaxy `n Based on AutoHotKey `n Special thanks to Dark.88@PD and AucT@PD  `n %m_Date%
		Gui, Add, Button, gPause X15 Y175 W50, Switch
		Gui, Add, Button, gM_Save X70 Y175 W63, Save
		Gui, Add, Button, gM_Reload X138 Y175 W63, Reload
		Gui, Add, Button, gM_Hide X206 Y175 W63, Hide
		Gui, Add, Button, gM_Exit X274 Y175 W63, Exit
	}
	Return


M_SetHotkey:
	m_ButtonId := A_GuiControl
	Gui, 2: Default
	Gui, Font, S10, Tahoma
	Gui, Font, S10, Microsoft YaHei
	Gui, Font, S10, Î¢ÈíÑÅºÚ
	Gui, Add, GroupBox, W240 H50, Modifier
	Gui, Add, Checkbox, vm_AltModifier gM_HotkeyModifier XP+15 YP+20, Alt
	Gui, Add, Checkbox, vm_CtrlModifier gM_HotkeyModifier XP+55, Ctrl
	Gui, Add, Checkbox, vm_ShiftModifier gM_HotkeyModifier XP+55, Shift
	Gui, Add, Checkbox, vm_WinModifier gM_HotkeyModifier XP+55, Win
	Gui, Add, Groupbox,X10 W240 H200, Keys
	Gui, Add, Radio, vm_HotkeyRadio gM_UpdateKeyList Checked XP+5 YP+30, None
	Gui, Add, Radio, gM_UpdateKeyList Y+10, Standard
	Gui, Add, Radio, gM_UpdateKeyList Y+10, Function
	Gui, Add, Radio, gM_UpdateKeyList Y+10, Numpad
	Gui, Add, Radio, gM_UpdateKeyList Y+10, Mouse
	Gui, Add, Radio, gM_UpdateKeyList Y+10, Multimedia
	Gui, Add, Listbox, vm_HotkeyLast gM_HotkeyModifier X115 Y95 W125 H165
	Gosub, M_UpdateKeyList
	Gui, Add, Text, X10 Y280 W40, Code :
	Gui, Add, Edit, vm_HotkeyCodeShow X+5 W195 +Readonly
	Gui, Add, Text, X10 Y+5 W40 H20, Key :
	Gui, Add, Text, vm_HotkeyKeyShow X+5 W195 +Readonly, None
	Gui, Add, Button, X25 Y340 W100 H30 gM_HotkeyAccept, Accept
	Gui, Add, Button, X+5 W100 H30 gM_HotkeyClose, Cancel
	Gui, Show, Autosize Center, DotAKey
	Return


M_HotkeyModifier:
	Gui, Submit, Nohide
	m_HotkeyCode = 
	m_HotkeyKey = 
	If m_CtrlModifier
	{
		m_HotkeyCode := m_HotkeyCode . "^"
        m_HotkeyKey := m_HotkeyKey . "Ctrl + "
	}
	If m_ShiftModifier
	{
		m_HotkeyCode := m_HotkeyCode . "+"
		m_HotkeyKey := m_HotkeyKey . "Shift + "
	}
	If m_WinModifier
	{
		m_HotkeyCode := m_HotkeyCode . "#"
		m_HotkeyKey := m_HotkeyKey . "Win + "
	}
	If m_AltModifier
	{
		m_HotkeyCode := m_HotkeyCode . "!"
		m_HotkeyKey:=m_HotkeyKey . "Alt + "
	}
	m_HotkeyCode := m_HotkeyCode . m_HotkeyLast
    m_HotkeyKey := m_HotkeyKey . m_HotkeyLast
    GuiControl, , m_HotkeyCodeShow, %m_HotkeyCode%
    GuiControl, , m_HotkeyKeyShow, %m_HotkeyKey%
	Return


M_UpdateKeyList:
	Gui, Submit, Nohide
	GuiControl, -Redraw, m_HotkeyLast
	If (m_HotkeyRadio = "1")
		GuiControl, , m_HotkeyLast, | %A_Blank%
	If (m_HotkeyRadio = "2")
		GuiControl, , m_HotkeyLast, |A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|1|2|3|4|5|6|7|8|9|0|``|-|=|\|[|]|;|''|,|.|/|Space|Tab|Enter|Esc|Del|ScrollLock|CapsLock|NumLock|PrintScreen|BackSpace|CtrlBreak|Pause|Break|Up|Down|Left|Right|Home|End|Insert|PageUp|PageDown
	If (m_HotkeyRadio = "3")
		GuiControl, , m_HotkeyLast, |F1|F2|F3|F4|F5|F6|F7|F8|F9|F10|F11|F12|LWin|RWin|LControl|RControl|LShift|RShift|LAlt|RAlt
	If (m_HotkeyRadio = "4")
		GuiControl, , m_HotkeyLast, |Numpad0|Numpad1|Numpad2|Numpad3|Numpad4|Numpad5|Numpad6|Numpad7|Numpad8|Numpad9|Numpadmult|NumpadAdd|NumpadSub|NumpadDiv|NumpadDot|NumpadEnter
	If (m_HotkeyRadio = "5")
		GuiControl, , m_HotkeyLast, |LButton|RButton|MButton|WheelUp|WheelDown|XButton1|XButton2
	If (m_HotkeyRadio = "6")
		GuiControl, , m_HotkeyLast, |Browser_back|Browser_forward|Browser_refresh|Browser_stop|Browser_search|Browser_favorites|Browser_home|volume_mute|volume_down|volume_up|Media_next|Media_prev|Media_stop|Media_Play_Pause|launch_media|launch_mail|launch_app1|launch_app2
	GuiControl, +Redraw, m_HotkeyLast
	Return


M_HotkeyClose:
	Gui, 2: Destroy
	Return


M_HotkeyAccept:
	Gui, Submit
	m_i := SubStr(m_ButtonId,4,1)
	m_j := SubStr(m_ButtonId,1,1)
	If (m_j = "i")
		i_Inventory%m_i% := m_HotkeyCode
	If (m_j = "r")
		r_RemapTo%m_i% := m_HotkeyCode
	If (m_j = "e")
		e_Hotkey%m_i% := m_HotkeyCode
	Gui, 2: Destroy
	Gui, 1: Default
	GuiControl Text, %m_ButtonId%, %m_HotkeyCode%
	Return


M_CheckIME:
	WinGet,hWnd,ID,Warcraft III ahk_class Warcraft III
	IMEWnd:=DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)
	DetectHiddenWindows , ON
	SendMessage 0x283,0x005,"",,ahk_id %IMEWnd%
	DetectHiddenWindows , OFF
	m_CheckIME := ErrorLevel
	Return


I_ChangeInvisibility:
	GuiControlGet, i_ControlGet, , i_Enable
	If (i_ControlGet = "1")
	{
		GuiControl, Enable, i_a1
		GuiControl, Enable, i_a2
		GuiControl, Enable, i_a3
		GuiControl, Enable, i_a4
		GuiControl, Enable, i_a5
		GuiControl, Enable, i_a6
		GuiControl, Enable, i_b1
		GuiControl, Enable, i_b2
		GuiControl, Enable, i_b3
		GuiControl, Enable, i_b4
		GuiControl, Enable, i_b5
		GuiControl, Enable, i_b6
	}
	Else
	{
		GuiControl, Disable, i_a1
		GuiControl, Disable, i_a2
		GuiControl, Disable, i_a3
		GuiControl, Disable, i_a4
		GuiControl, Disable, i_a5
		GuiControl, Disable, i_a6
		GuiControl, Disable, i_b1
		GuiControl, Disable, i_b2
		GuiControl, Disable, i_b3
		GuiControl, Disable, i_b4
		GuiControl, Disable, i_b5
		GuiControl, Disable, i_b6
	}
	Return


I_Inventory1:
	Send, {numpad7}
	Return

I_Inventory2:
	Send, {numpad8}
	Return

I_Inventory3:
	Send, {numpad4}
	Return

I_Inventory4:
	Send, {numpad5}
	Return

I_Inventory5:
	Send, {numpad1}
	Return

I_Inventory6:
	Send, {numpad2}
	Return


R_ChangeInvisibility:
	GuiControlGet, r_ControlGet, , r_Enable
	If (r_ControlGet = "1")
	{
		GuiControl, Enable, r_RemapFrom1
		GuiControl, Enable, r_RemapFrom2
		GuiControl, Enable, r_RemapFrom3
		GuiControl, Enable, r_RemapFrom4
		GuiControl, Enable, r_RemapFrom5
		GuiControl, Enable, r_RemapFrom6
		GuiControl, Enable, r_b1
		GuiControl, Enable, r_b2
		GuiControl, Enable, r_b3
		GuiControl, Enable, r_b4
		GuiControl, Enable, r_b5
		GuiControl, Enable, r_b6
		GuiControl, Enable, r_c1
		GuiControl, Enable, r_c2
		GuiControl, Enable, r_c3
		GuiControl, Enable, r_c4
		GuiControl, Enable, r_c5
		GuiControl, Enable, r_c6
	}
	Else
	{
		GuiControl, Disable, r_RemapFrom1
		GuiControl, Disable, r_RemapFrom2
		GuiControl, Disable, r_RemapFrom3
		GuiControl, Disable, r_RemapFrom4
		GuiControl, Disable, r_RemapFrom5
		GuiControl, Disable, r_RemapFrom6
		GuiControl, Disable, r_b1
		GuiControl, Disable, r_b2
		GuiControl, Disable, r_b3
		GuiControl, Disable, r_b4
		GuiControl, Disable, r_b5
		GuiControl, Disable, r_b6
		GuiControl, Disable, r_c1
		GuiControl, Disable, r_c2
		GuiControl, Disable, r_c3
		GuiControl, Disable, r_c4
		GuiControl, Disable, r_c5
		GuiControl, Disable, r_c6
	}
	Return


R_SetRemapFrom:
	Gui, Submit, Nohide
	m_ButtonId := A_GuiControl
	m_i := SubStr(m_ButtonId,4,1)
	r_RemapFrom%m_i% := m_HotkeyCode
	Return


R_Remap1:
	Send, {%r_RemapFrom1%}
	Return

R_Remap2:
	Send, {%r_RemapFrom2%}
	Return

R_Remap3:
	Send, {%r_RemapFrom3%}
	Return

R_Remap4:
	Send, {%r_RemapFrom4%}
	Return

R_Remap5:
	Send, {%r_RemapFrom5%}
	Return

R_Remap6:
	Send, {%r_RemapFrom6%}
	Return

M_DisableKey:
	Return


N_ChangeInvisibility:
	GuiControlGet, n_ControlGet, , n_Enable
	If (n_ControlGet = 1)
		GuiControl, Enable, n_a1
	Else
		GuiControl, Disable, n_a1
	Return


N_Y:
	Send, {q}{q}{q}{r}
	Return

N_V:
	Send, {q}{q}{w}{r}
	Return

N_X:
	Send, {w}{w}{q}{r}
	Return

N_D:
	Send, {e}{e}{w}{r}
	Return

N_B:
	Send, {q}{w}{e}{r}
	Return

N_F:
	Send, {e}{e}{q}{r}
	Return

N_T:
	Send, {e}{e}{e}{r}
	Return

N_C:
	Send, {w}{w}{w}{r}
	Return

N_Z:
	Send, {w}{w}{e}{r}
	Return

N_G:
	Send, {q}{q}{e}{r}
	Return

N_Q:
	Send, {q}{q}{q}
	Return

N_W:
	Send, {w}{w}{w}
	Return

N_E:
	Send, {e}{e}{e}
	Return


E_ChangeInvisibility:
	GuiControlGet, e_ControlGet, , e_Enable
	If (e_ControlGet = 1)
	{
		GuiControl, Enable, e_Message1
		GuiControl, Enable, e_Message2
		GuiControl, Enable, e_Message3
		GuiControl, Enable, e_Message4
		GuiControl, Enable, e_b1
		GuiControl, Enable, e_b2
		GuiControl, Enable, e_b3
		GuiControl, Enable, e_b4
		GuiControl, Enable, e_c1
		GuiControl, Enable, e_c2
		GuiControl, Enable, e_c3
		GuiControl, Enable, e_c4
		GuiControl, Enable, e_ToAll0
		GuiControl, Enable, e_ToAll1
		GuiControl, Enable, e_ToAll2
		GuiControl, Enable, e_ToAll3
		GuiControl, Enable, e_ToAll4
	}
	Else
	{
		GuiControl, Disable, e_Message1
		GuiControl, Disable, e_Message2
		GuiControl, Disable, e_Message3
		GuiControl, Disable, e_Message4
		GuiControl, Disable, e_b1
		GuiControl, Disable, e_b2
		GuiControl, Disable, e_b3
		GuiControl, Disable, e_b4
		GuiControl, Disable, e_c1
		GuiControl, Disable, e_c2
		GuiControl, Disable, e_c3
		GuiControl, Disable, e_c4
		GuiControl, Disable, e_ToAll0
		GuiControl, Disable, e_ToAll1
		GuiControl, Disable, e_ToAll2
		GuiControl, Disable, e_ToAll3
		GuiControl, Disable, e_ToAll4
	}
	Return


E_ChangeToAll:
	m_ButtonId := A_GuiControl
	m_i := SubStr(m_ButtonId,4,1)
	Return


E_Message1:
	m_Temp = %Clipboard%
	Clipboard = %e_Message1%
	If e_ToAll1
		Send, +{enter}
	Else
		Send, ^{enter}
	Send, ^{v}
	Sleep, 100
	Send, {enter}
	Clipboard = %m_Temp%
	Return

E_Message2:
	m_Temp = %Clipboard%
	Clipboard = %e_Message2%
	If e_ToAll2
		Send, +{enter}
	Else
		Send, ^{enter}
	Send, ^{v}
	Sleep, 100
	Send, {enter}
	Clipboard = %m_Temp%
	Return

E_Message3:
	m_Temp = %Clipboard%
	Clipboard = %e_Message3%
	If e_ToAll3
		Send, +{enter}
	Else
		Send, ^{enter}
	Send, ^{v}
	Sleep, 100
	Send, {enter}
	Clipboard = %m_Temp%
	Return

E_Message4:
	m_Temp = %Clipboard%
	Clipboard = %e_Message4%
	If e_ToAll4
		Send, +{enter}
	Else
		Send, ^{enter}
	Send, ^{v}
	Sleep, 100
	Send, {enter}
	Clipboard = %m_Temp%
	Return


O_ChangeInvisibility:
	GuiControlGet, o_ControlGet, , o_EnableDiablo
	If (o_ControlGet = 1)
	{
		GuiControl, Enable, o_EnableDiablo1
		GuiControl, Enable, o_EnableDiablo2
		GuiControl, Enable, o_DiabloPer
	}
	Else
	{
		GuiControl, Disable, o_EnableDiablo1
		GuiControl, Disable, o_EnableDiablo2
		GuiControl, Disable, o_DiabloPer
	}
	Return


O_Flip:
	If WinActive("ahk_class Flip3D") Or WinActive("ahk_class Warcraft III") Or !m_Switch Or !o_EnableFlip
	Return
	Else
	{
		MouseGetPos, o_MouseX, o_MouseY
		o_Position := o_MouseX*o_MouseX+o_MouseY*o_MouseY
		If (o_Position<40)
		{
			Run rundll32.exe dwmapi #105
		}
	}
	Return


O_S:
	Loop
	{
		If Not GetKeyState("s","P")
		Break
		Send {s}
		Sleep %o_DiabloPer%
	}
	Return


O_RButton:
	Loop
	{
		If Not GetKeyState("RButton","P")
		Break
		Send {click right}
		Sleep %o_DiabloPer%
	}
	Return


GuiEscape:
GuiClose:
	Gui, Hide
	Return


2GuiEscape:
2GuiClose:
	Gui, 2: Destroy
	Return



/*
2.1.3
03-11-2011
1.Modify tray menu.
2.Improve icons.

2.1.2
31-10-2011
1.Fix a bug when deciding whether War3 is activated.
2.Fix media key problem.

2.1.1
27-10-2011
1.Add option to the pause or resume key.
2.Add tray menu "Reload".
3.Add enable tooltip.

2.1.0
16-10-2011
1.Hotkeys no longer effective when chatting.(Through checking IME status.)
2.Fix Save and Reload function.
3.Fix problems when set keys as None.

2.0.1
11-10-2011
1.Add tray tip.
2.Add diablo time option.

2.0.0
14-09-2011
Basic Functions:
1.Inventory.
2.Remap keys.
3.Invkoer hotkeys.
4.Hotkey messages.
5.Windows Flip 3D.
6.Diablo-style movement.
7.Support mouse, special keys and combined keys.