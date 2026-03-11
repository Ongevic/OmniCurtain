# OmniCurtain

OmniCurtain is a small AutoHotkey script for Windows that hides the currently active window and lets you restore it from the system tray.

It is useful when you want to quickly hide a PowerShell window or another app without closing it.

## Requirements

- Windows
- AutoHotkey v1

Install AutoHotkey from the official website:

- [AutoHotkey website](https://www.autohotkey.com/)
- [Official AutoHotkey GitHub releases](https://github.com/AutoHotkey/AutoHotkey/releases)

This script uses AutoHotkey v1 syntax, so Windows users should install a v1-compatible AutoHotkey release before running `omnicurtain.ahk`.

## How to use

1. Install AutoHotkey on Windows.
2. Double-click `omnicurtain.ahk` to start the script.
3. Open the app you want to hide.
4. Press `Win + Ctrl + Down` to hide the active window to the tray.
5. Double-click the tray icon menu entry to restore the hidden window.

This is especially handy for PowerShell, terminal windows, and other apps you want out of sight without closing them.

## What it does

- Hides the currently active window
- Stores that window so it can be restored later
- Adds a tray menu item named `Restore Window`
- Restores the hidden window when selected from the tray

## Files

- `omnicurtain.ahk`: main AutoHotkey script
- `LICENSE`: MIT license
- `SECURITY.md`: security and safe-install notes

## License

Released under the MIT License. See [LICENSE](LICENSE).

A star or any appreciation is always welcome.
