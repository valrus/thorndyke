{ pkgs, ... }: 

let
  emacs-overlay = import (fetchTarball {
    url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
  });
  my-emacs = pkgs.emacs.override {
    withNativeCompilation = false;
    withSQLite3 = true;
    withTreeSitter = true;
    withWebP = true;
  };
  my-emacs-with-packages = (pkgs.emacsPackagesFor my-emacs).emacsWithPackages (epkgs: with epkgs; [
    vterm
    multi-vterm
    treesit-grammars.with-all-grammars
  ]);
in
  {
    programs.emacs = {
      enable = true;
      package = my-emacs-with-packages;
    };

    home.packages = with pkgs; [
      emacs-all-the-icons-fonts
      starship
    ];
  }
