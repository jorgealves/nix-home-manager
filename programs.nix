{
  home-manager = {
    enable = true;
  };

  awscli.enable = true;
  bat.enable = true;
  eza = {
    enable = true;
    git = true;
    icons = "auto";
  };
  firefox.enable = true;
  fzf = {
    enable = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = true;
  };
  htop = {
    enable = true;
  };
  starship.enable = true;
  zsh = {
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
        "kubectl"
        "kubectx"
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
        export PATH=$HOME/.krew/bin:$PATH # Kubectl krew
      '';
    };
  };
  jq.enable = true;
  neovim.enable = true;
  k9s.enable = true;
  kitty.enable = true;
  lazygit.enable = true;
  lazydocker.enable = true;
  vscode.enable = true;
  poetry = {
    enable = true;
    settings = {
      virtualenvs.create = true;
      virtualenvs.in-project = true;
    };
  };
  pyenv = {
    enable = true;
    enableZshIntegration = true;
  };
  ripgrep.enable = true;
  ruff = {
    enable = true;
    settings = {
      line-length = 120;
    };
  };
  uv.enable = true;
  go.enable = true;
  bun.enable = true;
  git-cliff = {
    enable = true;
  };
  git = {
    enable = true;
    lfs = {
      enable = true;
    };
    userEmail = "jorgeandrealves@gmail.com";
    userName = "Jorge Alves";
    signing = {
      key = "~/.ssh/id_signing";
      signByDefault = true;
      format = "ssh";
    };
    diff-highlight.enable = true;
    aliases = {
      logg = "log --oneline --graph --decorate";
      gst = "status";
    };
    includes = [
      {
        path = "~/.gitconfig_dvt";
        condition = "gitdir:~/projects/devoteam/**";
      }
      {
        path = "~/.gitconfig_wrt";
        condition = "gitdir:~/projects/worten/**";
      }
    ];
    extraConfig = {
      core = {
        editor = "nvim";
        excludesFile = "~/.gitignore_global";
      };
      safe = {
        directory = "~/projects";
      };
      init = {
        defaultBranch = "main";
      };
      help = {
        autocorrect = "prompt";
      };
      gpg = {
        format = "ssh";
      };
      blame = {
        coloring = "highlightRecent";
      };
      grep = {
        lineNumber = true;
      };
      commit = {
        gpgSigning = true;
      };

    };
  };
}