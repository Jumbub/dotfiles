if vim.env.USER ~= "jamie" then
  return {}
end

return {
  {
    "https://github.com/3rd/image.nvim.git",
    lazy = true, -- manually enabled
    opts = {
      backend = "kitty",
    },
  },
}
