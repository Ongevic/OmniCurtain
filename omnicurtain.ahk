#Persistent
#SingleInstance, Force

global HiddenWindows := {}
global HiddenOrder := []

RefreshTrayMenu()
return

; Hotkey: Ctrl + Win + Down Arrow
^#Down::
    ; Get the ID of the currently active window
    WinGet, ActiveID, ID, A

    ; Ensure we don't accidentally hide the desktop or taskbar
    WinGetClass, WinClass, ahk_id %ActiveID%
    if (WinClass = "Progman" or WinClass = "WorkerW" or WinClass = "Shell_TrayWnd")
        return

    ; Skip windows that are already hidden by this script
    if (HiddenWindows.HasKey(ActiveID))
        return

    ; Get the window title for the tray menu
    WinGetTitle, WinTitle, ahk_id %ActiveID%
    if (WinTitle = "")
        WinTitle := "Untitled Window"

    HiddenWindows[ActiveID] := EscapeMenuText(WinTitle)
    HiddenOrder.Push(ActiveID)

    ; Hide the window
    WinHide, ahk_id %ActiveID%

    RefreshTrayMenu()
return

RestoreLastHidden:
    if (HiddenOrder.MaxIndex())
        RestoreWindowById(HiddenOrder[HiddenOrder.MaxIndex()])
return

RestoreSelectedWindow:
    RestoreWindowByLabel(A_ThisMenuItem)
return

RefreshTrayMenu() {
    global HiddenWindows
    global HiddenOrder

    Menu, Tray, NoStandard
    Menu, Tray, DeleteAll
    ; Ensure the submenu exists before trying to clear it.
    Menu, HiddenWindowsMenu, Add, __placeholder__, RestoreSelectedWindow
    Menu, HiddenWindowsMenu, DeleteAll

    if (HiddenOrder.MaxIndex()) {
        lastId := HiddenOrder[HiddenOrder.MaxIndex()]
        lastTitle := HiddenWindows[lastId]
        trayTip := "Hidden windows: " . HiddenOrder.MaxIndex()
        restoreLastLabel := "Restore Last Hidden (" . lastTitle . ")"

        Menu, Tray, Icon, shell32.dll, 3
        Menu, Tray, Tip, %trayTip%
        Menu, Tray, Add, %restoreLastLabel%, RestoreLastHidden
        Menu, Tray, Default, %restoreLastLabel%

        for _, winId in HiddenOrder {
            title := HiddenWindows[winId]
            Menu, HiddenWindowsMenu, Add, %title%, RestoreSelectedWindow
        }

        Menu, Tray, Add, Hidden Windows, :HiddenWindowsMenu
        Menu, Tray, Add
    } else {
        Menu, Tray, Icon, *
        Menu, Tray, Tip, AutoHotkey Script
    }

    Menu, Tray, Add, Exit, ExitScript
}

RestoreWindowByLabel(label) {
    global HiddenWindows

    for winId, title in HiddenWindows {
        if (title = label) {
            RestoreWindowById(winId)
            return
        }
    }
}

RestoreWindowById(winId) {
    global HiddenWindows
    global HiddenOrder

    if (!HiddenWindows.HasKey(winId))
        return

    WinShow, ahk_id %winId%
    WinActivate, ahk_id %winId%

    HiddenWindows.Delete(winId)
    RemoveHiddenId(winId)
    RefreshTrayMenu()
}

RemoveHiddenId(winId) {
    global HiddenOrder

    for index, currentId in HiddenOrder {
        if (currentId = winId) {
            HiddenOrder.RemoveAt(index)
            return
        }
    }
}

EscapeMenuText(text) {
    StringReplace, text, text, &, &&, All
    return text
}

ExitScript:
    ExitApp
return
