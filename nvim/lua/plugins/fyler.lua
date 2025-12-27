return {
  "A7Lavinraj/fyler.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  branch = "stable",
  lazy = true,
  opts = {
    integrations = {
      icon = "nvim_web_devicons",
    },
  },
  keys = {
    { "<leader>ee", function() require("fyler").open({ kind = "split_right_most" }) end, desc = "Open Fyler View" },
    -- { "<leader>ee", "<Cmd>Fyler<Cr>", desc = "Open Fyler View" },
  },
  views = {
    wind = {
      kind = "split_right_most"
    }
  }
}

