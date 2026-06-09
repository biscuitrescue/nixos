{ pkgs, ... }: {
  services = {
    gvfs.enable = true;
    samba.enable = true;
    dbus.enable = true;
    blueman.enable = true;
    tailscale.enable = true;
    gnome.gnome-keyring.enable = true;

    emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
      install = true;
    };

    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC  = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "performance";
        CPU_ENERGY_PERF_POLICY_ON_AC  = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "performance";

        CPU_MIN_PERF_ON_AC  = 0;
        CPU_MAX_PERF_ON_AC  = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 80;

        # Battery health thresholds
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0  = 80;
      };
    };

    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        tapping = true;
      };
    };

    xserver = {
      enable = true;
      displayManager.startx.enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      windowManager.qtile = {
        enable = true;
        extraPackages = python3Packages: with python3Packages; [ qtile-extras ];
      };
    };

    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };
}
