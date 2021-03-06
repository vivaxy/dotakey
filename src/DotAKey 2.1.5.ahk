;;DotAKey
;;Made by Vivaxy
;;AutoHotKey

m_Date = 24-09-2012

m_Version = 2.1.5

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
			Loop %r_Number%
			{
				r_RemapTo := r_RemapTo%A_Index%
				If (r_RemapTo%A_Index% != "")
				{
					If (r_RemapFrom%A_Index% = "")
						Hotkey, %r_RemapTo%, M_DisableKey
					Else
						Hotkey, %r_RemapTo%, R_Remap%A_Index%
				}
			}
		}
		If (n_Enable = "1")
		{
			If (n_Mode = "1")
			{
				Hotkey, ^Y, N_Y1
				Hotkey, ^V, N_V1
				Hotkey, ^X, N_X1
				Hotkey, ^D, N_D1
				Hotkey, ^B, N_B1
				Hotkey, ^F, N_F1
				HotKey, ^T, N_T1
				Hotkey, ^C, N_C1
				Hotkey, ^Z, N_Z1
				Hotkey, ^G, N_G1
				Hotkey, ^Q, N_Q1
				Hotkey, ^W, N_W1
				Hotkey, ^E, N_E1
			}
			If (n_mode = "2")
			{
				Hotkey, Y, N_Y2
				Hotkey, V, N_V2
				Hotkey, X, N_X2
				Hotkey, D, N_D2
				Hotkey, B, N_B2
				Hotkey, F, N_F2
				HotKey, T, N_T2
				Hotkey, C, N_C2
				Hotkey, Z, N_Z2
				Hotkey, G, N_G2
				Hotkey, Q, N_Q2
				Hotkey, W, N_W2
				Hotkey, E, N_E2
			}
			If (n_mode = "3")
			{
				Hotkey, Y, N_Y3
				Hotkey, V, N_V3
				Hotkey, X, N_X3
				Hotkey, D, N_D3
				Hotkey, B, N_B3
				Hotkey, F, N_F3
				HotKey, T, N_T3
				Hotkey, C, N_C3
				Hotkey, Z, N_Z3
				Hotkey, G, N_G3
				Hotkey, Q, N_Q3
				Hotkey, W, N_W3
				Hotkey, E, N_E3
			}
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
	IniWrite, %r_Number%, %A_WorkingDir%\DotAKey.ini, Remap, RemapNumber
	Loop %r_Number%
	{
		m_IniWrite1 := r_RemapFrom%A_Index%
		m_IniWrite2 := r_RemapTo%A_Index%
		IniWrite, %m_IniWrite1%, %A_WorkingDir%\DotAKey.ini, Remap, RemapFrom%A_Index%
		IniWrite, %m_IniWrite2%, %A_WorkingDir%\DotAKey.ini, Remap, RemapTo%A_Index%
	}
	IniWrite, %n_Enable%, %A_WorkingDir%\DotAKey.ini, Invoker, EnableInvoker
	IniWrite, %n_Mode%, %A_WorkingDir%\DotAKey.ini, Invoker, InvokerMode
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
	IniRead, i_Inventory5, %A_WorkingDir%\DotAKey.ini, Inventory, Inventory5, F5
	IniRead, i_Inventory6, %A_WorkingDir%\DotAKey.ini, Inventory, Inventory6, F6
	Loop 6
	{
		If (i_Inventory%A_Index% = "ERROR")
			i_Inventory%A_Index% := A_Space
	}
	IniRead, r_Enable, %A_WorkingDir%\DotAKey.ini, Remap, EnableRemap, 1
	IniRead, r_Number, %A_WorkingDir%\DotAKey.ini, Remap, RemapMunber, 9
	Loop %r_Number%
	{
		IniRead, r_RemapFrom%A_Index%, %A_WorkingDir%\DotAKey.ini, Remap, RemapFrom%A_Index%
		IniRead, r_RemapTo%A_Index%, %A_WorkingDir%\DotAKey.ini, Remap, RemapTo%A_Index%
	}
	Loop %r_Number%
	{
		If (r_RemapTo%A_Index% = "ERROR")
			r_RemapTo%A_Index% := A_Space
	}
	Loop %r_Number%
	{
		If (r_RemapFrom%A_Index% = "ERROR")
			r_RemapFrom%A_Index% := A_Space
	}
	IniRead, n_Enable, %A_WorkingDir%\DotAKey.ini, Invoker, EnableInvoker, 1
	IniRead, n_Mode, %A_WorkingDir%\DotAKey.ini, Invoker, InvokerMode, 1
	If (n_Mode = 1)
		{
			n_a1 := 1
			n_a2 := 0
			n_a3 := 0
		}
	If (n_Mode = 2)
		{
			n_a1 := 0
			n_a2 := 1
			n_a3 := 0
		}
	If (n_Mode = 3)
		{
			n_a1 := 0
			n_a2 := 0
			n_a3 := 1
		}
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

		Gui, Font, S10, 微软雅黑
		Gui, Font, S10, Microsoft Yahei
		Gui, Font, S10, Segeo UI
		Gui, Add, Tab, X0 Y0 W353 H218, Inventory|Remap|Invoker|Message|Other|About
		Gui, Show, W353 H218, DotAKey %m_Version%
		
		Gui, Tab, Inventory
		Gui, Font, S9, 微软雅黑
		Gui, Font, S9, Microsoft YaHei
		Gui, Font, S9, Segeo UI
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
		Gui, Font, S10, 微软雅黑
		Gui, Font, S10, Microsoft Yahei
		Gui, Font, S10, Segeo UI
		Gui, Add, Button, gPause X15 Y175 W50, Switch
		Gui, Add, Button, gM_Save X70 Y175 W63, Save
		Gui, Add, Button, gM_Reload X138 Y175 W63, Reload
		Gui, Add, Button, gM_Hide X206 Y175 W63, Hide
		Gui, Add, Button, gM_Exit X274 Y175 W63, Exit

		Gui, Tab, Remap
		Gui, Font, S9, 微软雅黑
		Gui, Font, S9, Microsoft YaHei
		Gui, Font, S9, Segeo UI
		Gui, Add, CheckBox, Checked%r_Enable% vr_Enable gR_ChangeInvisibility X23 Y35, Enable Remap Hotkeys
		Gui, Add, ListView, NoSortHdr -Multi -LV0x10 W310 H100 vr_all gM_RemapList, Warcraft respond|Actual hit
		Loop %r_Number%
		{
			LV_Add("",r_RemapFrom%A_Index%,r_RemapTo%A_Index%)
		}
		LV_ModifyCol(1,140)
		LV_ModifyCol(2,140)
		Gosub, R_ChangeInvisibility
		Gui, Font, S10, 微软雅黑
		Gui, Font, S10, Microsoft Yahei
		Gui, Font, S10, Segeo UI
		Gui, Add, Button, gPause X15 Y175 W50, Switch
		Gui, Add, Button, gM_Save X70 Y175 W63, Save
		Gui, Add, Button, gM_Reload X138 Y175 W63, Reload
		Gui, Add, Button, gM_Hide X206 Y175 W63, Hide
		Gui, Add, Button, gM_Exit X274 Y175 W63, Exit

		Gui, Tab, Invoker
		Gui, Font, S9, 微软雅黑
		Gui, Font, S9, Microsoft YaHei
		Gui, Font, S9, Segeo UI
		Gui, Add, CheckBox, Checked%n_Enable% vn_Enable gN_ChangeInvisibility X23 Y35, Enable Invoker Hotkeys
		Gui, Add, Radio, Checked%n_a1% vn_a1 gN_Mode, Ctrl + Skills Keys = Summon Skills
		Gui, Add, Radio, Checked%n_a2% vn_a2 gN_Mode, Skills Keys = Use Skills(Seldom fail)
		Gui, Add, Radio, Checked%n_a3% vn_a3 gN_Mode, Skills Keys = Summon Skills
		Gosub, N_ChangeInvisibility
		Gui, Font, S10, 微软雅黑
		Gui, Font, S10, Microsoft Yahei
		Gui, Font, S10, Segeo UI
		Gui, Add, Button, gPause X15 Y175 W50, Switch
		Gui, Add, Button, gM_Save X70 Y175 W63, Save
		Gui, Add, Button, gM_Reload X138 Y175 W63, Reload
		Gui, Add, Button, gM_Hide X206 Y175 W63, Hide
		Gui, Add, Button, gM_Exit X274 Y175 W63, Exit

		Gui, Tab, Message
		Gui, Font, S9, 微软雅黑
		Gui, Font, S9, Microsoft YaHei
		Gui, Font, S9, Segeo UI
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
		Gui, Font, S10, 微软雅黑
		Gui, Font, S10, Microsoft Yahei
		Gui, Font, S10, Segeo UI
		Gui, Add, Button, gPause X15 Y175 W50, Switch
		Gui, Add, Button, gM_Save X70 Y175 W63, Save
		Gui, Add, Button, gM_Reload X138 Y175 W63, Reload
		Gui, Add, Button, gM_Hide X206 Y175 W63, Hide
		Gui, Add, Button, gM_Exit X274 Y175 W63, Exit

		Gui, Tab, Other
		Gui, Font, S9, 微软雅黑
		Gui, Font, S9, Microsoft YaHei
		Gui, Font, S9, Segeo UI
		Gui, Add, Button, X20 Y35 W70, Pause
		Gui, Add, Text, X+5 Yp+5, to pause or resume the program.
		Gui, Add, CheckBox, Checked%o_EnableFlip% vo_EnableFlip X23 Y+10, Enable Windows Flip3D.
		Gui, Add, CheckBox, Checked%o_EnableDiablo% vo_EnableDiablo gO_ChangeInvisibility X23 Y+5, Enable Diablo-Style Movement.
		Gui, Add, Text, vo_EnableDiablo1 X+5 Yp+0, Per
		Gui, Add, Edit, vo_DiabloPer X+5 Yp+0 W50, %o_DiabloPer%
		Gui, Add, Text, vo_EnableDiablo2 X+5 Yp+0, ms.
		Gui, Add, CheckBox, Checked%o_EnableTrayTip% vo_EnableTrayTip X23 Y+5, Enable Tray Tool Tip.
		Gui, Font, S10, 微软雅黑
		Gui, Font, S10, Microsoft Yahei
		Gui, Font, S10, Segeo UI
		Gui, Add, Button, gPause X15 Y175 W50, Switch
		Gui, Add, Button, gM_Save X70 Y175 W63, Save
		Gui, Add, Button, gM_Reload X138 Y175 W63, Reload
		Gui, Add, Button, gM_Hide X206 Y175 W63, Hide
		Gui, Add, Button, gM_Exit X274 Y175 W63, Exit

		Gui, Tab, About
		Gui, Font, S9, 微软雅黑
		Gui, Font, S9, Microsoft YaHei
		Gui, Font, S9, Segeo UI
		Gui, Add, Text, X15 Y35, DotAKey `n Version %m_Version% `n Made by vivaxy `n Based on AutoHotKey `n Special thanks to Dark.88@PD and AucT@PD  `n %m_Date%
		Gui, Font, S10, 微软雅黑
		Gui, Font, S10, Microsoft Yahei
		Gui, Font, S10, Segeo UI
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
	Gui, Font, S10, 微软雅黑
	Gui, Font, S10, Microsoft Yahei
	Gui, Font, S10, Segeo UI
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
	m_j := SubStr(m_ButtonId,1,1)
	m_i := SubStr(m_ButtonId,4,1)
	If (m_j = "i")
		i_Inventory%m_i% := m_HotkeyCode
	If (m_j = "r")
	{
		m_k := SubStr(m_ButtonId,3,1)
		If (m_k = "f")
			m_RemapFrom := m_HotkeyCode
		If (m_k = "t")
			m_RemapTo := m_HotkeyCode
		Gui, 2: Destroy
		Gui, 3: Default
		GuiControl, , %m_ButtonId%, %m_HotkeyCode%
		Return
	}
	If (m_j = "e")
		e_Hotkey%m_i% := m_HotkeyCode
	Gui, 2: Destroy
	Gui, 1: Default
	GuiControl, , %m_ButtonId%, %m_HotkeyCode%
	Return


M_CheckIME:
	WinGet,hWnd,ID,Warcraft III ahk_class Warcraft III
	IMEWnd:=DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)
	DetectHiddenWindows , ON
	SendMessage 0x283,0x005,"",,ahk_id %IMEWnd%
	DetectHiddenWindows , OFF
	m_CheckIME := ErrorLevel
	Return


M_RemapList:
	If A_GuiEvent = DoubleClick
	{
		m_RemapFrom := r_RemapFrom%A_EventInfo%
		m_RemapTo := r_RemapTo%A_EventInfo%
		Gui, 3: Default
		Gui, Font, S10, 微软雅黑
		Gui, Font, S10, Microsoft Yahei
		Gui, Font, S10, Segeo UI
		Gui, Add, Text, X18 Y20, Warcraft respond
		Gui, Add, Text, X150 Y20, Actual hit
		Gui, Add, Button, X20 Y+5 W100 H30 vr_f%A_EventInfo% gM_SetHotkey, %m_RemapFrom%
		Gui, Add, Button, X+5 W100 H30 vr_t%A_EventInfo% gM_SetHotkey, %m_RemapTo%
		Gui, Add, Button, X20 Y100 W100 H30 gM_RemapAccept, Accept
		Gui, Add, Button, X+5 W100 H30 gM_RemapClose, Cancel
		Gui, Show, Autosize Center, DotAKey
		Return
	}
	Return


M_RemapAccept:
	Gui, Submit
	m_i := SubStr(m_ButtonId,4,1)
	r_RemapFrom%m_i% := m_RemapFrom
	r_RemapTo%m_i% := m_RemapTo
	Gui, 3: Destroy
	Gui, 1: Default
	LV_Modify(m_i, "Col" 1, m_RemapFrom)
	LV_Modify(m_i, "Col" 2, m_RemapTo)
	Return


M_RemapClose:
	Gui, 3: Destroy
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
		GuiControl, Enable, r_all
	}
	Else
	{
		GuiControl, Disable, r_all
	}
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

R_Remap7:
	Send, {%r_RemapFrom7%}
	Return

R_Remap8:
	Send, {%r_RemapFrom8%}
	Return

R_Remap9:
	Send, {%r_RemapFrom9%}
	Return


M_DisableKey:
	Return


N_ChangeInvisibility:
	GuiControlGet, n_ControlGet, , n_Enable
	If (n_ControlGet = 1)
	{
		GuiControl, Enable, n_a1
		GuiControl, Enable, n_a2
		GuiControl, Enable, n_a3
	}
	Else
	{
		GuiControl, Disable, n_a1
		GuiControl, Disable, n_a2
		GuiControl, Disable, n_a3
	}
	Return


N_Mode:
	Gui, Submit, Nohide
	If (n_a1 = 1)
		n_Mode := 1
	If (n_a2 = 1)
		n_Mode := 2
	If (n_a3 = 1)
		n_Mode := 3
	Return
	

N_Y1:
	Send, {q}{q}{q}{r}
	Return

N_V1:
	Send, {q}{q}{w}{r}
	Return

N_X1:
	Send, {w}{w}{q}{r}
	Return

N_D1:
	Send, {e}{e}{w}{r}
	Return

N_B1:
	Send, {q}{w}{e}{r}
	Return

N_F1:
	Send, {e}{e}{q}{r}
	Return

N_T1:
	Send, {e}{e}{e}{r}
	Return

N_C1:
	Send, {w}{w}{w}{r}
	Return

N_Z1:
	Send, {w}{w}{e}{r}
	Return

N_G1:
	Send, {q}{q}{e}{r}
	Return

N_Q1:
	Send, {q}{q}{q}
	Return

N_W1:
	Send, {w}{w}{w}
	Return

N_E1:
	Send, {e}{e}{e}
	Return


N_Y2:
	Send, {q}{q}{q}{r}{w}{w}{w}
	Sleep, 200
	Send, {y}
	Return

N_V2:
	Send, {q}{q}{w}{r}{w}{w}
	Sleep, 300
	Send,	{v}
	Return

N_X2:
	Send, {q}{w}{w}{r}{w}
	Sleep, 400
	Send,	{x}
	Return

N_D2:
	Send, {e}{e}{w}{r}{w}{w}
	Sleep, 300
	Send,	{d}
	Return

N_B2:
	Send, {q}{e}{w}{r}{w}{w}
	Sleep, 300
	Send,	{b}
	Return

N_F2:
	Send, {e}{e}{q}{r}{w}{w}{w}
	Sleep, 200
	Send,	{f}
	Return

N_T2:
	Send, {e}{e}{e}{r}{w}{w}{w}
	Sleep, 200
	Send,	{t}
	Return

N_C2:
	Send, {w}{w}{w}{r}
	Sleep, 500
	Send,	{c}
	Return

N_Z2:
	Send, {e}{w}{w}{r}{w}
	Sleep, 400
	Send,	{z}
	Return

N_G2:
	Send, {q}{q}{e}{r}{w}{w}{w}
	Sleep, 200
	Send,	{g}
	Return

N_Q2:
	Send, {q}{q}{q}
	Return

N_W2:
	Send, {w}{w}{w}
	Return

N_E2:
	Send, {e}{e}{e}
	Return

N_Y3:
	Send, {q}{q}{q}{r}{w}{w}{w}{y}
	Return

N_V3:
	Send, {q}{q}{w}{r}{w}{w}{v}
	Return

N_X3:
	Send, {q}{w}{w}{r}{w}{x}
	Return

N_D3:
	Send, {e}{e}{w}{r}{w}{w}{d}
	Return

N_B3:
	Send, {q}{e}{w}{r}{w}{w}{b}
	Return

N_F3:
	Send, {e}{e}{q}{r}{w}{w}{w}{f}
	Return

N_T3:
	Send, {e}{e}{e}{r}{w}{w}{w}{t}
	Return

N_C3:
	Send, {w}{w}{w}{r}{c}
	Return

N_Z3:
	Send, {e}{w}{w}{r}{w}{z}
	Return

N_G3:
	Send, {q}{q}{e}{r}{w}{w}{w}{g}
	Return

N_Q3:
	Send, {q}{q}{q}
	Return

N_W3:
	Send, {w}{w}{w}
	Return

N_E3:
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


3GuiEscape:
3GuiClose:
	Gui, 3: Destroy
	Return


/*
2.1.5
24-09-2012
1.Add Invoker options.

2.1.4
23-09-2012
1.Remap up to 9 options.

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