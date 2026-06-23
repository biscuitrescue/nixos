{ pkgs, ... }: {

  nixpkgs.overlays = [
    (_final: prev: {
      # openjdk8-bootstrap is the canonical jdk8 on nixpkgs-unstable
      jdk8 = prev.openjdk8-bootstrap;
    })
  ];

  environment.systemPackages = with pkgs; [
    # Networking / VPN
    cloudflare-warp
    openvpn
    tailscale
    distrobox

    # Editors
    vim
    mu
    isync
    msmtp

    # Compilers / build tools
    clang
    gcc
    gnumake
    cmake

    # System utilities
    wget
    unzip
    zip
    killall
    glib
    ntfs3g
    exfat
    exfatprogs
    pulseaudio   # pactl CLI; pipewire is the actual daemon
    proton-vpn

    # Diagnostics / monitoring
    baobab
    bleachbit

    # Languages
    python314
  ];

  programs = {
    command-not-found.enable = false;

    zsh = {
      enable = true;
      interactiveShellInit = ''
        source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
      '';
    };

    fish.enable = true;

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    firefox.enable = true;
    nix-ld.enable = true;
    virt-manager.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
