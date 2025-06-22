{
  pkgs,
  ...
}: {

  programs.nvf = {
    enable = true;
    settings.vim = {
      clipboard = {
        enable = true;
        registers = "unnamedplus";
        providers.wl-copy.enable = true;
        providers.xclip.enable = true;
      };
      options = {
        shiftwidth = 2;
        ignorecase = true;
        smartcase = true;
        signcolumn = "yes";
        confirm = true;
        autoindent = true;
        expandtab = true;
        linebreak = true;
        tabstop = 4;
        scrolloff = 4;
        laststatus = 3;
        mouse = "a";
        mousescroll = "ver:20";

        swapfile = false;
        backup = false;
        undofile = true;

        hlsearch = false;
        incsearch = true;
        updatetime = 50;
        cursorline = true;
        cursorcolumn = false;
        conceallevel = 2;
      };

      # notes.obsidian = {
      #   enable = true;
      #   setupOpts.daily_notes.folder = ''
      #     /home/cafo/Documents/Notes/'';
      # };

      viAlias = false;
      vimAlias = true;
      lsp = {
        enable = true;
        lightbulb = {
          enable = true;
          autocmd.enable = true;
        };
        lspconfig.enable = true;
        lspkind.enable = true;
        lspsaga.enable = true;
        null-ls.enable = true;
        trouble.enable = true;
      };

      extraPlugins = {
        kanagawa= {
          package = pkgs.vimPlugins.kanagawa-nvim;
          setup = "require('kanagawa').setup {}";
        };
      };
      luaConfigPost = ''
  -- Global replace word under cursor
  vim.api.nvim_create_user_command("ReplaceWordUnderCursor", function()
    local word = vim.fn.expand("<cword>")
    vim.cmd("let @/ = '\\<" .. word .. "\\>'")
    vim.cmd("call feedkeys(':%s/\\<" .. word .. "\\>/', 'n')")
  end, {})

  require("kanagawa").setup({
    style = "dragon",
    transparent = true,
  })
  -- vim.cmd("colorscheme kanagawa-dragon")
'';

      theme = {
        enable = true;
        name = "catppuccin";
        transparent = true;
        style = "mocha";
      };

      statusline.lualine.enable = true;
      # telescope.enable = true;

      terminal.toggleterm = {
        enable = true;
        lazygit = {
          enable = true;
          mappings.open = "<leader>lg";
        };
      };

      autocomplete = {
        enableSharedCmpSources = true;
        blink-cmp = {
          enable = false;
          friendly-snippets.enable = true;
          sourcePlugins.emoji.enable = true;
          sourcePlugins.ripgrep.enable = true;
        };
        nvim-cmp = {
          enable = true;
        };
      };

      # autopairs.nvim-autopairs.enable = true;
      binds.whichKey.enable = true;
      # comments.comment-nvim.enable = true;

      diagnostics.nvim-lint = {
        enable = true;
      };

      filetree.neo-tree= {
        enable = true;
        setupOpts.filesystem.hijack_netrw_behavior = "disabled";
      };

      git = {
        enable = true;

        gitlinker-nvim.enable = false;
        git-conflict.enable = true;
      };

      globals = {
        mapleader = " ";
      };

      keymaps = [
        {
          key = "<C-Del>";
          mode = ["n" "x" "i" "v"];
          desc = "delete word";
          silent = true;
          action = "<C-o>dw";
        }
        {
          key = "<C-BS>";
          mode = ["n" "x" "i" "v"];
          desc = "delete word";
          silent = true;
          action = "<C-o>db";
        }
        {
          key = "<C-BS>";
          mode = ["n" "x" "i" "v"];
          desc = "delete word";
          silent = true;
          action = "<C-o>db";
        }
        {
          key = "<leader>n";
          mode = ["n" "x" "i" "v"];
          desc = "Notification history";
          silent = true;
          action = ":lua Snacks.picker.notifications()<CR>";
        }
        {
          key = "<leader>/";
          mode = ["n" "x" "i" "v"];
          desc = "Snacks grep";
          silent = true;
          action = ":lua Snacks.picker.grep()<CR>";
        }
        {
          key = "<leader>sd";
          mode = ["n" "x" "i" "v"];
          desc = "Diagnostics";
          silent = true;
          action = ":lua Snacks.picker.diagnostics()<CR>";
        }
        {
          key = "<leader>fb";
          mode = ["n" "x" "i" "v"];
          desc = "Snacks Buffer";
          silent = true;
          action = ":lua Snacks.picker.buffers()<CR>";
        }
        {
          key = "<leader>f.";
          mode = ["n" "x" "i" "v"];
          desc = "Recents";
          silent = true;
          action = ":lua Snacks.picker.recent({filter = {cwd = true}})<CR>";
        }
        {
          key = "<leader>fg";
          mode = ["n" "x" "i" "v"];
          desc = "Git files";
          silent = true;
          action = ":lua Snacks.picker.git_files()<CR>";
        }
        {
          key = "<leader>sb";
          mode = ["n" "x" "i" "v"];
          desc = "Buffer Lines";
          silent = true;
          action = ":lua Snacks.picker.lines()<CR>";
        }
        {
          key = "<leader>bd";
          mode = ["n" "x" "i" "v"];
          desc = "Delete Buffer";
          silent = true;
          action = ":lua Snacks.bufdelete()<CR>";
        }
        {
          key = "<leader>b.";
          mode = ["n" "x" "i" "v"];
          desc = "Toggle Scratch Buffer";
          silent = true;
          action = ":lua Snacks.scratch()<CR>";
        }
        {
          key = "<leader>S";
          mode = ["n" "x" "i" "v"];
          desc = "Select Scratch Buffer";
          silent = true;
          action = ":lua Snacks.scratch.select()<CR>";
        }
        {
          key = "<leader>cR";
          mode = ["n" "x" "i" "v"];
          desc = "Rename File";
          silent = true;
          action = ":lua Snacks.rename.rename_file()<CR>";
        }
        {
          key = "<leader>z";
          mode = ["n" "x" "i" "v"];
          desc = "Toggle Zen mode";
          silent = true;
          action = ":lua Snacks.zen()<CR>";
        }
        {
          key = "<leader>Z";
          mode = ["n" "x" "i" "v"];
          desc = "Toggle Zen Zoom";
          silent = true;
          action = ":lua Snacks.zen.zoom()<CR>";
        }
        {
          key = "gI";
          mode = ["n" "x" "i" "v"];
          desc = "Goto T[y]pe Definition";
          silent = true;
          action = ":lua Snacks.picker.lsp_type_definitions()<CR>";
        }
        {
          key = "gI";
          mode = ["n" "x" "i" "v"];
          desc = "Goto Implementations";
          silent = true;
          action = ":lua Snacks.picker.lsp_implementations()<CR>";
        }
        {
          key = "gr";
          mode = ["n" "x" "i" "v"];
          desc = "References";
          silent = true;
          action = ":lua Snacks.picker.lsp_references()<CR>";
        }
        {
          key = "gD";
          mode = ["n" "x" "i" "v"];
          desc = "Goto declaration";
          silent = true;
          action = ":lua Snacks.picker.lsp_declarations()<CR>";
        }
        {
          key = "gd";
          mode = ["n" "x" "i" "v"];
          desc = "Goto definition";
          silent = true;
          action = ":lua Snacks.picker.lsp_definitions()<CR>";
        }
        {
          key = "<leader>f,";
          mode = ["n" "x" "i" "v"];
          desc = "Files";
          silent = true;
          action = ":lua Snacks.picker.files()<CR>";
        }
        {
          key = "<leader>ff";
          mode = ["n" "x" "i" "v"];
          desc = "Smart Picker";
          silent = true;
          action = ":lua Snacks.picker.smart()<CR>";
        }
        {
          key = "<leader>sr";
          mode = ["n" "x" "i" "v"];
          desc = "Resumee";
          silent = true;
          action = ":lua Snacks.picker.resume()<CR>";
        }
        {
          key = "<leader>su";
          mode = ["n" "x" "i" "v"];
          desc = "Undo Tree";
          silent = true;
          action = ":lua Snacks.picker.undo()<CR>";
        }
        {
          key = "<C-n>";
          mode = ["n" "x" "i" "v"];
          desc = "Toggle Explorer";
          silent = true;
          action = ":lua Snacks.explorer()<CR>";
        }
        {
          key = "<C-s>";
          desc = "Global Replace";
          mode = "n";
          silent = false;
          action = ":ReplaceWordUnderCursor<CR>";
        }
      #   {
      #     key = "<leader>s";
      #   desc = "Global Replace";
      #   mode = "n";
      #   silent = true;
      #   action = ":%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>";
      # }
      {
        key = "<leader>wq";
        desc = "Quit Window";
        mode = "n";
        silent = true;
        action = ":q<CR>";
      }
      {
        key = "<leader>fs";
        desc = "Write File";
        mode = "n";
        silent = false;
        action = ":w<CR>";
      }
      {
        key = "<leader>wv";
        desc = "Vertical Split";
        mode = "n";
        silent = false;
        action = ":vs<CR>";
      }
      {
        key = "<leader>w";
        desc = "Window";
        silent = true;
        mode = "n";
        action = "<C-w>";
      }
      {
        key = "<A-e>";
        mode = ["n" "x" "v"];
        silent = true;
        action = "$";
      }
      {
        key = "<A-w>";
        mode = ["n" "x" "v"];
        silent = true;
        action = "^";
      }
      {
        key = "<A-1>";
        mode = ["n" "x"];
        silent = false;
        action = "<Cmd>BufferGoto 1<CR>";
      }
      {
        key = "<A-2>";
        mode = ["n" "x"];
        silent = false;
        action = "<Cmd>BufferGoto 2<CR>";
      }
      {
        key = "<A-3>";
        mode = ["n" "x"];
        silent = false;
        action = "<Cmd>BufferGoto 3<CR>";
      }
      {
        key = "<A-4>";
        mode = ["n" "x"];
        silent = false;
        action = "<Cmd>BufferGoto 4<CR>";
      }
      {
        key = "<A-5>";
        mode = ["n" "x"];
        silent = false;
        action = "<Cmd>BufferGoto 5<CR>";
      }
      {
        key = "<A-6>";
        mode = ["n" "x"];
        silent = false;
        action = "<Cmd>BufferGoto 6<CR>";
      }
      {
        key = "<A-7>";
        mode = ["n" "x"];
        silent = false;
        action = "<Cmd>BufferGoto 7<CR>";
      }
      {
        key = "<A-8>";
        mode = ["n" "x"];
        silent = false;
        action = "<Cmd>BufferGoto 8<CR>";
      }
      {
        key = "<A-9>";
        mode = ["n" "x"];
        silent = false;
        action = "<Cmd>BufferGoto 9<CR>";
      }
      {
        key = "<A-0>";
        mode = ["n" "x"];
        silent = false;
        action = "<Cmd>BufferLast<CR>";
      }
      {
        key = "<A-c>";
        mode = ["n" "x"];
        silent = false;
        action = "<Cmd>BufferClose<CR>";
      }
      {
        key = "K";
        mode = "v";
        desc = "Move Line up";
        silent = true;
        action = ":m '<-2<CR>gv=gv";
      }
      {
        key = "J";
        mode = "v";
        desc = "Move Line Down";
        silent = true;
        action = ":m '>+1<CR>gv=gv";
      }
      ];

      treesitter = {
        indent.enable = true;
        enable = true;
        fold = true;
      };

      languages = {
        enableTreesitter = true;
        clang.enable = true;
        nix.enable = true;
        rust.enable = true;
        python.enable = true;
      };

      mini = {
        align.enable = true;
        comment.enable = true;
        pairs.enable = true;
        basics.enable = true;
        surround.enable = true;
        icons.enable = true;
        # animate.enable = true;
        notify.enable = true;
      };

      snippets.luasnip.enable = true;
      spellcheck.enable = true;
      tabline.nvimBufferline.enable = true;

      ui = {
        colorizer.enable = true;
        noice.enable = true;
      };

      utility.preview.glow.enable = true;

      utility.snacks-nvim = {
        enable = true;
        setupOpts = {
          explorer.enable = true;
          dashboard.enable = true;
          bigfile.enable = true;
          indent.enable = true;
          notifier = {
            enable = true;
            timeout = 3000;
          };
          picker.enable = true;
          words.enable = true;
          statuscolumn.enable = true;
          scroll.enable = true;
          quickfile.enable = true;
        };
      };

      visuals = {
        indent-blankline.enable = true;
        indent-blankline.setupOpts.scope.enabled = true;
        rainbow-delimiters.enable = true;
        nvim-web-devicons.enable = true;
        fidget-nvim = {
          enable = true;
          setupOpts.integration.nvim-tree.enable = true;
        };
        cinnamon-nvim = {
          enable = true;
          # setupOpts.keymaps.basic = true;
          # setupOpts.keymaps.extra = true;
        };
      };

      withPython3 = true;
      navigation.harpoon = {
        enable = true;
        mappings = {
          file1 = "<leader>1";
          file2 = "<leader>2";
          file3 = "<leader>3";
          file4 = "<leader>4";
        };
      };
    };
  };
}
