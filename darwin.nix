{ pkgs, ... }:

{
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config = {
    allowUnfree = true;
    ollama = {
      syncModels = true;
    };
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    coreutils-prefixed
    direnv
    fd
    ffmpeg
    hatch
    listenbrainz-mpd
    mpd
    mpd-discord-rpc
    # nodePackages.node2nix
    nodejs_24
    ollama
    orbstack
    pyenv
    qmk
    tldr
    tmux
    uv
    vim
    yt-dlp
  ];

  # LaunchAgents
  launchd = {
    user = {
      agents = {
        mpd-discord-rpc = {
          command = "${pkgs.mpd-discord-rpc}/bin/mpd-discord-rpc";
          serviceConfig = {
            KeepAlive = true;
            RunAtLoad = true;
            StandardOutPath = "/tmp/mpd-discord-rpc.out";
            StandardErrorPath = "/tmp/mpd-discord-rpc.err";
          };
        };

        mpd = {
          command = "${pkgs.mpd}/bin/mpd --no-daemon";
          serviceConfig = {
            KeepAlive = true;
            RunAtLoad = true;
            ProcessType = "Interactive";
            LimitLoadToSessionType = [
              "Aqua"
              "Background"
              "LoginWindow"
              "StandardIO"
              "System"
            ];
          };
        };

        listenbrainz-mpd = {
          command = "${pkgs.listenbrainz-mpd}/bin/listenbrainz-mpd";
          serviceConfig = {
            KeepAlive = true;
            RunAtLoad = true;
            StandardOutPath = "/tmp/listenbrainz-mpd.out";
            StandardErrorPath = "/tmp/listenbrainz-mpd.err";
          };
        };
      };
    };
  };

  # You might think this isn't required if it's in the home module, but actually
  # it very much is required in order to have any Nix anything in PATH.
  programs.zsh.enable = true;
  programs.fish.enable = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  nix.settings.allowed-users = [ "root" "valrus" ];
  nix.settings.trusted-users = [ "root" "valrus" ];
  system.primaryUser = "valrus";

  # Determinate needs this for its own stuff apparently
  nix.enable = false;

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
    # taps = [
    #   {
    #     name = "gbevin/tools/showmidi";
    #     trusted = true;
    #   }
    # ];
    brews = [
      "python-setuptools"
    ];
    casks = [
      "alfred"
      "calibre"
      "deltachat"
      "discord"
      "floorp"
      "gbevin/tools/showmidi"
      "ghostty"
      "hammerspoon"
      "iina"
      "plugdata"
      "signal"
      "font-maple-mono"
      "font-recursive-code"
    ];
  };

  users.users.valrus = {
    name = "valrus";
    home = "/Users/valrus";
  };
}
