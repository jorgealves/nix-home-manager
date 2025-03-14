{ ... }:
{
  targets.genericLinux.enable = true;
  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };

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
    stateVersion = "25.05"; # Please read the comment before changing.
    enableNixpkgsReleaseCheck = false;
    preferXdgDirectories = true;
    username = "jalves";
    homeDirectory = "/home/jalves";
    language = {
      base = "en_US.UTF-8";
      ctype = "en_US.UTF-8";
      address = "en_US.UTF-8";
      collate = "en_US.UTF-8";
      messages = "en_US.UTF-8";
      monetary = "en_US.UTF-8";
      name = "en_US.UTF-8";
      paper = "en_US.UTF-8";
      telephone = "en_US.UTF-8";
      time = "en_US.UTF-8";
    };

    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "xdg-open:zen:chrome:google-chrome:firefox";
      TERMINAL = "kitty";
      QT_XCB_GL_INTEGRATION = "none";
    };

    file = {
      "starship.toml" = {
        enable = true;
        source = ./configs/starship.toml;
        target = ".config/starship.toml";
        force = true;


      };
    };

  };

  programs.home-manager.enable = true;
}
