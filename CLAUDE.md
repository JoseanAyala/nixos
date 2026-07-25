# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A single Nix flake that builds both a NixOS system and a Home Manager user environment. `flake.nix` declares:

- `nixosConfigurations.la-maquina` — the desktop system (x86_64-linux).
- `homeConfigurations.nixos` — the Linux user environment (la-maquina, with the `noctalia` + `firefox-addons` overlays applied).
- `homeConfigurations.macbook` — a minimal macOS (aarch64-darwin) user environment; no overlays, imports only cli/fish/git/neovim.

System and user rebuild **independently** — they are separate flake outputs, not one merged config.

## Commands

Use the `justfile` recipes (require `just`):

- `just` — rebuild both system and user (`system` then `user`).
- `just system` — `sudo nixos-rebuild switch --flake .#la-maquina`.
- `just user` — `home-manager switch --flake .#nixos`.
- `just mac` — rebuild the macOS home config (`.#macbook`).
- `just user-backup` / `just mac-bak` — same rebuilds but pass `-b hm.back` to back up conflicting files.
- `just update` — `nix flake update`.
- `just lint` — `nixfmt --check` on all `.nix` files (excluding the generated `hardware-configuration.nix`) plus `statix check .`.
- `just clean` — garbage-collect generations older than 14d and optimise the store.

**Every rebuild recipe runs `git add --intent-to-add -A` first (`just stage`).** Flakes only evaluate git-*tracked* files, so a newly created file is invisible to the build until it's staged. When adding a new module/config file, it must be staged before a rebuild will see it.

Formatting is `nixfmt`; linting is `statix` (config in `statix.toml`, which ignores `hardware-configuration.nix`).

## Structure

- `hosts/<host>/` — per-machine entry points. `configuration.nix` is the NixOS entry (imports `modules/nixos/*`); `home.nix` is the Home Manager entry (imports `modules/home/*`). `hardware-configuration.nix` is generated, gitignored from linting, and host-specific.
- `modules/nixos/` — system modules (boot, audio, hyprland, nvidia, steam, 1password, display-manager). Flat `.nix` files.
- `modules/home/` — user modules. Simple ones are flat `.nix` files (`cli.nix`, `fish.nix`, `git.nix`, …); ones that ship an app's own config directory are a `default.nix` + a `config/` subtree (`hypr/`, `neovim/`, `noctalia/`, `zed/`, `herdr/`, `audio/`).

`specialArgs`/`extraSpecialArgs` inject `username`, `hostname`, and `inputs` into every module.

Note: the README's "Layout" section is slightly stale (it references a `users/josean/` path). The `hosts/` layout above is authoritative.

## Editable app configs (out-of-store symlinks)

Modules that wrap a config directory (`neovim`, `hypr`, `noctalia`, `zed`, …) do **not** copy the config into the Nix store. They use `config.lib.file.mkOutOfStoreSymlink` to link `~/.config/<app>` to the live path under `~/dotfiles/modules/home/<app>/config`:

```nix
xdg.configFile."nvim".source =
  config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/home/neovim/config";
```

Consequences worth knowing:

- Edits to files under those `config/` dirs take effect **immediately** (they're symlinked, not built) — no `home-manager switch` needed for a config change, only for adding/removing packages or new modules.
- The symlink target is an **absolute path** (`${config.home.homeDirectory}/dotfiles/...`), which assumes the repo is cloned at `~/dotfiles`. This is required for apps (like noctalia) that write back to their own config dir — a store-relative path would be read-only.

## Conventions

- Keep tool ownership scoped: shared CLI tools (git, ripgrep, fd, lazygit) are owned by `cli.nix`/`git.nix`, not duplicated into app modules, so removing an app module can't break the shell (see the comment in `modules/home/neovim/default.nix`).
- LSPs and language tooling are installed via Nix packages (in the relevant home module), not via the editor's own package manager.
- Do not add `Co-Authored-By` or any AI attribution to git commits.
