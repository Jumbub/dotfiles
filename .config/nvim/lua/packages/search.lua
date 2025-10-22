local fzf = function(method)
  return function()
    return require("fzf-lua")[method]()
  end
end

return {
  {
    "ibhagwan/fzf-lua",
    lazy = false,
    config = function()
      require("fzf-lua").setup({
        defaults = {
          -- Set `file_icons` to false to disable file icons
          file_icons = false,
        },
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
            ["ctrl-a"] = "toggle-all",
          },
        },
        actions = {
          files = {
            ["enter"] = FzfLua.actions.file_edit_or_qf,
            ["ctrl-i"] = FzfLua.actions.toggle_ignore,
          },
        },
      })
      vim.api.nvim_create_user_command(
        "Rg",
        FzfLua.utils.create_user_command_callback("grep", "search"),
        { bang = true, nargs = "?" }
      )
    end,
    keys = {
      { "<C-p>", fzf("files") },
      { ",j", fzf("grep_visual"), mode = "v" },
      { ",j", fzf("grep_project") },
    },
  },
}