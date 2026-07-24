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
    inputs@{
      nixpkgs,
      home-manager,
      ...
    }:
    let
      username = "josean";
      inherit (nixpkgs) lib;

      colors = import ./assets/colors.nix;

      linuxOverlays = [
        inputs.noctalia.overlays.default
        inputs.firefox-addons.overlays.default
      ];

      mkHome =
        {
          system,
          hostname,
          modules,
          overlays ? [ ],
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system overlays;
            config.allowUnfree = true;
          };
          extraSpecialArgs = {
            inherit username hostname inputs;
          };
          inherit modules;
        };

    in
    {
      # System config
      nixosConfigurations = {
        la-maquina = lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit username inputs colors;
            hostname = "la-maquina";
          };
          modules = [ ./hosts/la-maquina/configuration.nix ];
        };
      };

      # User config — keyed per platformk
      homeConfigurations = {
        nixos = mkHome {
          system = "x86_64-linux";
          hostname = "la-maquina";
          overlays = linuxOverlays;
          modules = [ ./hosts/la-maquina/home.nix ];
        };

        macbook = mkHome {
          system = "aarch64-darwin";
          hostname = "macbook";
          modules = [ ./hosts/macbook/home.nix ];
        };
      };
    };
}
