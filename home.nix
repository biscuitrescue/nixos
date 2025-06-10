{
  config,
  pkgs,
  system,
  inputs,
  ...
}: {
  home.username = "cafo";
  home.homeDirectory = "/home/cafo";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    btop
    zed-editor
    pavucontrol
    spotify-player
    evince
    foliate
    nwg-look
    catppuccin-gtk
    zathura
    qbittorrent
    playerctl
    easyeffects
    onlyoffice-desktopeditors
    htop
    feh
    cmatrix
    cava
    pipes-rs
    yazi-unwrapped
    grim
    wl-clipboard
    nautilus
    i3lock-color
    mpv
    lazygit
    swaybg
    swaylock-effects
    swayidle
    dmenu-rs
    networkmanagerapplet
    alacritty
    bat
    eza
    git
    kitty
    slurp
    rofi
    light
    alsa-utils
    pamixer
    dunst
    mako
    glew
    maim
    feh
    polkit_gnome
    xdotool
    wmctrl
    waybar
    neofetch
    xclip
    starship
    tmux
    xss-lock
    libnotify
    hyprpaper
    inputs.zen-browser.packages."${system}".default
  ];

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload =
        [ "/home/cafo/git/wallpapers/chaos_rose.png" ];

      wallpaper = [
        "eDP-1, /home/cafo/git/wallpapers/chaos_rose.png"
      ]; 
    };
  };
  services.mako.extraConfig = "...";
  services.mako= {
    enable = true;
    settings = {
      backgroundColor = "#1e1e2eff";
      borderColor = "#aed1dcff";
      borderRadius = 10;
      borderSize = 2;
      defaultTimeout = 2500;
      font = "JetbrainsMono Nerd Font 11";
      anchor = "top-center";
    };
  };

  home.file = {
    ".config/zathura" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cafo/git/dotfiles/config/zathura";
      recursive = true;
    };
    ".config/dunst" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cafo/git/dotfiles/config/dunst";
      recursive = true;
    };
    ".config/kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cafo/git/dotfiles/config/kitty";
      recursive = true;
    };
    ".config/alacritty" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cafo/git/dotfiles/config/alacritty";
      recursive = true;
    };
    ".config/rofi" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cafo/git/dotfiles/config/rofi";
      recursive = true;
    };
    ".config/fish" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cafo/git/dotfiles/config/fish";
      recursive = true;
    };
    # ".config/mako" = {
    #   source = config.lib.file.mkOutOfStoreSymlink "/home/cafo/git/dotfiles/config/mako";
    #   recursive = true;
    # };
    ".config/waybar" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cafo/git/dotfiles/config/waybar";
      recursive = true;
    };
    ".config/easyeffects" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cafo/git/dotfiles/config/easyeffects";
      recursive = true;
    };
    ".config/starship.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cafo/git/dotfiles/config/starship.toml";
    };
    ".config/qtile" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cafo/git/dotfiles/config/qtile";
      recursive = true;
    };
  };

  services = {
    picom = {
      enable = true;
      backend = "glx";
      settings = {
        blur = {
          method = "gaussian";
          size = 15;
          deviation = 5.0;
        };
      };
    };
  };

  programs.neovim = {
    enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.oreo-cursors-plus;
    name = "oreo_purple_cursors";
    size = 16;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.colloid-gtk-theme;
      name = "Colloid-Dark";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    font = {
      name = "Zed Mono Extended";
      size = 11;
    };
  };

  qt = {
    enable = true;

    platformTheme.name = "kvantum";

    style.name = "kvantum";
  };
  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=GraphiteNordDark
    '';

    "Kvantum/GraphiteNord".source = "${pkgs.graphite-kde-theme}/share/Kvantum/GraphiteNord";
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  programs.home-manager.enable = true;
}
