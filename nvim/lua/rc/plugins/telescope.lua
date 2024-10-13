return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate" },
        mappings = {
          i = {
            ["<C-p>"] = actions.move_selection_previous,
            ["<C-n>"] = actions.move_selection_next,
            -- ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
        layout_strategy = "vertical",
        dynamic_preview_title = true,
        layout_config = {
          vertical = {
            width = 0.9,
          },
          preview_cutoff = 1,
          -- preview_height = 15,
        },
      },
    })

    telescope.load_extension("fzf")

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
    vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Fuzzy find recent files" })
    vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Find string in cwd" })
    vim.keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Find string under cursor in cwd" })
  end,
}
