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
    home.packages = with pkgs; [
      emacs-all-the-icons-fonts
      starship
    ];

    programs.emacs = {
      enable = true;
      package = my-emacs;
      extraPackages = (epkgs: with epkgs; [
        vterm
        multi-vterm
        treesit-grammars.with-all-grammars
      ]);
    };
  }
