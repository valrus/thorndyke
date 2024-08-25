{ ... }: {
  home = {
    stateVersion = "23.11";
    username = "valrus";
    homeDirectory = "/Users/valrus";
    packages = [ ];
  };

  programs.home-manager.enable = true;

  home.preferXdgDirectories = true;
  home.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    MPD_HOST = "$HOME/.mpd/mpd.socket";
    MUSIC = "/Volumes/Multimedia/iTunes Media/";
    EMACS = "$(which emacs)";
    SITE = "$HOME/Sites";
    RUBY_CONFIGURE_OPTS = "--with-openssl-dir=$(brew --prefix openssl@1.1)";
  };
}
