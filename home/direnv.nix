{ config, lib, pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    # This is default, adding it will only complain about multiple defs
    # enableFishIntegration = true;
    nix-direnv.enable = true;
  };
}
