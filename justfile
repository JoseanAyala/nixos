# Set global variables
flake_dir := "."
host := "la-maquina"
user := "josean"

# Default recipe runs both system and user configurations
all: system user

# Flakes only evaluate *tracked* files. --intent-to-add marks new files as tracked
stage:
    git add --intent-to-add -A

# Rebuild the NixOS system configuration
system: stage
    echo "Rebuilding NixOS System..."
    sudo nixos-rebuild switch --flake {{flake_dir}}#{{host}}

# Rebuild the Home Manager user configuration
user: stage
    echo "Rebuilding Home Manager Profile..."
    home-manager switch --flake {{flake_dir}}#{{user}}

# Rebuild Home Manager profile and back up conflicting files
user-backup backup="hm.back": stage
    echo "Rebuilding Home Manager Profile with backup extension {{backup}}..."
    home-manager switch --flake {{flake_dir}}#{{user}} -b {{backup}}

# Update all Flake locks and inputs
update:
    nix flake update

# Check formatting and lint all Nix files. hardware-configuration.nix is
# generated (statix.toml ignores it too), so it's excluded here.
lint:
    nixfmt --check $(fd -e nix -E hardware-configuration.nix)
    statix check .

# Delete old generations and free up disk space.
clean:
    echo "Deleting user + Home Manager generations older than 14d..."
    nix-collect-garbage --delete-older-than 14d
    echo "Deleting system generations older than 14d..."
    sudo nix-collect-garbage --delete-older-than 14d
    echo "Deduplicating the store..."
    sudo nix store optimise
