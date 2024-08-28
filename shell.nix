{ ... }: {
  programs = {
    zsh = {
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
        eval "$(/opt/homebrew/bin/brew shellenv)"
        export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
      '';

      plugins = [ ];
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
