return {
  -- { "sphamba/smear-cursor.nvim", opts = { cursor_color = "#d3cdc3" } },
  -- { "LuxVim/nvim-luxmotion" },
  {
    "karb94/neoscroll.nvim",
    lazy = false,
    config = function()
      local neoscroll = require("neoscroll")
      neoscroll.setup({
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing = "sine", -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
        performance_mode = false, -- Disable "Performance Mode" on all buffers.
        ignored_events = { -- Events ignored while scrolling
          "WinScrolled",
          "CursorMoved",
        },
      })
      local keymap = {
        ["<C-u>"] = function()
          neoscroll.ctrl_u({ duration = 200 })
        end,
        ["<C-d>"] = function()
          neoscroll.ctrl_d({ duration = 200 })
        end,
        ["<C-b>"] = function()
          neoscroll.ctrl_b({ duration = 150 })
        end,
        ["<C-f>"] = function()
          neoscroll.ctrl_f({ duration = 150 })
        end,
        ["zt"] = function()
          neoscroll.zt({ half_win_duration = 50 })
        end,
        ["zz"] = function()
          neoscroll.zz({ half_win_duration = 50 })
        end,
        ["zb"] = function()
          neoscroll.zb({ half_win_duration = 50 })
        end,
      }
      local modes = { "n", "v", "x" }
      for key, func in pairs(keymap) do
        vim.keymap.set(modes, key, func)
      end
    end,
    keys = {
      "<C-u>",
      "<C-d>",
      "<C-b>",
      "<C-f>",
      "zz",
      "zb",
      "zt",
    },
  },
}
