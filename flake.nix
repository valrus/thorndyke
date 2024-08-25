{
  description = "Darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, darwin }:
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#home
    darwinConfigurations."home" = darwin.lib.darwinSystem {
      # Set Git commit hash for darwin-version.
      system = "aarch64-darwin";
      modules = [
        home-manager.darwinModules.home-manager
        ./default.nix
        {
          users.users.valrus.home = "/Users/valrus";
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."home".pkgs;

    homeConfigurations = {
      "valrus" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [ ./home.nix ./shell.nix ];
      };
    };
  };
}
