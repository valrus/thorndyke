{
  description = "Darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";

    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{
    self
    , nixpkgs
    , home-manager
    , nix-darwin
    , mac-app-util
    , ...
  }: {
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
          mac-app-util.darwinModules.default

          inputs.home-manager.darwinModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.valrus.imports = [
                ./home
                mac-app-util.homeManagerModules.default
              ];
              # import ./home;
            };
          }
        ];
      };
    };
  };
}
