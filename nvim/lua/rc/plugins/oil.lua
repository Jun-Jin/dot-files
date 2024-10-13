return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    use_default_keymaps = true,
    default_file_explorer = true,
    delete_to_trash = false,
    view_options = {
      natural_order = true,
    },
    win_options = {
      wrap = true,
    },
    lsp_file_methods = {
      -- Enable or disable LSP file operations
      enabled = true,
      -- Time to wait for LSP file operations to complete before skipping
      timeout_ms = 1000,
      -- Set to true to autosave buffers that are updated with LSP willRenameFiles
      -- Set to "unmodified" to only save unmodified buffers
      autosave_changes = false,
    },
  },
}
