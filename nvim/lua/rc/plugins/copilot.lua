vim.g.copilot_filetypes = {
  markdown = true,
  yaml = true,
}
return {
  'github/copilot.vim',
  event = "InsertEnter",
  keys = {
    { "<C-g>", 'copilot#Accept("<CR>")', mode = "i" , silent = true, expr = true, replace_keycodes = false },
    { "<C-L>", '<Plug>(copilot-accept-word)', mode = "i"}
  },
}
