{ ... }: {
  programs = {
    # trace: warning: valrus profile: Using relative paths in programs.zsh.dotDir is deprecated and will be removed in a future release.
    # Current dotDir: .config/zsh
    # Consider using absolute paths or home-manager config options instead.
    # You can replace relative paths or environment variables with options like:
    # - config.home.homeDirectory (user's home directory)
    # - config.xdg.configHome (XDG config directory)
    # - config.xdg.dataHome (XDG data directory)
    # - config.xdg.cacheHome (XDG cache directory)
    zsh = {
      enable = true;
      autocd = true;
      dotDir = ".config/zsh";
      defaultKeymap = "viins";
      autosuggestion = {
        enable = true;
      };
      enableCompletion = false;
      syntaxHighlighting = {
        enable = true;
      };

      initContent = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"

        # deprecated
        # set -x RUBY_CONFIGURE_OPTS "--with-openssl-dir=$(brew --prefix openssl@1.1)"

        # needed for pipx
        export PATH=$PATH:$HOME/.local/bin
      '';

      plugins = [ ];
    };

    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
        eval "$(/opt/homebrew/bin/brew shellenv)"

        # deprecated
        # set -x RUBY_CONFIGURE_OPTS "--with-openssl-dir=$(brew --prefix openssl@1.1)"

        # needed for pipx
        set PATH $PATH $HOME/.local/bin

        # enable pyenv virtualenv
        status --is-interactive; and pyenv virtualenv-init - | source
      '';
    };
  };
}
