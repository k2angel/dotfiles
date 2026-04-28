{ pkgs, inputs, ... }:

{
  imports = [ inputs.nixvim.homeModules.nixvim ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    globals.mapleader = " ";
    diagnostic.settings.virtual_text = true;

    opts = {
      number = true;
      cursorline = true;
      relativenumber = true;
      signcolumn = "yes";
      expandtab = true;
      shiftwidth = 4;
      tabstop = 2;
      list = true;
      listchars = {
        space = "･";
        tab = "» ";
        trail = "_";
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = ":NvimTreeToggle<CR>";
      }
      {
        mode = "n";
        key = "<A-,>";
        action = "<Cmd>BufferLineCyclePrev<CR>";
      }
      {
        mode = "n";
        key = "<A-.>";
        action = "<Cmd>BufferLineCycleNext<CR>";
      }
      {
        mode = "n";
        key = "<A-<>";
        action = "<Cmd>BufferLineCyclePrev<CR>";
      }
      {
        mode = "n";
        key = "<A->>";
        action = "<Cmd>BufferLineCycleNext<CR>";
      }
    ]
    ++ (map
      (i: {
        mode = "n";
        key = "<A-${toString i}>";
        action = "<Cmd>BufferLineGoTo ${toString i}<CR>";
      })
      [
        1
        2
        3
        4
        5
        6
        7
        8
        9
      ]
    );

    extraPlugins = with pkgs.vimPlugins; [
      onedarkpro-nvim
      plenary-nvim
      (pkgs.vimUtils.buildVimPlugin {
        name = "fcitx-nvim";
        src = pkgs.fetchFromGitHub {
          owner = "h-hg";
          repo = "fcitx.nvim";
          rev = "c8543d72adf02a557722847c5d263171ec5c9bb4";
          hash = "sha256-0cxLjkg9rFtl4ISeiRlI14tDMezHQSiZIdchA2x2Yes=";
        };
      })
    ];
    extraConfigLuaPre = builtins.readFile ./init_pre.lua;
    extraConfigLua = builtins.readFile ./init.lua;

    plugins = {
      direnv.enable = true;
      dropbar.enable = true;
      friendly-snippets.enable = true;
      fidget.enable = true;
      gitsigns.enable = true;
      highlight-colors.enable = true;
      lsp.enable = true;
      nvim-autopairs.enable = true;
      sleuth.enable = true;
      treesj.enable = true;
      trouble.enable = true;
      web-devicons.enable = true;

      bufferline = {
        enable = true;
        settings = {
          options = {
            diagnostics = "nvim_lsp";
            disgnostics_indicator = ''
              function(count, level, diagnostics_dict, countext)
                local icon = level:match("error")
                return " " .. icon .. count
              end
            '';
            offsets = [
              {
                filetype = "NvimTree";
                text = "File Explorer";
                highlight = "Directory";
                separator = true;
              }
            ];
          };
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
          snippet.expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
          mapping = {
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif require('luasnip').expand_or_jumpable() then
                  require('luasnip').expand_or_jump()
                else
                  fallback()
                end
              end
            '';
            "<S-Tab>" = ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif require('luasnip').expand_or_jumpable(-1) then
                  require('luasnip').jump(-1)
                else
                  fallback()
                end
              end
            '';
          };
        };
        cmdline = {
          "/" = {
            mapping = {
              __raw = "cmp.mapping.preset.cmdline()";
            };
            sources = [ { name = "buffer"; } ];
          };
          ":" = {
            mapping = {
              __raw = "cmp.mapping.preset.cmdline()";
            };
            sources = [
              { name = "path"; }
              {
                name = "cmdline";
                option = {
                  ignore_cmds = [
                    "Man"
                    "!"
                  ];
                };
              }
            ];
          };
        };
      };

      conform-nvim = {
        enable = true;
        autoInstall.enable = true;
        settings = {
          format_on_save = {
            lsp_fallback = true;
            timeout_ms = 500;
          };
          formatters_by_ft = {
            javascript = [ "prettier" ];
            nix = [ "nixfmt" ];
            python = [ "ruff" ];
          };
        };
      };

      lspkind = {
        enable = true;
        cmp.enable = true;
      };

      lualine = {
        enable = true;
        settings = {
          options = {
            component_separators = {
              right = "::";
            };
            section_separators = {
              right = "";
            };
          };
          sections = {
            lualine_x = [
              "encoding"
              {
                __unkeyed-1 = "fileformat";
                icons_enabled = false;
              }
              {
                __unkeyed-2 = "filetype";
                icons_enabled = false;
              }
            ];
          };
          extensions = [
            "fzf"
            "nvim-tree"
            "toggleterm"
            "trouble"
          ];
        };
      };

      luasnip = {
        enable = true;
        fromVscode = [ { } ];
      };

      nvim-tree = {
        enable = true;
        settings = {
          hijack_cursor = true;
          view.width = "20%";
          update_focused_file = {
            enable = true;
            update_root.enable = true;
          };
        };
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = {
            action = "find_files";
            options = {
              desc = "Telescope find files";
            };
          };
          "<leader>fg" = {
            action = "live_grep";
            options = {
              desc = "Telescope live grep";
            };
          };
          "<leader>fb" = {
            action = "buffers";
            options = {
              desc = "Telescope buffers";
            };
          };
          "<leader>fh" = {
            action = "help_tags";
            options = {
              desc = "Telescope help tags";
            };
          };
          "<leader>fr" = {
            action = "registers";
            options = {
              desc = "Telescope registers";
            };
          };
        };
      };

      toggleterm = {
        enable = true;
        settings = {
          open_mapping = "[[<c-\\>]]";
          direction = "horizontal";
        };
      };

      treesitter = {
        enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          javascript
          json
          lua
          make
          markdown
          nix
          python
          regex
          toml
          vim
          vimdoc
          xml
          yaml
        ];
      };
    };

    lsp.servers = {
      basedpyright.enable = true;
      nixd.enable = true;
      vtsls.enable = true;
    };
  };
}
