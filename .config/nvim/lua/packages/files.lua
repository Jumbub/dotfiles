return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = true,
    config = function()
      require("nvim-tree").setup({
        renderer = {
          icons = {
            show = {
              file = false,
              folder = false,
              git = false,
            },
          },
        },
        view = {
          width = 60,
        },
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
      })
    end,
    keys = {
      { "<leader>m", "<cmd>NvimTreeFindFile<cr>" },
    },
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = true,
    opts = {},
    config = function()
      require("oil").setup({
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-s>"] = "actions.select_vsplit",
          ["<C-h>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-l>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["I"] = "actions.toggle_hidden",
        },
      })
    end,
    keys = {
      {
        "<c-,><c-m>",
        function()
          require("oil").open_float()
        end,
      },
    },
  },
  {
    "LunarVim/bigfile.nvim",
    lazy = false,
    config = function()
      require("bigfile").setup({
        filesize = 2, -- MiB
        features = {
          "indent_blankline",
          "illuminate",
          "lsp",
          "treesitter",
          "syntax",
          "matchparen",
          "vimopts",
          "filetype",
        },
      })
    end,
  },
}