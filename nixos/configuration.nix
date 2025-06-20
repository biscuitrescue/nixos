{ inputs, pkgs, ... }:

let
  user = "cafo";
in

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ];

  # boot.loader.systemd-boot.enable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
      # initrd.kernelModules = ["amdgpu"];

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

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
# Set your time zone.
  time.timeZone = "Asia/Kolkata";

# Select internationalisation properties.
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
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

#Optional helps save long term battery health
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
      windowManager = {
        qtile = {
          enable = true;
          extraPackages = python3Packages: with python3Packages; [
            qtile-extras
          ];
        };
      };
    };
    gnome.gnome-keyring.enable = true;
    openssh.enable = false;
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

  # programs.mnw = {
  #   enable = true;
  #   plugins = {
  #     "video" = true;
  #     "audio" = true;
  #   };
  # };

  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/Hyprland";
      };
    };
  };
  programs.hyprland.withUWSM = true;
    programs.fish.enable = true;
    programs.firefox.enable = true;
    programs.nix-ld.enable = true;
  programs.hyprland.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  nixpkgs.config.allowUnfree = true;

  users.users.${user}= {
    isNormalUser = true;
    description = "Karttikeya Sinha";
    extraGroups = [ "wheel" "audio" "input" "video" "networkmanager" "lp" "scanner" "kvm" "libvirtd"]; 
    shell = pkgs.fish;
    # packages = with pkgs; [
    #
    # ];
  };

  environment.systemPackages = with pkgs; [
    vivaldi
    vivaldi-ffmpeg-codecs
    spotify
    vim
    clang
    cmake
    obsidian
    llvmPackages_20.clang-tools
    nmap
    gcc
    wget
    unzip
    zip
    glib
    veracrypt
    baobab
    bleachbit
    brave
    exfat
    exfatprogs
    gnumake
    killall
    pulseaudio
    ntfs3g
    python3Full
  ];

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["cafo"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  fonts.fontDir.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.samba = {
    enable = true;
  };

  services.dbus.enable = true;
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;



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
        auto-optimise-store = true;
        experimental-features = [ "nix-command" "flakes" ];
        flake-registry = "";
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };

  }
