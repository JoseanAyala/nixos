{
  description = "Home Manager configuration of Josean";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
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
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # System config
      nixosConfigurations = {
        josean-nixos = lib.nixosSystem {
          inherit system;
          modules = [./configuration.nix];
        };
      };

      # User config
      homeConfigurations = {
        josean = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
          # Optionally use extraSpecialArgs to pass through arguments to home.nix
        };
      };
    };
}
