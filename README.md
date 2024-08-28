### system update

To activate a new system configuration:

``` sh
nix build .#darwinConfigurations.Mac-Studio.system
```

### home-manager

To activate a new home-manager configuration:

(first run)
```sh
nix run home-manager -- build --flake "/Users/valrus/.config/nix" switch
```

(subsequently)
``` sh
home-manager --flake ~/.config/nix switch
```

### nix-darwin

``` sh
nix run nix-darwin -- switch --flake ~/.config/nix
```

``` sh
darwin-rebuild switch --flake ~/.config/nix
```

For some reason this wipes out starship and you have to re-up the `home-manager` config.
