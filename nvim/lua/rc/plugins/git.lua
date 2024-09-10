return {
  "FabijanZulj/blame.nvim",
  event = "VeryLazy",
  config = function()
    local blame = require("blame")
    blame.setup({
      date_format = "%Y/%m/%d %H:%m",
      commit_detail_view = "split",
    })
    vim.keymap.set("n", "<leader>gb", "<cmd>BlameToggle<CR>")
  end,
}
