return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  event = "VeryLazy",
  config = function()
    local dap = require("dap")
    dap.adapters.delve = {
      type = 'server',
      port = '${port}',
      executable = {
        command = 'dlv',
        args = {'dap', '-l', '127.0.0.1:${port}'},
      }
    }

    -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
    dap.configurations.go = {
      {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${file}"
      },
      {
        type = "delve",
        name = "Debug test", -- configuration for debugging test files
        request = "launch",
        mode = "test",
        program = "${file}"
      },
      -- works with go.mod packages and sub packages 
      {
        type = "delve",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}"
      } 
    }

    -- dap keymaps
    -- should unset <F11> on MacOS
    vim.keymap.set('n', '<F5>', dap.continue)
    vim.keymap.set('n', '<Leader><Esc>', dap.disconnect)
    vim.keymap.set('n', '<F10>', dap.step_into)
    vim.keymap.set('n', '<F11>', dap.step_over)
    vim.keymap.set('n', '<F12>', dap.step_out)
    vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint)
    vim.keymap.set('n', '<Leader>B', dap.clear_breakpoints)
    vim.keymap.set('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    vim.keymap.set('n', '<Leader>dr', dap.repl.open)
    vim.keymap.set('n', '<Leader>dl', dap.run_last)

    -- dap-ui
    local dapui = require("dapui")
    dapui.setup({
      layouts = {
        {
          elements = {
            'scopes',
          },
          size = 10,
          position = 'bottom',
        },
        {
          elements = {
            'breakpoints',
            'stacks',
          },
          size = 60,
          position = 'right',
        },
      },
    })
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({})
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close({})
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close({})
    end

    -- dap-ui keymaps
    local widgets = require("dap.ui.widgets")
    vim.keymap.set({'n', 'v'}, '<Leader>dh', function() widgets.hover() end)
    vim.keymap.set({'n', 'v'}, '<Leader>dp', function() widgets.preview() end)
    vim.keymap.set('n', '<Leader>df', function() widgets.centered_float(widgets.frames) end)
    vim.keymap.set('n', '<Leader>ds', function() widgets.centered_float(widgets.scopes) end)
  end,
}
