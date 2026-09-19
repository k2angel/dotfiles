{
  inputs,
  config,
  lib,
  pkgs,
  host,
  username,
  isNixOS,
  ...
}:

let
  helpers = config.lib.nixvim;
in
{
  imports = [ inputs.nixvim.homeModules.nixvim ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    globals.mapleader = " ";
    diagnostic.settings.virtual_text = true;

    nixpkgs = {
      config.allowUnfree = true;
      source = inputs.nixpkgs;
    };

    opts = {
      cursorline = true;
      number = true;
      relativenumber = true;
      signcolumn = "yes";
      expandtab = true;
      tabstop = 2;
      shiftwidth = 4;
      undofile = true;
      undolevels = 10000;
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
      {
        mode = "t";
        key = "<C-]>";
        action = "<C-\\><C-n>";
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

    extraConfigLuaPre = builtins.readFile ./init_pre.lua;
    extraPlugins = with pkgs.vimPlugins; [
      onedarkpro-nvim
      plenary-nvim
      fcitx-nvim
    ];

    plugins = {
      direnv.enable = true;
      dropbar.enable = true;
      friendly-snippets.enable = true;
      fidget.enable = true;
      gitsigns.enable = true;
      highlight-colors.enable = true;
      lspconfig.enable = true;
      nvim-autopairs.enable = true;
      refactoring.enable = true;
      sleuth.enable = true;
      treesitter.enable = true;
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
            rust = [ "rustfmt" ];
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
    };

    lsp = {
      keymaps = [
        {
          key = "gd";
          lspBufAction = "definition";
        }
        {
          key = "gD";
          lspBufAction = "references";
        }
        {
          key = "gt";
          lspBufAction = "type_definition";
        }
        {
          key = "gi";
          lspBufAction = "implementation";
        }
        {
          key = "K";
          lspBufAction = "hover";
        }
        {
          action = helpers.mkRaw "function() vim.diagnostic.jump({ count=-1, float=true }) end";
          key = "<leader>k";
        }
        {
          action = helpers.mkRaw "function() vim.diagnostic.jump({ count=1, float=true }) end";
          key = "<leader>j";
        }
        {
          action = ":lsp disable<CR>";
          key = "<leader>lx";
        }
        {
          action = ":lsp enable<CR>";
          key = "<leader>ls";
        }
        {
          action = ":lsp restart<CR>";
          key = "<leader>lr";
        }
      ];

      servers = {
        basedpyright.enable = true;
        clangd.enable = true;
        jsonls.enable = true;
        lua_ls.enable = true;
        rust_analyzer.enable = true;
        vtsls.enable = true;
        yamlls.enable = true;

        nixd = {
          enable = true;

          config.settings.nixd =
            let
              flake = "(builtins.getFlake \"${config.programs.nh.flake}\")";
            in
            {
              nixpkgs.expr = "import ${flake}.inputs.nixpkgs { }";

              options = {
                nixos.expr =
                  if isNixOS then
                    "${flake}.nixosConfigurations.${host}.options"
                  else
                    "${flake}.nixosConfigurations.visterhv.options";

                home_manager.expr =
                  if isNixOS then
                    "${flake}.nixosConfigurations.${host}.options.home-manager.users.type.getSubOptions []"
                  else
                    "${flake}.homeConfigurations.\"${username}@${host}\".options";
              };
            };
        };
      };
    };
  };
}
