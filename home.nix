{ pkgs, ... }: 

let
  emacs-overlay = import (fetchTarball {
    url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
    sha256 = "1jppksrfvbk5ypiqdz4cddxdl8z6zyzdb2srq8fcffr327ld5jj2";
  });
  my-emacs = pkgs.emacs29.override {
    withNativeCompilation = true;
    withSQLite3 = true;
    withTreeSitter = true;
    withWebP = true;
  };
in
  {
    imports = [
      ./shell.nix
    ];

    home = {
      stateVersion = "23.11";
      username = "valrus";
      homeDirectory = "/Users/valrus";
      packages = with pkgs; [
        emacs-all-the-icons-fonts
      ];
      preferXdgDirectories = true;
      sessionVariables = {
        XDG_CONFIG_HOME = "$HOME/.config";
        MPD_HOST = "$HOME/.mpd/mpd.socket";
        MUSIC = "/Volumes/Multimedia/iTunes Media/";
        EMACS = "$(which emacs)";
        SITE = "$HOME/Sites";
      };
    };

    programs.emacs = {
      enable = true;
      package = my-emacs;
      extraPackages = (epkgs: with epkgs; [
        vterm
        multi-vterm
        treesit-grammars.with-all-grammars
      ]);
    };

    programs.home-manager.enable = true;
  }
