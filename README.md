# Nix Home Manager Configuration

A modular, reproducible, and extensible setup for managing user environments with Nix and Home Manager. This repository provides a structured approach to organize dotfiles, packages, and development environments across multiple systems.
Features

- Modular Structure: Split configurations into reusable modules (programs, services, shell tools).
- Nix Flakes Support: Pin dependencies, enable seamless cross-system builds, and simplify reproducibility.
- Multi-System Support: Define host-specific configurations while sharing common modules.
- Custom Packages: Easily add and override packages in your environment.

# Prerequisites

1. Nix installed with flakes and nix-command enabled.
```bash

    mkdir -p ~/.config/nix
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```
# Basic familiarity with Home Manager concepts.

## Installation

1. Clone the repository:
```bash

git clone https://github.com/jorgealves/nix-home-manager.git ~/.config/home-manager
cd ~/.config/home-manager
```

2. Build the configuration (replace HOSTNAME with your machine's hostname):
```bash

nix build .#homeConfigurations.HOSTNAME.activationPackage
``` 

3. Activate the configuration:
```bash

./result/activate
```
or use Home Manager directly:
```bash

home-manager switch --flake .#HOSTNAME
```

## Project Structure

```txt
.
├── flake.nix          # Entry point for Nix flakes
├── home/              # Host-specific configurations
│   └── <hostname>/    # Configuration for a specific machine
│       ├── home.nix   # Main Home Manager config
│       └── config/    # Host-specific dotfiles (e.g., .bashrc)
├── modules/           # Reusable configuration modules
│   ├── editors/       # Editor configurations (Neovim, VSCode)
│   ├── shell/         # Shell tools (Zsh, Bash, environment)
│   └── development/   # Language environments (Python, Go, Rust)
├── pkgs/              # Custom package definitions
└── shell.nix          # Development shell environment
```

## Customizing Your Setup
### Adding Packages

- Edit your host's home.nix:
```nix
# home/<hostname>/home.nix
{ pkgs, ... }: {
  home.packages = with pkgs; [
    ripgrep
    fd
    # Add new packages here
    cowsay
  ];
}
```

- Rebuild:
```bash
home-manager switch --flake .#$(hostname)
```

### Modifying Modules

- Edit existing modules in modules/:
```nix
# modules/editors/neovim.nix
{
  programs.neovim = {
    enable = true;
    extraConfig = ''  # Add custom Vim config
      set number
      set tabstop=2
    '';
  };
}
```


## Extending the Project
### Adding New Modules

- Create a new file in modules/:
```nix
# modules/gaming/steam.nix
{ config, pkgs, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
}
```

- Import in your home.nix:
```nix
{ imports = [ ../modules/gaming/steam.nix ]; }

```

- Creating Custom Packages

Add package definition in pkgs/:
```nix
# pkgs/my-tool/default.nix
{ stdenv }:
stdenv.mkDerivation {
  name = "my-tool";
  src = ./src;
  installPhase = "mkdir -p $out/bin; cp my-tool $out/bin/";
}
```

- Include in flake.nix:
```nix
outputs = { self, nixpkgs, ... }: {
  overlays.default = final: prev: {
    my-tool = prev.callPackage ./pkgs/my-tool { };
  };
};
```

### Use in your config:
```nix
home.packages = [ pkgs.my-tool ];
```

# Contributing

- Contributions are welcome! To modify/extend this configuration:

    - Fork the repository
    - Create a feature branch (git checkout -b feature/improvement)
    - Commit changes (git commit -am 'Add new feature')
    - Push to branch (git push origin feature/improvement)
    - Open a Pull Request

> Please follow existing code structure and add comments for complex logic.

## References

[Nix Package Manager](https://nix.dev/reference/nix-manual.html)
[Home Manager Manual](https://nix-community.github.io/home-manager/)
[Nix Flakes Documentation](https://nix.dev/concepts/flakes.html)

Maintained by [Jorge Alves](https://github.com/jorgealves) – Let your system configuration evolve!
