{ pkgs, pkgs-unstable, ... }:
{
  home.packages =
    (with pkgs; [
      kubectx
      kubectl
      krew
      kubernetes-helm
      minikube
      kind
      docker
      podman

      lazydocker
      lazygit

      stow
      uv
      pipx

      nodejs

      pritunl-client
      cloudflare-warp
      keybase
      keybase-gui
      discord
      teams-for-linux
      whatsapp-for-linux

      bitwarden-desktop
      bitwarden-cli

      obsidian
      ollama
      barrier
      qemu
      virt-manager
      virt-manager-qt
      rpi-imager
    ])
    ++
    (with pkgs-unstable; [
      nmap
      conftest
      neovim
      dunst

      alacritty
      traceroute
      tldr

      keepassxc
      keepassxc-go
    ]);
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
  # programs.uv.enable = true;
  # TODO: Huge problem will come later
  # programs.neovim = {
  #   enable = true;
  #   vimAlias = true;
  #   viAlias = true;
  #   vimdiffAlias = true;
  #   package = pkgs-unstable.neovim;
  #   defaultEditor = true;
  #   withPython3 = true;
  #   withNodeJs = true;
  #   withRuby = true;
  # };
  programs.lazygit.enable = true;
  programs.git = {
    enable = true;
    lfs = {
      enable = true;
    };
    userEmail = "jorgeandrealves@gmail.com";
    userName = "Jorge Alves";
    signing.key = "~/.ssh/id_signing";
    diff-highlight.enable = true;
    aliases = {
      logg = "log --oneline --graph --decorate";
      gst = "status";
    };
    signing.signByDefault = true;
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

  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    package = pkgs-unstable.kitty;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12.0;
      package = pkgs.nerdfonts;
    };

  };
}

