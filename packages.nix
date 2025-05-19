{ pkgs }:

let
  nixTools = with pkgs; [
    docker
    pritunl-client
    cloudflare-warp
    cloudflare-cli
    deno
    rustup
    tflint
    terraform
    keybase
    keybase-gui
    bitwarden-cli
    bitwarden-desktop
    obsidian
    barrier

    qemu



    discord
    teams-for-linux
    
    kubectx
    kubectl
    krew
    kubernetes-helm
    minikube
    kind
    nmap
    conftest
    traceroute
    tldr
  ];
in nixTools