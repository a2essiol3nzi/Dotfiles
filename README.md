# Axel's Dotfiles

Welcome to my personal collection of configuration files for Arch Linux. This repository contains my custom "rice" and settings for various tools, ranging from Suckless utilities to modern Wayland compositors.

## 📸 Previews

Here are some snapshots of the setup:

<p align="center">
  <img src="images/setup-271225.png" alt="Latest Setup" width="800px">
</p>

<details>
  <summary>More Screenshots</summary>
  
  ### Previous Iterations
  ![Setup 24-11-25](images/setup-241125.png)
  ![Setup 12-10-25](images/setup-121025.png)
  ![Setup 01-10-25](images/setup-011025.png)
  ![DWM Rice](images/dwm-rice.png)
</details>

## 🛠 Tools & Software

This repository includes configurations for:

- **Window Managers**: `dwm`, `sway`, `niri`
- **Terminals**: `alacritty`, `foot`
- **Editors**: `helix`
- **Utilities**:
  - `tmux` (Terminal multiplexer)
  - `tofi` (Launcher/Menu)
  - `waybar` (Status bar)
  - `dmenu` (Dynamic menu)
  - `slock` & `slstatus` (Suckless locking and status)
- **Others**: `fontconfig`

## 🚀 Installation

These dotfiles are organized to be easily managed. 

- **Standard Apps**: Most configurations reside in their respective folders and are meant to be linked or copied to `~/.config/`.
- **Suckless Tools**: Source code is provided for `dwm`, etc. You should enter each directory and run `make clean install` manually.

---
*Stay Minimal.*
