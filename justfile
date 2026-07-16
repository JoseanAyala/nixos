# Set global variables
flake_dir := "."
host := "la-maquina"
user := "josean"

# Default recipe runs both system and user configurations
all: system user

# Rebuild the NixOS system configuration
system:
    echo "Staging files in Git..."
    git add .
    echo "Rebuilding NixOS System..."
    sudo nixos-rebuild switch --flake {{flake_dir}}#{{host}}

# Rebuild the Home Manager user configuration
user:
    echo "Staging files in Git..."
    git add .
    echo "Rebuilding Home Manager Profile..."
    home-manager switch --flake {{flake_dir}}#{{user}}

# Rebuild Home Manager profile and back up conflicting files
user-backup backup="hm.back":
    echo "Staging files in Git..."
    git add .
    echo "Rebuilding Home Manager Profile with backup extension {{backup}}..."
    home-manager switch --flake {{flake_dir}}#{{user}} -b {{backup}}

# Update all Flake locks and inputs
update:
    nix flake update

# Deep clean old generations and free up disk space
clean:
    echo "Deleting user generations..."
    nix-env --delete-generations old
    echo "Deleting system generations..."
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old
    echo "Running Garbage Collector..."
    nix-store --gc
