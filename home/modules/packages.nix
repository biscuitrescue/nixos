{ pkgs, inputs, system, username, ... }: {

  home.packages = with pkgs; [
    sunshine
    rustdesk-server
    hyprsunset
    fastfetch
    fzf
    vlc
    fd
    btop
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
    grim
    wl-clipboard
    nautilus
    mpv
    lazygit
    swaylock-effects
    swayidle
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
    chafa
    ueberzugpp
    any-nix-shell
    hpx
    ghostty
    # Langs
    go
    luajit
    zig
    # lsp + highlight
    tree-sitter
    nodejs-slim
    gopls
    nil
    python313Packages.python-lsp-server
    rust-analyzer
    lua-language-server
    zls
    # neovim
    neovim
    deno
    ripgrep
    stylua
    eslint
    black
    neovide
    # emacs
    libtool
    sqlite
    ispell
    inputs.zen-browser.packages."${system}".default
  ];
  programs = {
    home-manager.enable = true;
  };
}
