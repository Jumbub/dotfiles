local fzf = function(method)
  return function()
    return require("fzf-lua")[method]()
  end
end

return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "junegunn/fzf" },
    lazy = false,
    config = function()
      require("fzf-lua").setup({
        "max-perf",
        winopts = {
          split = "belowright new",
          preview = {
            border = "noborder",
            hidden = "hidden",
            layout = "horizontal",
          },
        },
        keymap = {
          fzf = {
            ["ctrl-p"] = "toggle-preview",
          },
        },
      })
    end,
    keys = {
      { "<C-p>", fzf("files") },
    },
  },
}
