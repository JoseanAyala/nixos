<div align="center">

# ❄️ dotfiles

**NixOS + Home Manager configuration`**

Declarative, flake-based, and rebuilt with a single `just` command.

![NixOS](https://img.shields.io/badge/NixOS-unstable-5277C3?logo=nixos&logoColor=white)
![Home Manager](https://img.shields.io/badge/Home%20Manager-flake-64B5F6)
![Hyprland](https://img.shields.io/badge/Hyprland-Wayland-58E1FF)

</div>

---

## At a glance

| | |
|---|---|
| **OS** | NixOS (unstable) |
| **Compositor** | [Hyprland](https://hyprland.org/) via UWSM |
| **Shell / bar / launcher** | [Noctalia](https://github.com/noctalia-dev/noctalia) (v5) |
| **Terminal** | Ghostty |
| **Shell** | fish |
| **Editors** | Neovim · Zed |
| **Browser** | Firefox — addons managed declaratively |
| **File managers** | Yazi (default) · Dolphin |
| **Boot** | Limine + Plymouth splash |
| **Audio** | PipeWire |
| **Font** | MesloLG Nerd Font |
| **Extras** | Steam (gamescope session) · 1Password · NVIDIA |

## Layout

```
.
├── flake.nix              # Inputs, overlays, and both configurations
├── justfile               # Rebuild / update / lint / clean recipes
├── hosts/
│   └── la-maquina/        # System config + generated hardware config
├── modules/
│   ├── nixos/             # System modules: boot, audio, hyprland, nvidia, steam, 1password
│   └── home/              # User modules: cli, fish, ghostty, firefox, neovim, zed, noctalia, hypr…
└── users/
    └── josean/home.nix    # Home Manager entry point — imports the home modules
```

One flake, two outputs — the **system** and the **user environment**. They
rebuild independently: `just system` · `just user` · or simply `just` for both.
