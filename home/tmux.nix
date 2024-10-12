{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    historyLimit = 100000;
    escapeTime = 0;
    keyMode = "vi";
    plugins = with pkgs; [
      tmuxPlugins.yank
      {
        plugin = tmuxPlugins.power-theme;
        extraConfig = ''
          set -g @tmux_power_theme 'moon'
          set -g @tmux_power_date_icon ' '
          set -g @tmux_power_time_icon ' '
          set -g @tmux_power_user_icon ' '
          set -g @tmux_power_session_icon ' '
          set -g @tmux_power_show_upload_speed false
          set -g @tmux_power_show_download_speed false
          set -g @tmux_power_show_web_reachable false
      '';
      }
    ];
    prefix = "C-a";
    terminal = "screen-256color";
    baseIndex = 1;

    extraConfig = ''
      # Backspace and Space for prev/next window like screen
      unbind BSpace
      bind BSpace previous-window
      unbind space
      bind space next-window

      # Intuitive window splits
      unbind %
      bind _ split-window
      bind | split-window -h

      # vi-style window and pane switching
      bind k select-pane -U
      bind j select-pane -D
      bind -r h select-window -t :-
      bind -r l select-window -t :+

      # Non-repeatable pane switching
      bind-key Up select-pane -U
      bind-key Down select-pane -D
      bind-key Left select-pane -L
      bind-key Right select-pane -R

      # Copy like vi
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection

      # Appearance
      set-option -g status-position bottom
      set-option -g status-justify left
    '';
  };
}
