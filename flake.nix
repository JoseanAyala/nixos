{
  description = "NixOS and Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      username = "josean";
      hostname = "la-maquina";
      inherit (nixpkgs) lib;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          # Adds pkgs.noctalia (v5); nixpkgs' own noctalia-shell is still v4.
          inputs.noctalia.overlays.default

          # Adds pkgs.firefox-addons.* — built against THIS pkgs, so our
          # allowUnfree applies (the flake's packages output evaluates against
          # its own vanilla nixpkgs and refuses the unfree 1Password addon).
          inputs.firefox-addons.overlays.default
        ];
      };
    in
    {
      # System config
      nixosConfigurations = {
        ${hostname} = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit username hostname inputs;
          };
          modules = [ (./hosts + "/${hostname}/configuration.nix") ];
        };
      };

      # User config
      homeConfigurations = {
        ${username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit username hostname inputs;
          };
          modules = [ (./users + "/${username}/home.nix") ];
        };
      };
    };
}
