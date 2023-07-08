return {
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup()
      require("neoscroll.config").set_mappings({
        ["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "75" } },
        ["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "75" } },
        ["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "150" } },
        ["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "150" } },
        ["zt"] = { "zt", { "50" } },
        ["zz"] = { "zz", { "50" } },
        ["zb"] = { "zb", { "50" } },
      })
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
