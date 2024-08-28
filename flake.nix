{
  description = "Darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nix-darwin }:
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
              users.valrus = import ./home.nix;
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
        modules = [ ./home.nix ];
      };
    };
  };
}
