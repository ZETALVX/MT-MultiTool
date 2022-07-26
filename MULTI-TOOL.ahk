I_Icon = MultiTool.ico
IfExist, %I_Icon%
  Menu, Tray, Icon, %I_Icon%

fsAttivato=0
NoteAttivato=0
KPAttivato=0

Gui, New, ,"Welcome"
Gui, Font, s40 ,
Gui, Add, Text,, ░M░u░l░t░i░T░o░o░l░
Gui, Font, s40 ,
Gui, Add, Text, cRed +Right w485, B𝐲 ZETALVX
Gui, Font, s10,
Gui, Add, Text, cRed +Right w650, ALT + H (HELP)
Gui, Show,AutoSize,Welcome
WinSet, Top,,"ahk_exe" "Welcome"
;sleep 1500
;While WinExist("ahk_exe " "Welcome")

;---------------------------------------------------------------

!SPACE::  Winset, Alwaysontop, , A

;---------------------------------------------------------------

!s::
Gui, New, ,"FastSearch"
GuiControl,,Edit%A_index%,
fsAttivato=1
Gui, Add, Text,, Enter your search:
Gui, Add, Edit, w400 h100 vtext,
Gui, Add, Text,, Where?
Gui, Add, DropdownList,w400 h100 vList,DuckDuckGo||Google|Yahoo|Odysee|Youtube|Link
Gui, Add, Button,gOk wp,Search
Gui, Font, s12,Courier New
Gui, Add, Text,cRed +Right w400, by ZETALVX
Gui, Show,AutoSize,FastSearch
WinSet, Top,,"ahk_exe" "FastSearch"
return

Ok:
Gui,Submit,Nohide ;Remove Nohide if you want the GUI to hide.
;MsgBox, You want to do '%List%' with '%text%'
StringLen, textl, text
if(List="Google")
{
parameter = https://www.google.com/search?q=%text%
StringReplace, parameter, parameter, %A_Space%, +, All
Run %parameter%
}
if(List="DuckDuckGo")
{
parameter = https://duckduckgo.com/?q=%text%
StringReplace, parameter, parameter, %A_Space%, +, All
Run %parameter%
}
if(List="Odysee")
{
parameter = https://odysee.com/$/discover?t=%text%
StringReplace, parameter, parameter, %A_Space%, +, All
Run %parameter%
}
if(List="Youtube")
{
parameter = https://www.youtube.com/results?search_query=%text%
StringReplace, parameter, parameter, %A_Space%, +, All
Run %parameter%
}
if(List="Yahoo")
{
parameter = https://search.yahoo.com/search?p=%text%
StringReplace, parameter, parameter, %A_Space%, +, All
Run %parameter%
}
if(List ="Link")
{
parameter = %text%
StringReplace, parameter, parameter, https://, , All
StringReplace, parameter, parameter, http://, , All
Run https://%parameter%
}
;if you want to close the program after the search add this line --> While WinExist("ahk_exe " "FastSearch")
return

;GuiClose:
;While WinExist("ahk_exe " "FastSearch")

;---------------------------------------------------------------

;Minimize window

!f7::WinMinimize, A
return

; Minimize All Windows
!F8::
	WinGet, WindowList, List,,, Program Manager
	Loop, %WindowList%
	{
		WinGetClass, Class, % "ahk_id " . WindowList%A_Index%
		IF (Class <> "Shell_SecondaryTrayWnd" And Class <> "Shell_TrayWnd")
			WinMinimize, % "ahk_id " . WindowList%A_Index%
	}
return

; Restore All Windows
!F9::
	WinGet, WindowList, List,,, Program Manager
	WinGetTitle, active_title, A
	Loop, %WindowList%
	{
		WinGetClass, Class, % "ahk_id " . WindowList%A_Index%
		IF (Class <> "Shell_SecondaryTrayWnd" And Class <> "Shell_TrayWnd")
			WinRestore, % "ahk_id " . WindowList%A_Index%
	}
	WinActivate, %active_title%
    WinWaitActive, %active_title%, , 3
return
;---------------------------------------------------------------

!n::
if(NoteAttivato=0)
{
;Gui, New, ,"Easy NotePad"
GuiControl,,Edit%A_index%,
Gui, Add, Edit, w600 h500 cptext,
Gui, Font, s12,Courier New
Gui, Add, Text,cRed +Right w600, by ZETALVX
NoteAttivato=1
}
Gui, Show,AutoSize,Easy NotePad
WinSet, Top,,"ahk_exe" "Easy NotePad"
return

;---------------------------------------------------------------

^n::
WinGet, active_name, ProcessName, A
clipboard := active_name
tooltip %active_name%
sleep 1500
tooltip
return

^p::
inputbox, pse, Kill Process, Insert the process to kill:
WinSet, Top,,"ahk_exe" "Kill Process"
if (errorlevel = 1)
{
return
}
else 
{
pse := pse
While WinExist("ahk_exe " pse)
process, close, %pse%
;soundplay %DING_FILE% 
;this is a sound file
tooltip %pse% closed
tooltip
}
return

!k::
WinGet, active_name, ProcessName, A
clipboard := active_name
tooltip %active_name%
tooltip
if (errorlevel = 1)
{
return
}
else 
{
While WinExist("ahk_exe " clipboard)
process, close, %clipboard%
tooltip %clipboard% closed
sleep, 1000
tooltip
}
return

;---------------------------------------------------------------

;Volume control, Alt+UP/DOWN/M 

!Up::Volume_Up
!Down::Volume_Down
!m::Volume_Mute

;---------------------------------------------------------------

!v::
    Run SndVol.exe
	WinSet, Top,,"SndVol.exe" 
return

;---------------------------------------------------------------

;MsgBox % RunWaitOne("dir " A_ScriptDir)

;MsgBox % RunWaitMany("
;(
;echo Put your commands here,
;echo each one will be run,
;echo and you'll get the output.
;)")

RunWaitOne(command) {
    ; WshShell object: http://msdn.microsoft.com/en-us/library/aew9yb99
    shell := ComObjCreate("WScript.Shell")
    ; Execute a single command via cmd.exe
    exec := shell.Exec(ComSpec " /C " command)
    ; Read and return the command's output
    return exec.StdOut.ReadAll()
}

RunWaitMany(commands) {
    shell := ComObjCreate("WScript.Shell")
    ; Open cmd.exe with echoing of commands disabled
    exec := shell.Exec(ComSpec " /Q /K echo off")
    ; Send the commands to execute, separated by newline
    exec.StdIn.WriteLine(commands "`nexit")  ; Always exit at the end!
    ; Read and return the output of all commands
    return exec.StdOut.ReadAll()
}

;---------------------------------------------------------------

!p::
inputbox, pingText, Ping Site, Inser the site to ping:
if (errorlevel = 1)
{
return
}
else 
{
While WinExist("ahk_exe " pingText)
process, close, %pingText%
tooltip %pingText% closed
;pingText := pingText
MsgBox % RunWaitOne("ping " pingText)
}
;sleep, 1000

return

;---------------------------------------------------------------

;Show public IP

!i::
;MsgBox % "Your public IP is: " RunWaitOne("curl -s http://ifconfig.me")
Gui, New, ,"SMI - SHOW MY IP"
Gui, Font, s40 ,
Gui, Add, Text,,ʏᴏᴜʀ ᴘᴜʙʟɪᴄ ɪᴘ ɪs:
Gui, Font, s40 ,
Gui, Add, Text, Texta cRed +Right w367, % RunWaitOne("curl -s http://ifconfig.me")
clipboard := RunWaitOne("curl -s http://ifconfig.me")
Gui, Font, s12,Courier New
Gui, Add, Text,cRed +Right w400, by ZETALVX
Gui, Show,AutoSize,SMI - SHOW MY IP
;A:	
;sleep 5000
;GuiControl,, Texta cRed +Right w500, % RunWaitOne("curl -s http://ifconfig.me")
;Goto, A
;MsgBox % "Your public IP is: " RunWaitOne("curl -s http://ifconfig.me")
return

;---------------------------------------------------------------

;IF CONFIG

!l::
MsgBox % RunWaitOne("ipconfig")
return

;---------------------------------------------------------------

;HELP

!h::
Gui, New, ,"Help"
GuiControl,,Edit%A_index%,
Gui, Add, Text,cRed, HELP--------------------------------------- ALT + H:
Gui, Add, Text,cRed, UTILITY:
Gui, Add, Text,, Windows Always on Top---------- ALT + SPACE:
Gui, Add, Text,, Fast Search Tool--------------------- ALT + S:
Gui, Add, Text,, NotePad Tool-------------------------- ALT + N:
Gui, Add, Text,cRed, MINIMIZE / MAXIMIZE WINDOWS:
Gui, Add, Text,, Minimize a Window------------------ ALT + F7:
Gui, Add, Text,, Minimize all windows---------------- ALT + F8:
Gui, Add, Text,, Maximize all windows--------------- ALT + F9:
Gui, Add, Text,cRed, AUDIO TOOL:
Gui, Add, Text,, Mixer Volume------------------------- ALT + V:
Gui, Add, Text,, Volume Up/Down/Mute----------- ALT + Up Arrow/Down Arrow/M:
Gui, Add, Text,cRed, PROCESS TOOL:
Gui, Add, Text,, Kill process ----------------------------- ALT + K
Gui, Add, Text,, Show Name Process--------------- Ctrl + N
Gui, Add, Text,, Write che process to close ------ Ctrl + P
Gui, Add, Text,cRed, LAN TOOL:
Gui, Add, Text,, Show Public IP---------------------- ALT + I:
Gui, Add, Text,, IPCONFIG---------------------------- ALT + L:
Gui, Add, Text,, PING ----------------------------------- ALT  + P:
Gui, Font, s12,Courier New
Gui, Add, Text,cRed +Right w400, by ZETALVX
Gui, Show,AutoSize,Help

