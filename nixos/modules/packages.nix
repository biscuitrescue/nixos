{ pkgs, ... }: {

  nixpkgs.overlays = [
    (_final: prev: {
      # openjdk8-bootstrap is the canonical jdk8 on nixpkgs-unstable
      jdk8 = prev.openjdk8-bootstrap;
    })
  ];

  environment.systemPackages = with pkgs; [
    # Networking / VPN
    mullvad-vpn
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
    picom
    remmina
    anydesk

    # Diagnostics / monitoring
    baobab
    bleachbit

    # Languages
    python314

    # gaming
    mangohud
    gamemode
    vkbasalt

    spotify
  ];

  programs = {
    command-not-found.enable = false;
    dsearch = {
      enable = true;
      systemd = {
        enable = true;               # Enable systemd user service
        target = "default.target";   # Start with user session
      };
    };
    dms-shell = {
      enable = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
    };
    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

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
