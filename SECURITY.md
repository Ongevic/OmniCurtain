# Security Policy

## Supported platform

OmniCurtain is intended for Windows systems running AutoHotkey v1.

## Safe installation

- Download AutoHotkey only from official sources:
  - [https://www.autohotkey.com/](https://www.autohotkey.com/)
  - [https://github.com/AutoHotkey/AutoHotkey/releases](https://github.com/AutoHotkey/AutoHotkey/releases)
- Review the contents of `omnicurtain.ahk` before running it.
- Do not run modified copies from untrusted sources.

## Script behavior

This repository contains a simple local AutoHotkey script. It is designed to:

- detect the active window
- hide that window
- add a tray restore action
- restore the same window later

It does not include network features, account access, or remote update logic.

## Reporting a security issue

If you find a security issue in this repository, open a GitHub issue with:

- a short description of the problem
- affected file names
- steps to reproduce
- impact on users

Do not include private secrets or personal data in the report.
