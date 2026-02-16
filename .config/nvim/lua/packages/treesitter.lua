local function has_value(tab, val)
  for index, value in ipairs(tab) do
    if value == val then
      return true
    end
  end
  return false
end
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({ "gomod", "gosum", "go", "c_sharp" })
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(ctx)
          pcall(vim.treesitter.start)
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
