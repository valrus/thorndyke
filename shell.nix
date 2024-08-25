{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    defaultKeymap = "viins";
    autosuggestion = {
      enable = true;
      strategy = [ "history" ];
    };
    enableCompletion = false;
    syntaxHighlighting = {
      enable = true;
    };

    initExtra = ''
    '';

    plugins = with pkgs; [ ];
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
