return {
  'github/copilot.vim',
  event = "InsertEnter",
  config = function()

      local keymap = vim.keymap
      -- https://github.com/orgs/community/discussions/29817#discussioncomment-4217615
      -- keymap.set("i", "<Tab>", 'copilot#')
      keymap.set("i", "<C-g>", 'copilot#Accept("<CR>")', { silent = true, expr = true, replace_keycodes = false })
      keymap.set("i", "<C-.>", "copilot#Next()", { silent = true, expr = true, replace_keycodes = false })
      keymap.set("i", "<C-,>", "copilot#Previous()", { silent = true, expr = true, replace_keycodes = false })
      keymap.set('i', '<C-L>', '<Plug>(copilot-accept-word)')
  end,
}
