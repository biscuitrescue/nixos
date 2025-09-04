{ lib, pkgs, ... }: {

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 5;
      };
      timeout = 5;
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  time.timeZone = "Asia/Kolkata";
  time.hardwareClockInLocalTime = true;

  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  services = {
    # logind.lidSwitch = "ignore";

    cloudflare-warp.enable = true;
    gvfs.enable = true;
    samba.enable = true;
    dbus.enable = true;

    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "performance";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "performance";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 80;

        START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
        STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

      };
    };
    blueman.enable = true;
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        tapping = true;
      };
    };
    xserver = {
      enable = true;
      displayManager = {
        startx.enable = true;
      };
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    gnome.gnome-keyring.enable = true;
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      ports = [ 22 443 ];
    };
    tailscale.enable = true;
    printing.enable = false;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot


  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  nixpkgs.config.allowUnfree = true;

  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.guest.enable = true;
  # virtualisation.virtualbox.guest.dragAndDrop = true;
  # virtualisation.virtualbox.host.enableHardening = false;

  fonts.fontDir.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  systemd.services.sshd.wantedBy = lib.mkForce [ ];
  systemd.sleep.extraConfig = ''
    AllowSuspend=yes
    AllowHibernation=no
    AllowHybridSleep=yes
    AllowSuspendThenHibernate=no
  '';

  security = {
    polkit.enable = true;
    sudo.extraConfig = "%wheel ALL= NOPASSWD: /usr/bin/systemctl, /usr/bin/swapon, /usr/bin/swapoff, /usr/bin/rfkill, /etc/profiles/per-user/cafo/bin/light\nDefaults env_reset, pwfeedback";
    pam.services.hyprlock = { };
  };

  system.stateVersion = "25.05"; # Did you read the comment?

  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
    dates = "daily";
  };

  nix = {
    settings = {
      max-jobs = 8;
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      flake-registry = "";
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
    };
  };
}
