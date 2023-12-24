# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

# Use the systemd-boot EFI boot loader.
#	boot.loader.systemd-boot.enable = true;
#	boot.loader.efi.canTouchEfiVariables = true;
boot.loader.grub.enable = true;
boot.loader.grub.device = "nodev";
boot.loader.grub.efiSupport = true;
boot.loader.efi.canTouchEfiVariables = true;
boot.loader.efi.efiSysMountPoint = "/boot";
boot.loader.grub.useOSProber = true;



networking.hostName = "nixos"; # Define your hostname.
# Pick only one of the below networking options.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

# Set your time zone.
time.timeZone = "Asia/Kolkata";

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Select internationalisation properties.
i18n.defaultLocale = "en_US.UTF-8";
console = {
  font = "Lat2-Terminus16";
  keyMap = "us";
#  useXkbConfig = true; # use xkb.options in tty.
    };


# Enable the GNOME Desktop Environment.
services = {
  xserver = {
    enable = true;
    displayManager = {
      gdm.enable = true;
      defaultSession = "hyprland";
    };
    desktopManager.xfce.enable = true;
    windowManager.qtile.enable = true;
  };
};
# Allow Unfree packages
nixpkgs.config.allowUnfree = true;
nixpkgs.config.allowInsecure = true;
nixpkgs.config.PermittedInsecurePackages = [
  "python-2.7.18.6"
];

programs.hyprland = {
  enable = true;
};

programs.hyprland.xwayland = {
  enable = true;
};


# Configure keymap in X11
services.xserver.xkb.layout = "us";
# services.xserver.xkb.options = "eurosign:e,caps:escape";

# Enable CUPS to print documents.
# services.printing.enable = true;

# Enable sound.

services.blueman.enable = true;
services.gnome.gnome-keyring.enable = true;
sound = {
  enable = true;
  mediaKeys.enable = true;
};
hardware = {
  bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
  pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
    # extraModules = [ pkgs.pulseaudio-modules-bt ];
    extraConfig = "load-module module-combine-sink";
  };
};
#
# security.rtkit.enable = true;
# services.pipewire = {
#   enable = true;
#   alsa.enable = true;
#   alsa.support32Bit = true;
#   pulse.enable = true;
#   wireplumber.enable = true;
# };

# Enable touchpad support (enabled default in most desktopManager).
services.xserver.libinput = {
  enable = true;
  touchpad.tapping = true;
  touchpad.naturalScrolling = true;
};

# Define a user account. Don't forget to set a password with ‘passwd’.
users.users.cafo = {
  isNormalUser = true;
  extraGroups = [ "wheel" "audio" "input" "video" "networkmanager" "lp" "scanner" "libvirt" "kvm"]; # Enable ‘sudo’ for the user.
  initialPassword = "password";
  packages = with pkgs; [
    tree
  ];
  shell = pkgs.fish;
};
programs.fish.enable = true;

# environment.etc = {
#   "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
#   bluez_monitor.properties = {
#     ["bluez5.enable-sbc-xq"] = true,
#     ["bluez5.enable-msbc"] = true,
#     ["bluez5.enable-hw-volume"] = true,
#     ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
#   }
#   '';
# };
    # environment.etc = {
    # 	variables = {
    # 		QT_QPA_QTPLATFORMTHEME = "qt5ct";
    # 		QT_QPA_PLATFORM = "xcb obs";
    # 	};
    # };
virtualisation.libvirtd.enable = true;
programs.virt-manager.enable = true;

environment.systemPackages = with pkgs; [
  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  lxappearance
  polkit
  glib
  xfce.libxfce4ui
  wget
  git
  xclip
  wl-clipboard
  gcc
  clang
  curl
  neovim
  emacs
  dracula-theme
  bat
  eza
  alacritty
  kitty
  fish 
  starship
  rofi
  blueman
  brave
  light
  dunst
  pamixer
  glew
  maim
  gnumake
  cmake
  gparted
  hyprland
  hyprpaper
  feh
  hyprpicker
  qtile
  meson
  neofetch
  ninja
  networkmanagerapplet
  pavucontrol
  pipewire
  pulseaudio
  pkg-config
  polkit_gnome
  python311
  python311Packages.pip
  qemu_kvm
  qt6.qtwayland
  qt6.qmake
  qt5.qtwayland
  ranger
  cargo
  rustup
  nodejs
  waybar
  unzip
  xdg-desktop-portal-hyprland
  xdg-desktop-portal-gtk
  wlroots
  xdg-utils
  xwayland
  xdotool
];

fonts.fontDir.enable = true;
fonts.packages = with pkgs; [  
  nerdfonts
  font-awesome
  google-fonts
];
# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.

# programs.mtr.enable = true;
programs.gnupg.agent = {
  enable = true;
  enableSSHSupport = true;
};

    # services.emacs = {
    # 	enable = true;
    # 	packages = pkgs.emacs;
    # };

services.dbus.enable = true;
xdg.portal = {
  enable = true;
  extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];
};

# List services that you want to enable:

# Enable the OpenSSH daemon.
services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# Copy the NixOS configuration file and link it from the resulting system
# (/run/current-system/configuration.nix). This is useful in case you
# accidentally delete configuration.nix.
# system.copySystemConfiguration = true;

# This option defines the first version of NixOS you have installed on this particular machine,
# and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
#
# Most users should NEVER change this value after the initial install, for any reason,
# even if you've upgraded your system to a new NixOS release.
#
# This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
# so changing it will NOT upgrade your system.
#
# This value being lower than the current NixOS release does NOT mean your system is
# out of date, out of support, or vulnerable.
#
# Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
# and migrated your data accordingly.
#
# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
system.stateVersion = "23.11"; # Did you read the comment?

nixpkgs.overlays = [
  (self: super: {
    waybar = super.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
  })
];
}

