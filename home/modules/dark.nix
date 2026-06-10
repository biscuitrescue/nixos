{ pkgs, config, ... }: {
  gtk = {
    enable = true;
    font = {
      name = "Monaspace Neon Frozen";
      size = 10;
    };
    theme = {
      package = pkgs.colloid-gtk-theme;
      name    = "Colloid-Dark";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name    = "Papirus-Dark";
    };
    gtk4.theme = config.gtk.theme;
  };
  qt = {
    enable = true;
    platformTheme.name = "qt5ct"; # Forces Qt to look at qt5ct/qt6ct for settings
    style.name = "kvantum";       # Uses Kvantum as the rendering style engine
  };
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.oreo-cursors-plus;
    name = "oreo_purple_cursors";
    size = 24;
  };
}
