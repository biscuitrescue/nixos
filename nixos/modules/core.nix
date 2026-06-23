{ lib, pkgs, inputs, ... }: {

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-amd" ];

    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  time = {
    timeZone = "Asia/Kolkata";
    hardwareClockInLocalTime = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    graphics.enable = true;
    amdgpu.opencl.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  fonts.fontDir.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  systemd = {
    services.sshd.wantedBy = lib.mkForce [ ];
  };

  security = {
    polkit.enable = true;
    sudo.extraConfig = ''
      %wheel ALL= NOPASSWD: /run/current-system/sw/bin/systemctl, /run/current-system/sw/bin/swapon, /run/current-system/sw/bin/swapoff, /run/current-system/sw/bin/rfkill
      Defaults env_reset, pwfeedback
    '';
    pam.services.hyprlock = { };
  };

  nix = {
    settings = {
      max-jobs = "auto";
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      flake-registry = "";
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
  };

  system.stateVersion = "25.05";
}
