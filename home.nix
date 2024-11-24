{ nixGL, ... }:
{
  targets.genericLinux.enable = true;
  nixpkgs.config = {
    allowUnfree = true;
  };
  nixGL.packages = nixGL.packages;

  imports = [
    ./apps/zsh.nix
    ./apps/devtools.nix
    #   ./programming-languages.nix
    ./apps/ubuntu.nix
    #   ./apps/utils.nix
    ./apps/fonts.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home = {
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.05"; # Please read the comment before changing.
    enableNixpkgsReleaseCheck = true;
    preferXdgDirectories = true;
    username = "jalves";
    homeDirectory = "/home/jalves";
    language = {
      base = "us_EN.UTF-8";
      ctype = "us_EN.UTF-8";
      address = "pt_PT.UTF-8";
      collate = "pt_PT.UTF-8";
      messages = "pt_PT.UTF-8";
      monetary = "pt_PT.UTF-8";
      name = "pt_PT.UTF-8";
      paper = "pt_PT.UTF-8";
      telephone = "pt_PT.UTF-8";
      time = "pt_PT.UTF-8";
    };

    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "google-chrome-stable";
      TERMINAL = "kitty";
      LC_ADDRESS = "pt_PT.UTF-8";
      LC_IDENTIFICATION = "pt_PT.UTF-8";
      LC_MEASUREMENT = "pt_PT.UTF-8";
      LC_MONETARY = "pt_PT.UTF-8";
      LC_NAME = "pt_PT.UTF-8";
      LC_NUMERIC = "pt_PT.UTF-8";
      LC_PAPER = "pt_PT.UTF-8";
      LC_TELEPHONE = "pt_PT.UTF-8";
      LC_TIME = "pt_PT.UTF-8";
    };
  };

  programs.home-manager.enable = true;
}
