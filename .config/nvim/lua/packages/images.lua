if os.getenv("USER") ~= "jamie" then
  return {}
end

return {
  {
    "https://github.com/3rd/image.nvim.git",
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = false, -- Disable rendering images in all markdown files
        },
      },
    },
  },
}
