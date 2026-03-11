#Persistent
#SingleInstance, Force

; Variables to store the hidden window's ID
HiddenWinID := ""

; Hotkey: Ctrl + Win + Down Arrow
^#Down::
    ; Get the ID of the currently active window
    WinGet, ActiveID, ID, A
    
    ; Ensure we don't accidentally hide the desktop or taskbar
    WinGetClass, WinClass, ahk_id %ActiveID%
    if (WinClass = "Progman" or WinClass = "WorkerW" or WinClass = "Shell_TrayWnd")
        return

    ; Store the ID so we can restore it later
    HiddenWinID := ActiveID
    
    ; Get the window title for the tray tooltip
    WinGetTitle, WinTitle, ahk_id %ActiveID%
    
    ; Hide the window
    WinHide, ahk_id %ActiveID%
    
    ; Change the tray icon and tooltip to show something is hidden
    Menu, Tray, Icon, shell32.dll, 3  ; Change to a generic folder/document icon
    Menu, Tray, Tip, Hidden: %WinTitle%
    
    ; Add a menu item to restore
    Menu, Tray, Add, Restore Window, RestoreWin
    Menu, Tray, Default, Restore Window ; Make double-click restore it
return

; Function to restore the hidden window
RestoreWin:
    if (HiddenWinID != "") {
        ; Show the window
        WinShow, ahk_id %HiddenWinID%
        
        ; Bring it to the front
        WinActivate, ahk_id %HiddenWinID%
        
        ; Reset variables
        HiddenWinID := ""
        
        ; Reset Tray Menu
        Menu, Tray, Delete, Restore Window
        Menu, Tray, Icon, * ; Reset to default AHK icon
        Menu, Tray, Tip, AutoHotkey Script ; Reset tooltip
    }
return