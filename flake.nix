{
  description = "NixOS and Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      username = "josean";
      hostname = "josean-nixos";
      pkgs = nixpkgs.legacyPackages.${system};
      inherit (nixpkgs) lib;
    in
    {
      # System config
      nixosConfigurations = {
        ${hostname} = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit username hostname;
          };
          modules = [ (./hosts + "/${hostname}/configuration.nix") ];
        };
      };

      # User config
      homeConfigurations = {
        ${username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit username hostname;
          };
          modules = [ (./users + "/${username}/home.nix") ];
        };
      };
    };
}
