### system update

To activate a new system configuration:

``` sh
nix build .#darwinConfigurations.home.system
```

### home-manager

To activate a new home-manager configuration:

```sh
home-manager --flake "/Users/valrus/.config/nix" switch
```
