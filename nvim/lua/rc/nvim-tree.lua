-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

require('nvim-tree').setup {}

require('nvim-tree').setup {
  disable_netrw = true,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  view = {
    width = 50,
    side = "right",
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
}
