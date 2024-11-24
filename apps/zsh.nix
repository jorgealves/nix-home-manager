# Here I´m installing and configuring ZSH tools
{ ... }:
{
  # home.packages = [
  #   pkgs.bat
  #   pkgs.wget
  #   pkgs.jq
  #   pkgs.curl
  #   pkgs.unzip
  #   pkgs.dig
  #   pkgs.neofetch
  #   pkgs.eza
  #   pkgs.fzf
  #   pkgs.ripgrep
  #   pkgs.rsync
  #   pkgs.stow
  # ];
  programs.bat.enable = true;
  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    # fuzzyCompletion = true;
    tmux.enableShellIntegration = true;
  };
  programs.htop.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    # histSize = 2000;
    shellAliases = {
      nix-update = "nix-channel --update && nix flake update --flake ~/projects/personal/nix-home-manager && home-manager switch --flake ~/projects/personal/nix-home-manager";
      l = "exa --icons -s type -lha";
      dvton = "sudo vpnc-connect";
      dvtoff = "sudo vpnc-disconnect";
      tmstart = "bash ~/tat";
      pbcopy = "xclip -selection clipboard";
    };
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "aliases"
        "ansible"
        "aws"
        "azure"
        "command-not-found"
        "docker"
        "eza"
        "fzf"
        "gcloud"
        "git"
        "git-auto-fetch"
        "git-commit"
        "git-extras"
        "git-flow"
        "gitignore"
        "gpg-agent"
        "helm"
        "history-substring-search"
        "kind"
        "kubectl"
        "kubectx"
        "kube-ps1"
        "minikube"
        "nmap"
        "perms"
        "podman"
        "pre-commit"
        "rsync"
        "ssh"
        "ssh-agent"
        "sudo"
        "tmux"
        "vscode"
        "z"
      ];
      extraConfig = ''
        export PATH=$HOME/.local/bin:$PATH
        export PATH=$HOME/.krew/bin:$PATH # Kubectl krew
      '';
    };
  };

  programs.tmux = {
    enable = true;
    # terminal = "screen-256color";
    # baseIndex = 1;
    # clock24 = true;
    # historyLimit = 10000;
    # keyMode = "vi";
    # mouse = true;
    # shell = "${pkgs.zsh}/bin/zsh";
    shortcut = "a";
    # plugins = with pkgs; [
    #   tmuxPlugins.resurrect
    #   {
    #     plugin = tmuxPlugins.continuum;
    #     extraConfig = ''
    #       set -g @continuum-restore 'on'
    #       set -g @continuum-save-interval '60' # minutes
    #     '';
    #   }
    # ];
    # extraConfig = ''
    #   # First remove *all* keybindings
    #   #unbind-key -a
    #   # Now reinsert all the regular tmux keys
    #   # bind ^X lock-server
    #   # bind ^C new-window -c "$HOME"
    #   # bind ^D detach
    #   # bind * list-clients
    #   # bind H previous-window
    #   # bind L next-window
    #   # bind r command-prompt "rename-window %%"
    #   # bind R source-file ~/.config/tmux/tmux.conf
    #   # bind ^A last-window
    #   # bind ^W list-windows
    #   # bind w list-windows
    #   # bind z resize-pane -Z
    #   # bind ^L refresh-client
    #   # bind l refresh-client
    #   # bind '\' split-window -h -c "#{pane_current_path}"
    #   # bind '-' split-window -c "#{pane_current_path}"
    #   # bind '"' choose-window
    #   # bind h select-pane -L
    #   # bind j select-pane -D
    #   # bind k select-pane -U
    #   # bind l select-pane -R
    #   # bind -r -T prefix , resize-pane -L 20
    #   # bind -r -T prefix . resize-pane -R 20
    #   # bind -r -T prefix - resize-pane -D 7
    #   # bind -r -T prefix = resize-pane -U 7
    #   # bind : command-prompt
    #   # bind * setw synchronize-panes
    #   # bind P set pane-border-status
    #   # bind c kill-pane
    #   # bind x swap-pane -D
    #   # bind S choose-session
    #   # bind-key -T copy-mode-vi v send-keys -X begin-selection
    #   # set -g mouse on
    #   # set -g prefix ^A
    #   # set -g base-index 1              # start indexing windows at 1 instead of 0
    #   # set -g detach-on-destroy off     # don't exit from tmux when closing a session
    #   # set -g escape-time 0             # zero-out escape time delay
    #   # set -g history-limit 1000000     # increase history size (from 2,000)
    #   # set -g renumber-windows on       # renumber all windows when any window is closed
    #   # set -g set-clipboard on          # use system clipboard
    #   # set -g status-position top       # macOS / darwin style
    #   # setw -g mode-keys vi
    # '';
  };

  programs.bash = {
    enable = true;
  };
}
