{ pkgs, inputs, system, ... }: {

  home.packages = with pkgs; [
    busybox
    fzf
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
    inputs.zen-browser.packages."${system}".default
  ];
  programs = {
    neovim.enable = true;
    home-manager.enable = true;
  };
}
