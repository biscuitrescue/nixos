{ pkgs, inputs, system, ... }: {
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

    zsh = {
      enable = true;

      history = {
        size = 1100000000;
        save = 1000000000;
        path = "$HOME/.histfile";
        share = true;
        ignoreSpace = true;
        expireDuplicatesFirst = true;
        findNoDups = true;
      };

      autocd = true;
      defaultKeymap = "emacs";

      shellAliases = {
        # Navigation
        ".."    = "cd ..";
        "..."   = "cd ../..";
        "...."  = "cd ../../..";
        "....." = "cd ../../../..";

        # Editor
        vim = "nvim";
        v   = "nvim";
        ":q" = "exit";

        # Cloudflare WARP
        wcc = "warp-cli connect";
        wdd = "warp-cli disconnect";

        # Git shorthands
        clone   = "git clone";
        pull    = "git pull";
        add     = "git add";
        rmm     = "git rm";
        remlist = "git remote -v";
        commit  = "git commit";
        branch  = "git branch";
        addrem  = "git remote add";
        rmrem   = "git remote remove";
        push    = "git push";
        init    = "git init";
        save    = "git config --global credential.helper store";
        checkout = "git checkout";

        # Nix
        ns  = "nix-shell";
        ncg = "nix-collect-garbage --delete-older-than 1d";
        up  = "sudo nixos-rebuild switch --flake ~/nixos#cafo --upgrade-all";
        reb = "sudo nixos-rebuild switch --flake ~/nixos#cafo";

        # ls replacements (eza)
        ll  = "eza -al --color=always --group-directories-first";
        la  = "eza -a --color=always --group-directories-first";
        ls  = "eza -l --color=always --group-directories-first";
        lt  = "eza -aT --color=always --group-directories-first";
        "l." = "eza -a | grep -E '^\\.'";

        # Misc
        pipes    = "pipes-rs -k curved -p 3 -t 0.13 -r 0.6";
        fetch    = "fastfetch";
        tmsource = "tmux source-file ~/.config/tmux/tmux.conf";
        tmux     = "tmux -u";
        mux      = "tmux new-session -t shell";
      };

      sessionVariables = {
        EDITOR    = "emacsclient -ca ''";
        MANPAGER  = "nvim +Man!";
        TERM      = "xterm-256color";
        COLORTERM = "truecolor";
        FZF_DEFAULT_OPTS = ''
          --color=bg+:#293334,bg:#0c0c0c,spinner:#da627d,hl:#F02D3A
          --color=fg:#bdc4a7,header:#987284,info:#7e8dba,pointer:#9FC490
          --color=marker:#9FC490,fg+:#cecece,prompt:#70AE6E,hl+:#F45B69
          --color=selected-bg:#1a1a1a
          --color=border:#393D3F,label:#F49D6E,query:#F7F0F5
          --border="thinblock"
          --border-label=" Onyx "
          --border-label-pos="0"
          --preview-window="border-thinblock"
          --prompt="> "
          --marker="▶"
          --pointer="◆"
          --separator="─"
          --scrollbar="│"
          --info="right"
        '';
      };

      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;

      plugins = [
        {
          name = "zsh-autopair";
          src = pkgs.zsh-autopair;
          file = "share/zsh/zsh-autopair/autopair.zsh";
        }
      ];

      initContent = ''
        # Completion styles
        zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
        zstyle ':completion:*' group-name ""
        zstyle ':completion:*' matcher-list "" 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
        zstyle ':completion:*' max-errors 4
        zstyle ':completion:*' use-compctl true
        zstyle ':completion:*' verbose true
        zstyle ':completion:*' menu select

        # Syntax highlight colours
        typeset -A ZSH_HIGHLIGHT_STYLES
        ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
        ZSH_HIGHLIGHT_STYLES[alias]='fg=green'
        ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan'
        ZSH_HIGHLIGHT_STYLES[function]='fg=magenta'
        ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,underline'

        # Key bindings
        bindkey "^[[1;3C" forward-word   # Alt+Right
        bindkey "^[[1;3D" backward-word  # Alt+Left
        bindkey "\e[f"    forward-word   # Alt+F
        bindkey "\e[b"    backward-word  # Alt+B
        bindkey '^E'      end-of-line    # Ctrl+E
        bindkey '^F'      forward-char   # Ctrl+F
        bindkey '^f'      forward-word
        bindkey '^ '      forward-to-word

        # any-nix-shell integration
        if command -v any-nix-shell >/dev/null; then
          any-nix-shell zsh --info-right | source /dev/stdin
        fi
      '';
    };

    starship.enable = true;
    home-manager.enable = true;
  };
}
