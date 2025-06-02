{ pkgs, inputs, system, ... }:

{

  imports = [
    ./modules/git.nix
  ];
  # enable generic linux
  targets.genericLinux.enable = true;
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jalves";
  home.homeDirectory = "/home/jalves";
  home.preferXdgDirectories = true;
  home.enableNixpkgsReleaseCheck = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    kubectx
    kubectl
    krew
    kubernetes-helm
    minikube
    kind
    docker

    lazydocker
    lazygit

    stow
    uv
    pipx

    nodejs
    deno
    bun

    rustup
    go

    terraform
    tflint

    pritunl-client
    cloudflare-warp
    keybase
    keybase-gui

    bitwarden-desktop
    bitwarden-cli

    obsidian
    conftest
    neovim

    tldr

    teams-for-linux
    discord

    jq

    firefox

    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        end_of_line = "lf";
        insert_final_newline = true;
      };
      "*.{js,py}" = {
        charset = "utf-8";
      };
      "*.py" = {
        indent_style = "space";
        indent_size = 4;
      };
    };
  };
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    "starship.toml" = {
      enable = true;
      force = true;
      source = ./configs/starship.toml;
      target = ".config/starship.toml";
    };
    "nvim" = {
      enable = true;
      force = true;
      recursive = true;
      source = ./configs/nvim;
      target = ".config/nvim";
    };
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jalves/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  xdg.enable = true;
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
  programs.starship.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      nix-update = "nix-channel --update && nix flake update --flake ~/.config/home-manager && home-manager switch --flake ~/.config/home-manager";
      l = "exa --icons -s type -lha";
      dvton = "sudo vpnc-connect";
      dvtoff = "sudo vpnc-disconnect";
      tmstart = "bash ~/tat";
      pbcopy = "xclip -selection clipboard";
    };
    oh-my-zsh = {
      enable = true;
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
        # "kubectl"
        # "kubectx"
        "kube-ps1"
        "minikube"
        "nmap"
        "perms"
        "podman"
        "pre-commit"
        "rsync"
        "starship"
        "ssh"
        "ssh-agent"
        "sudo"
        "tmux"
        "vscode"
        "z"
      ];
      extraConfig = ''
        export PATH=$HOME/.local/bin:$PATH
        export PATH=$HOME/.krew/bin:$PATH
      '';
    };
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
  programs.awscli.enable = true;
  programs.k9s.enable = true;
  programs.poetry = {
    enable = true;
    settings = {
      virtualenvs.create = true;
      virtualenvs.in-project = true;
    };
  };
  programs.pyenv = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.ripgrep.enable = true;
  programs.ruff = {
    enable = true;
    settings = {
      line-length = 100;
    };
  };


  programs.vscode.enable = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
