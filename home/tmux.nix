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
        plugin = tmuxPlugins.tmux-nova;
        extraConfig = ''
          set -g @nova-nerdfonts true

          set -g @nova-nerdfonts-left 
          set -g @nova-nerdfonts-right 
          set -g @nova-nerdfonts-first 
          set -g @nova-nerdfonts-last 

          set -g @nova-segment-mode "#{?client_prefix,Ω,ω}"
          set -g @nova-segment-mode-colors "#50fa7b #282a36"

          set -g @nova-pane "#I#{?pane_in_mode,  #{pane_mode},}  #W"

          set -g @nova-rows 0
          set -g @nova-segments-0-left "mode"
          set -g @nova-segments-0-right ""
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
