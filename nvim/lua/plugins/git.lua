return {
  {
    "FabijanZulj/blame.nvim",
    event = "VeryLazy",
    config = function()
      local blame = require("blame")
      blame.setup()
      local keymap = vim.keymap
      keymap.set("n", "<leader>gb", "<cmd>ToggleBlame<CR>")
    end
  },
  {
    'ruifm/gitlinker.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      remote = 'origin',
    },
  }
}
