{ config, pkgs, ... }: {

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
    # gvfs.enable = true;
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
      name = "M Plus 1 Code Regular";
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
}
