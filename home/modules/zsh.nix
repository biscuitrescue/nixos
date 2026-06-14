{ pkgs, config, ... }: {

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    defaultKeymap = "emacs";

    history = {
      size = 100000;
      save = 50000;
      path = "${config.home.homeDirectory}/.histfile";
      share = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      findNoDups = true;
      ignoreDups = true;
    };

    autosuggestion = {
      enable = true;
      highlight = "fg=242";
      strategy = [ "history" "completion" ];
    };

    syntaxHighlighting = {
      enable = true;
      highlighters = [ "main" "brackets" "cursor" ];
      styles = {
        "command" = "fg=green,bold";
        "alias" = "fg=green";
        "builtin" = "fg=cyan";
        "function" = "fg=magenta";
        "unknown-token" = "fg=red,underline";
      };
    };

    plugins = [
      {
        name = "zsh-autopair";
        src = pkgs.zsh-autopair;
        file = "share/zsh/zsh-autopair/autopair.zsh";
      }
    ];

    sessionVariables = {
      ZSH_AUTOSUGGEST_USE_ASYNC = "true";
      ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE = "20";
      
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

    shellAliases = {
      ".."     = "cd ..";
      "..."    = "cd ../..";
      "...."   = "cd ../../..";
      "....."  = "cd ../../../..";
      ":q"     = "exit";
      add      = "git add";
      addrem   = "git remote add";
      branch   = "git branch";
      checkout = "git checkout";
      clone    = "git clone";
      commit   = "git commit";
      fetch    = "fastfetch";
      init     = "git init";
      "l."     = "eza -a | grep -E '^\\.'";
      la       = "eza -a --color=always --group-directories-first";
      ll       = "eza -al --color=always --group-directories-first";
      ls       = "eza -l --color=always --group-directories-first";
      lt       = "eza -aT --color=always --group-directories-first";
      mux      = "tmux new-session -t shell";
      ncg      = "nix-collect-garbage --delete-older-than 1d";
      ns       = "nix-shell";
      pipes    = "pipes-rs -k curved -p 3 -t 0.13 -r 0.6";
      pull     = "git pull";
      push     = "git push";
      reb      = "sudo nixos-rebuild switch --flake ~/nixos#cafo";
      remlist  = "git remote -v";
      rmm      = "git rm";
      rmrem    = "git remote remove";
      save     = "git config --global credential.helper store";
      tmsource = "tmux source-file ~/.config/tmux/tmux.conf";
      tmux     = "tmux -u";
      up       = "sudo nixos-rebuild switch --flake ~/nixos#cafo --upgrade-all";
      v        = "nvim";
      vim      = "nvim";
      wcc      = "warp-cli connect";
      wdd      = "warp-cli disconnect";
    };

    initContent = ''
      # Completion Settings
      zstyle ':completion::*:*' accept-exact-dirs 'yes'
      zstyle ':completion:*:expand:*' tag-order 'all-expansions'
      zstyle ':completion:*' group-name ""
      zstyle ':completion:*:descriptions' format $'\e[1;35m--- %d ---\e[0m'
      zstyle ':completion:*:messages' format $'\e[1;31m--- %d ---\e[0m'
      zstyle ':completion:*:warnings' format $'\e[1;31mNo matches found for:\e[0m %d'
      zstyle ':completion:*' menu select=2
      zstyle ':completion:*:default' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
      zstyle ':completion:*' matcher-list "" 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=*'
      zstyle ':completion:*' max-errors 2
      zstyle ':completion:*' use-compctl true
      zstyle ':completion:*' verbose true
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "''${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"
      zstyle ':completion:*' ignore-parents parent pwd

      # Custom Path additions
      typeset -U path
      path=(
        "$HOME/.cargo/bin"
        "$HOME/.local/bin"
        "$HOME/scripts/bash"
        "$HOME/scripts/c"
        "$HOME/scripts/python"
        $path
      )

      # Keybindings (Using \e instead of raw Ctrl chords to prevent Nix evaluation traps)
      bindkey '^?' backward-delete-char
      bindkey '^H' backward-delete-char
      bindkey '^[[3J'   backward-kill-word
      bindkey '\e^?'    backward-kill-word
      bindkey '\e^H'    backward-kill-word
      bindkey '^W'      backward-kill-word
      bindkey "^[[3;5~" kill-word
      bindkey "^[[1;3C" forward-word
      bindkey "^[[1;3D" backward-word
      bindkey "\e[f"    forward-word
      bindkey "\e[b"    backward-word
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      bindkey '^E'      end-of-line
      bindkey '^A'      beginning-of-line
      bindkey '^F'      forward-char
      bindkey '^B'      backward-char
      bindkey '^f'      forward-word
      bindkey '^ '      forward-to-word
      bindkey '^[[C'    forward-char

      if command -v any-nix-shell >/dev/null; then
        source <(any-nix-shell zsh --info-right)
      fi
    '';
  };
}
