function CopilotChatBuffer()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
  end
end

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    config = function()
      local chat = require("CopilotChat")
      chat.setup()
      vim.keymap.set("n", "<leader>cct", "<cmd>lua require('CopilotChat').toggle()<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>ccq", CopilotChatBuffer, { noremap = true, silent = true, desc = "Quick Chat" })
    end,
    -- See Commands section for default commands if you want to lazy load on them
  },
}

