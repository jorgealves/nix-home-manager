{ homeDirectory
, pkgs
, stateVersion
, system
, username, ... }:

let
  packages = import ./packages.nix { inherit pkgs; };
in {
  targets.genericLinux.enable = true;
  home = {
    inherit homeDirectory packages stateVersion username;

    file = {
      "starship.toml" = {
        enable = true;
        source = ./configs/starship.toml;
        target = ".config/starship.toml";
        force = true;
      };
    };
    enableNixpkgsReleaseCheck = true;
    preferXdgDirectories = true;
    shellAliases = {
      reload-home-manager-config = "home-manager switch --flake ${builtins.toString ./.}";
    };

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

  };

  nixpkgs = {
    config = {
      inherit system;
      allowUnfree = true;
      allowUnsupportedSystem = true;
      experimental-features = "nix-command flakes";
    };
  };

  programs = import ./programs.nix;

}
