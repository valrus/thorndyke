{
  description = "Darwin configuration";

  inputs = {
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-darwin";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nix-darwin, ... }:
  {
    defaultPackage.aarch64-darwin = home-manager.defaultPackage.aarch64-darwin;

    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#home
    darwinConfigurations = let
      inherit (inputs.nix-darwin.lib) darwinSystem;
    in {
      "Mac-Studio" = darwinSystem {
        system = "aarch64-darwin";

        specialArgs = { inherit inputs; };

        modules = [
          ./darwin.nix
          home-manager.darwinModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.valrus = import ./home;
            };
          }
        ];
      };
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.Mac.pkgs;

    homeConfigurations = {
      "valrus" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "aarch64-darwin"; };
        modules = [ ./home ];
      };
    };
  };
}
