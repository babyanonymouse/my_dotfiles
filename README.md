# Zero-Drag Hyprland Dotfiles

A high-performance, minimalist Hyprland configuration optimized for **CachyOS** and thermally constrained hardware.
**Philosophy**: "Function over Flash". Precision, efficiency, and zero distractions.

## 🏁 Philosophy

> "I am the guy in the garage tuning a race car engine that’s running hot. I need precision, efficiency, and zero distractions."

- **Visuals**: Catppuccin Mocha, High Contrast, Sharp Corners.
- **Performance**: Zero Blur, Zero Shadows, Zero Bloat.
- **Thermal Safety**: Critical red-line indicators for CPU heat.

## 🛠️ Software Stack

Selected for startup speed and low footprint.

| Component     | Selection     | Why?                                         |
| ------------- | ------------- | -------------------------------------------- |
| **WM**        | **Hyprland**  | Lightweight, scriptable, no overhead.        |
| **Terminal**  | **Alacritty** | Fastest startup, GPU acceleration, no bloat. |
| **Launcher**  | **Fuzzel**    | Wayland-native, lightweight.                 |
| **Bar**       | **Waybar**    | Stripped down with "Heat-Safe" logic.        |
| **Wallpaper** | **Hyprpaper** | Efficient wallpaper daemon.                  |
| **Notify**    | **Mako**      | Minimalist daemon.                           |

## 🎨 Design System

- **Theme**: Catppuccin Mocha
- **Font**: JetBrains Mono Nerd Font (Size 11)
- **Rounding**: **0px** (Sharp corners)
- **Decorations**: NONE (No blur, no shadows)
- **Animations**: Disabled (or instant) for thermal control.

## ⚙️ Key Features

### "Heat-Safe" Status Bar

The Waybar CPU temperature module is configured to turn **RED** (Critical) if the sensor exceeds **80°C**.
Modules: Workspaces, Clock, CPU Temp, RAM, Battery.

### Keybindings (Core Workflow)

| Key                   | Action                    |
| --------------------- | ------------------------- |
| `SUPER + Return`      | Open Terminal (Alacritty) |
| `SUPER + Space`       | Open Launcher (Fuzzel)    |
| `SUPER + Tab`         | Window Switcher           |
| `SUPER + Q`           | Close Window              |
| `SUPER + F`           | Fullscreen                |
| `SUPER + 1-9`         | Switch Workspace          |
| `SUPER + Shift + 1-9` | Move to Workspace         |

## 📦 Installation

### Prerequisites

- CachyOS (or Arch Linux)
- Git

### Quick Install

```bash
git clone https://github.com/babyanonymouse/my_dotfiles.git
cd my_dotfiles
./install.sh
```

The script will installed all required packages (`alacritty`, `fuzzel`, `hyprland`, etc.) and back up your existing configurations.

## 📄 License

Provided as-is for personal use.
