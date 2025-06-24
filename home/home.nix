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
    busybox
    dissent
    fzf
    fd
    gammastep
    ardour
    btop
    zed-editor
    pavucontrol
    hypridle
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
    ranger
    inputs.zen-browser.packages."${system}".default
  ];

  home.file = {
    ".local/share/fonts" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cafo/git/fonts";
      recursive = true;
    };
    ".config/ranger" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cafo/git/dotfiles/config/ranger";
      recursive = true;
    };
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

  # programs.ranger = {
  #   enable = true;
  #   settings = {
  #     view_mode = "miller";
  #     preview_images = true;
  #     preview_images_method = "kitty";
  #     column_ratios = "1,3,3";
  #     flushinput = true;
  #     confirm_on_delete = "never";
  #     scroll_offset = 8;
  #     unicode_ellipsis = true;
  #   };
  # };

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
    mako.enable = true;
    hyprlock.enable = false;
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
