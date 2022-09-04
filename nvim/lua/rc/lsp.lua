local global_ts = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib/tsserverlibrary.js" 

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
    ensure_installed = { "sumneko_lua", "clangd", "pyright", "tsserver", "volar" }
})

local nvim_lsp = require("lspconfig")
mason_lspconfig.setup_handlers({
  function(server_name)
    local node_root_dir = nvim_lsp.util.root_pattern("package.json")
    local is_node_repo = node_root_dir(vim.api.nvim_buf_get_name(0)) ~= nil

    for type, icon in pairs({ Error = " ", Warn = " ", Hint = " ", Info = " " }) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
    local opts = { capabilities = capabilities }

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

    if server_name == "sumneko_lua" then
      opts.settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.stdpath "config" .. "/lua"] = true,
            },
          },
          telemetry = {
            enable = false,
          },
        },
      }
    elseif server_name == "tsserver" then
      if not is_node_repo then return end
      opts.settings = {
        documentFormatting = false,
      }
      opts.filetypes = { "typescript", "typescriptreact", "typescript.tsx" }
      opts.cmd = { "typescript-language-server", "--stdio" }

    elseif server_name == "eslint" then
      if not is_node_repo then return end
      opts.root_dir = node_root_dir

    elseif server_name == "pyright" then
      opts.settings = {
        python = {
          analysis = {
            typeCheckingMode = "off",
          }
        }
      }
    elseif server_name == "volar" then
      opts.filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
      opts.settings = {
        runtime = { global_ts },
        vetur = {
          completion = {
            autoImport = true,
            useScaffoldSnippets = true
          },
          format = {
            defaultFormatter = {
              html = "none",
              js = "prettier",
            }
          },
          validation = {
            template = true,
            script = true,
            style = true,
            templateProps = true,
            interpolation = true
          },
          experimental = {
            templateInterpolationService = true
          },
        }
      }
      opts.root_dir = nvim_lsp.util.root_pattern("header.php", "package.json", "style.css", "webpack.config.js")
    end
    opts.on_attach = function(_, bufnr)
      local bufopts = { silent = true, buffer = bufnr }
      vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
      vim.keymap.set("n", "gC", vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
      vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format or vim.lsp.buf.formatting, bufopts)
      vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, bufopts)
      vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, bufopts)
      vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, bufopts)

      vim.keymap.set("n", "gl", vim.diagnostic.open_float, bufopts)
      vim.keymap.set("n", "gn", vim.diagnostic.goto_next, bufopts)
      vim.keymap.set("n", "gp", vim.diagnostic.goto_prev, bufopts)
      vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, bufopts)
    end

    nvim_lsp[server_name].setup(opts)
  end
})
