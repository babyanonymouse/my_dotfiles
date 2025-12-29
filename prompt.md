Window Manager	Hyprland	Wayland native, tiled, scriptable.
Terminal	Alacritty	GPU-accelerated but lightweight. Fastest startup time.
Shell	Zsh + Starship	fast syntax highlighting + instant git context.
Status Bar	Waybar	Heavily stripped down. Text-based modules only.
Launcher	Fuzzel	A lightweight, text-based app launcher (lighter than Rofi).
Wallpaper	Hyprpaper	The most basic wallpaper utility.
Notification	Mako	Minimalist notification daemon.


🎨 Aesthetic & Design System
The look should be "Hacker Minimalist."

Color Palette: Catppuccin Mocha (Dark, low eye strain, high contrast for code).

Font: JetBrains Mono Nerd Font (Size 11).

Borders:

Width: 1px or 2px.

Active Color: Lavender/Blue (Focus).

Inactive Color: Grey/Surface (Background).

Decorations (CRITICAL):

Blur: OFF (Saves GPU/Heat).

Shadows: OFF (Saves GPU/Heat).

Animations: Fast (0.1s - 0.2s) or OFF.

Rounding: 0px or 4px (Sharp corners preferred).

⚙️ Functional Requirements
1. The "Heat-Safe" Bar (Waybar)
The status bar must monitor hardware health constantly.

Left: Workspace numbers (1, 2, 3...).

Center: Clock (Day, HH:MM).

Right:

CPU Temp: (CRITICAL) Must turn RED if > 80°C.

RAM Usage: GB Used.

Battery: Percentage + Status.

Tray: For background apps.

2. Window Management Rules
Tiling: Master or Dwindle layout (User preference: Dwindle).

Workspaces:

Workspace 1: Coding (Terminal / Editor).

Workspace 2: Browser.

Workspace 3: Social/Music.

Focus: Mouse movement focuses window, but click raises it.

3. Keybindings (The Workflow)
Modifier: SUPER Key.

Super + Return: Open Terminal.

Super + Space: Open Launcher (Fuzzel).

Super + Q: Close Window.

Super + Tab: Window Switcher (List view, no heavy previews).

Super + F: Fullscreen.

Super + 1-9: Switch Workspace.

Super + Shift + 1-9: Move window to Workspace.

🤖 AI Generation Prompts
Use these prompts when asking Gemini to write the code.

Prompt 1: The Core Config
"Act as a Linux Systems Engineer. Generate a hyprland.conf file based on the 'Zero-Drag' specifications.

Constraints:

Disable all 'decoration' settings (blur, drop_shadow) to prevent overheating.

Set animations to be extremely fast/instant.

Use input settings: remove mouse acceleration, disable NumLock by default.

Include the keybindings defined in the README."

Prompt 2: The Status Bar
"Create a config and style.css for Waybar.

Design: Minimalist, floating island style, Catppuccin Mocha colors. Modules: Workspaces, Clock, Battery, Memory, and a custom Temperature module. Critical Logic: The Temperature module class must change to 'critical' (Red background) if the sensor output is above 80 degrees. Use the hwmon path logic."

Prompt 3: The Terminal & Shell
"Create an alacritty.toml config using the Catppuccin Mocha theme. Font size 11. Also, provide a starship.toml configuration that is 'no-nonsense'. Only show the directory, git branch, and package version (Node/Python) when relevant. Hide everything else."