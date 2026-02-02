return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(ctx)
          local hasStarted = pcall(vim.treesitter.start) -- errors for filetypes with no parser
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      max_lines = 4,
      multiline_threshold = 2,
    },
  },
}