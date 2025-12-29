# Zero-Drag Hyprland Configuration

This document represents the curated selection of "Best Features" for the **Zero-Drag** environment. It combines the pragmatic philosophy of `prompt.md` with the structural optimizations from the existing generated configurations.

## 🏁 Philosophy: "Function over Flash"

> "I am the guy in the garage tuning a race car engine that’s running hot. I need precision, efficiency, and zero distractions."

- **OS Reference**: CachyOS (Arch Linux optimized)
- **Visuals**: Catppuccin Mocha, High Contrast, Sharp Corners.
- **Performance**: Zero Blur, Zero Shadows, Zero Bloat.

---

## 🛠️ Selected Software Stack

This stack is chosen for **startup speed** and **resource minimalism**.

| Component          | Selection          | Why?                                                                                                   |
| ------------------ | ------------------ | ------------------------------------------------------------------------------------------------------ |
| **Window Manager** | **Hyprland**       | Wayland native, scriptable, lowest overhead when configured correctly.                                 |
| **Terminal**       | **Alacritty**      | _Replaces Kitty._ Chosen for fastest possible startup time and GPU acceleration without feature bloat. |
| **Launcher**       | **Fuzzel**         | _Replaces Wofi._ A lightweight Wayland-native launcher that is significantly lighter than Rofi/Wofi.   |
| **Shell**          | **Zsh + Starship** | Fast syntax highlighting with a "no-nonsense" prompt (only specific contexts).                         |
| **Bar**            | **Waybar**         | Heavily stripped down. Includes custom "Heat-Safe" logic.                                              |
| **Wallpaper**      | **Hyprpaper**      | The most basic, efficient wallpaper utility.                                                           |
| **Notification**   | **Mako**           | Minimalist daemon. No animations.                                                                      |

---

## 🎨 Aesthetic & Design System

### Visual Rules

- **Theme**: Catppuccin Mocha.
- **Font**: JetBrains Mono Nerd Font (Size 11).
- **Borders**: 1px or 2px.
  - Active: Lavender/Blue.
  - Inactive: Grey.
- **Rounding**: **0px** (Sharp corners) per "Hacker Minimalist" vibe.

### 🚫 Performance Enforcements

- **Blur**: `enabled = false` (Critical for heat management).
- **Shadows**: `drop_shadow = false`.
- **Animations**: `0.1s` (Instant) or OFF.
- **VFR**: `misc:vfr = true` (Saves battery/power).

---

## ⚙️ Functional Requirements

### 1. The "Heat-Safe" Status Bar

_Standard Waybar modules plus:_

- **CPU Temp Red-Line**: The temperature module must dynamically switch class to `critical` (Red background, white text) if sensor > 80°C.
- **Layout**: Floating islands or minimal text blocks.
- **Modules**: Workspaces, Clock, CPU Temp, RAM, Battery.

### 2. Window Management Strategy

- **Layout**: Dwindle (Master is backup).
- **Workspaces**:
  1.  Coding (Terminal/Editor)
  2.  Browser
  3.  Social/Music
  4.  General
  5.  General
- **Focus**: Mouse movement focuses, Click raises.

### 3. Keybindings (The Core Workflow)

| Key                   | Action                      |
| --------------------- | --------------------------- |
| `SUPER + Return`      | Open Terminal (Alacritty)   |
| `SUPER + Space`       | Open Launcher (Fuzzel)      |
| `SUPER + Tab`         | Window Switcher (List view) |
| `SUPER + Q`           | Close Window                |
| `SUPER + F`           | Fullscreen                  |
| `SUPER + 1-9`         | Switch Workspace            |
| `SUPER + Shift + 1-9` | Move to Workspace           |

---

## 🚀 Migration Plan (From 'Minimal' to 'Zero-Drag')

The current `install.sh` sets up Kitty and Wofi. To achieve this configuration, we need to:

1.  **Update Package List**: Replace `kitty` with `alacritty`, `wofi` with `fuzzel`, add `hyprpaper`.
2.  **Generate Configs**:
    - `alacritty.toml` (Catppuccin colors).
    - `fuzzel.ini` (Catppuccin colors).
    - `waybar` config (Impl "Heat-Safe" logic).
    - `hyprland.conf` (Disable blur/shadows, update keybinds).
3.  **Update Script**: Modify `install.sh` to install the new selection.

---

_Created by Antigravity based on User Request._
