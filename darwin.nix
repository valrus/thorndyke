{ pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    direnv
    fd
    nodePackages.node2nix
    pipx
    tmux
    vim
    yt-dlp
  ];

  # You might think this isn't required if it's in the home module, but actually
  # it very much is required in order to have any Nix anything in PATH.
  programs.zsh.enable = true;
  programs.fish.enable = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  nix.settings.allowed-users = [ "root" "valrus" ];
  nix.settings.trusted-users = [ "root" "valrus" ];

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
    taps = [
      "mopidy/mopidy"
      "qmk/qmk"
    ];
    brews = [
      "python-setuptools"
      "mopidy"
      "mopidy-mpd"
      {
        name = "mpd";
        restart_service = true;
      }
      "qmk"
    ];
    casks = [
      "alfred"
      "deltachat"
      "discord"
      "hammerspoon"
      "iina"
      "plugdata"
    ];
  };

  users.users.valrus = {
    name = "valrus";
    home = "/Users/valrus";
  };
}
