### system update

To activate a new system configuration:

``` sh
nix build .#darwinConfigurations.Mac-Studio.system
```

### home-manager

To activate a new home-manager configuration:

```sh
nix run home-manager -- build --flake "/Users/valrus/.config/nix" switch
```

### nix-darwin

``` sh
nix run nix-darwin -- switch --flake ~/.config/nix
```

``` sh
# https://github.com/nix-darwin/nix-darwin/issues/1457
sudo darwin-rebuild switch --flake ~/.config/nix
```
