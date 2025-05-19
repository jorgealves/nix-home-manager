# Here I´m installing and configuring ZSH tools
{pkgs, pkgs-unstable, ... }:
{
  programs.bat.enable = true;
  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = true;
  };
  programs.htop.enable = true;
  programs.zsh = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    package = pkgs-unstable.starship;
  };

  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.catppuccin
      tmuxPlugins.resurrect
      tmuxPlugins.continuum
    ];
    extraConfig = ''
      # First remove *all* keybindings
      # unbind-key -a
      # Now reinsert all the regular tmux keys
      # bind ^X lock-server
      # bind * list-clients
      # bind H previous-window
      # bind L next-window
      # bind r command-prompt "rename-window %%"
      # bind R source-file ~/.config/tmux/tmux.conf
      # bind ^A last-window
      # bind ^W list-windows
      # bind w list-windows
      # bind z resize-pane -Z
      # bind ^L refresh-client
      # bind l refresh-client
      bind '\' split-window -h -c "#{pane_current_path}"
      bind '-' split-window -c "#{pane_current_path}"
      # bind '"' choose-window
      # bind h select-pane -L
      # bind j select-pane -D
      # bind k select-pane -U
      # bind l select-pane -R
      # bind -r -T prefix , resize-pane -L 20
      # bind -r -T prefix . resize-pane -R 20
      # bind -r -T prefix - resize-pane -D 7
      # bind -r -T prefix = resize-pane -U 7
      # bind : command-prompt
      # bind * setw synchronize-panes
      # bind P set pane-border-status
      # bind c kill-pane
      # bind x swap-pane -D
      # bind S choose-session
      # bind-key -T copy-mode-vi v send-keys -X begin-selection
      set -g mouse on
      set -g prefix ^A
      set -g base-index 1              # start indexing windows at 1 instead of 0
      set -g detach-on-destroy off     # don't exit from tmux when closing a session
      set -g escape-time 0             # zero-out escape time delay
      set -g history-limit 1000000     # increase history size (from 2,000)
      set -g renumber-windows on       # renumber all windows when any window is closed
      set -g set-clipboard on          # use system clipboard
      setw -g mode-keys vi
      set -g default-terminal /bin/zsh

      set-option -g default-terminal 'screen-256color'

      set -g @continuum-restore 'on'
      set -g @resurrect-strategy-nvim 'session'
    '';
  };

  programs.bash = {
    enable = true;
  };
}
