{ config, pkgs, username, dir, stateVersion, ... }: {

  home = {
    inherit username stateVersion;
    homeDirectory = dir;

    sessionVariables = {
      EDITOR    = "emacsclient -ca ''";
      MANPAGER  = "nvim +Man!";
      TERM      = "xterm-256color";
      COLORTERM = "truecolor";

      # QT Environment Enforcements
      QT_QPA_PLATFORM         = "wayland;xcb";
      QT_QPA_PLATFORMTHEME    = "qt5ct";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };

    # Dotfiles managed as mutable symlinks outside the Nix store
    file =
      let
        link = path: {
          source = config.lib.file.mkOutOfStoreSymlink "${dir}/git/${path}";
          recursive = true;
        };
        linkFile = path: {
          source = config.lib.file.mkOutOfStoreSymlink "${dir}/git/${path}";
        };
      in
      {
        "scripts/"            = link "scripts";
        ".emacs.d/"           = link "emacs";
        ".config/hypr/"       = link "dotfiles/config/hypr";
        ".config/nvim/"       = link "nvim";
        ".local/share/fonts"  = link "fonts";
        ".config/ranger"      = link "dotfiles/config/ranger";
        ".config/zathura"     = link "dotfiles/config/zathura";
        ".config/dunst"       = link "dotfiles/config/dunst";
        ".config/kitty"       = link "dotfiles/config/kitty";
        ".config/alacritty"   = link "dotfiles/config/alacritty";
        ".config/rofi"        = link "dotfiles/config/rofi";
        ".config/fish"        = link "dotfiles/config/fish";
        ".config/waybar"      = link "dotfiles/config/waybar";
        ".config/qtile"       = link "dotfiles/config/qtile";
        ".config/starship.toml" = linkFile "dotfiles/config/starship.toml";
      };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}
