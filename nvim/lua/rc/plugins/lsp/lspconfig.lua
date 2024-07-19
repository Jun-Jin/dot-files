return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    vim.diagnostic.config({
      virtual_text = false, -- disable virtual text
      update_in_insert = true,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness

    local on_attach = function()
      -- set keybinds
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", { desc = "Show LSP references" })
      keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" } )
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Show LSP definitions" })
      keymap.set("n", "<leader>gi", "<cmd>Telescope lsp_implementations<CR>", {desc = "Show LSP implementations" })
      keymap.set("n", "<leader>gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Show LSP type definitions" })
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "see available code actions, in visual mode will apply to selection" })
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" })
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostics" })
      keymap.set("n", "dg", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
      keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
      keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
      keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation for what is under cursor" })
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" })
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()
    local util = require("lspconfig/util")

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- configure golang server
    lspconfig["gopls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        gopls = {
          buildFlags = {"-tags=wireinject"},
        }
      },
      cmd = {"gopls"},
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    })
    local configs = require 'lspconfig/configs'
    if not configs.golangcilsp then
      configs.golangcilsp = {
        default_config = {
          cmd = {'golangci-lint-langserver'},
          root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
          init_options = {
              command = { "golangci-lint", "run", "--enable-all", "--disable", "lll", "--out-format", "json", "--issues-exit-code=1" };
          },
        };
      }
    end
    lspconfig["golangci_lint_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        filetypes = {'go', 'gomod'}
      }
    })

    -- configure lua server (with special settings)
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    -- other
    local others = {
      "biome", -- json/js/ts
      "tsserver", -- ts/js
      "html", -- html
      "cssls", -- css
      "emmet_ls", -- emmet
      "pyright", -- python
      "solargraph", -- ruby
      "terraformls", -- terraform
    }
    for _, s in ipairs(others) do
      lspconfig[s].setup({
          capabilities = capabilities,
          on_attach = on_attach,
      })
    end
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })

  -- Autocomplete import with golang
  local autocmd = vim.api.nvim_create_autocmd -- Create autocommand
  autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      local params = vim.lsp.util.make_range_params()
      params.context = {only = {"source.organizeImports"}}
      -- buf_request_sync defaults to a 1000ms timeout. Depending on your
      -- machine and codebase, you may want longer. Add an additional
      -- argument after params if you find that you have to write the file
      -- twice for changes to be saved.
      -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
      local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
      for cid, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
          if r.edit then
            local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
            vim.lsp.util.apply_workspace_edit(r.edit, enc)
          end
        end
      end
      vim.lsp.buf.format({async = false})
    end
  })
  end,
}
