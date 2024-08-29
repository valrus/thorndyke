{ config, lib, pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./core.nix
    ./starship.nix
  ];

  home = {
    stateVersion = "24.05";
    username = "valrus";
    homeDirectory = "/Users/valrus";
    preferXdgDirectories = true;
    sessionVariables = {
      XDG_CONFIG_HOME = "$HOME/.config";
      MPD_HOST = "$HOME/.mpd/mpd.socket";
      MUSIC = "/Volumes/Multimedia/iTunes Media/";
      EMACS = "$(which emacs)";
      SITE = "$HOME/Sites";
    };
  };

  programs.home-manager.enable = true;
}
