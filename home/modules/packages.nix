{
  pkgs,
  inputs,
  system,
  ...
}:
{
  home.packages = with pkgs; [
    # Hyprland ecosystem
    hypridle
    hyprpaper
    hyprlock
    hyprsunset

    # Media
    vlc
    mpv
    pavucontrol
    easyeffects
    playerctl

    # Qt Styling Utilities
    libsForQt5.qt5ct
    kdePackages.qt6ct
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum

    # Terminals / shell tools
    kitty
    alacritty
    tmux
    yazi
    chafa
    ueberzugpp
    any-nix-shell
    bat
    eza
    ripgrep
    fd
    fzf
    lazygit

    # Editors / IDEs
    neovim
    zed-editor

    # LSPs / formatters / linters
    nil
    lua-language-server
    gopls
    python313Packages.python-lsp-server
    luajitPackages.luacheck
    stylua
    eslint
    black
    nixfmt

    # Dev tools
    git
    gh
    nodejs-slim
    deno
    luajit
    tree-sitter
    libtool
    sqlite
    cmake
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer

    # Wayland utilities
    grim
    slurp
    wl-clipboard
    waybar
    rofi
    mako
    networkmanagerapplet
    brightnessctl
    pamixer
    alsa-utils
    libnotify
    polkit_gnome
    xdotool
    wmctrl
    xwininfo

    # Apps
    nautilus
    zathura
    qbittorrent
    brave
    onlyoffice-desktopeditors
    sunshine
    kdePackages.gwenview
    audacious
    audacious-plugins

    # CLI toys / utilities
    fastfetch
    btop
    htop
    feh
    cmatrix
    cava
    pipes-rs

    # Spell checking
    ispell

    # Fonts helper
    hpx

    # Flake inputs
    inputs.zen-browser.packages.${system}.default
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    nix-index.enable = true;

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    starship.enable = true;
    home-manager.enable = true;
  };
}
