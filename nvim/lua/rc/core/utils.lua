-- local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Remove whitespace on save
autocmd({ "BufRead", "BufWritePre" }, {
        pattern = "*",
        command = "",
})
-- Don't auto commenting new lines
autocmd("BufEnter", {
        pattern = "*",
        command = "set fo-=c fo-=r fo-=o",
})

-- Restore cursor location when file is opened
autocmd({ "BufReadPost" }, {
        pattern = { "*" },
        callback = function()
                vim.api.nvim_exec('silent! normal! g`"zv', false)
        end,
})

-- Highlight trailing spaces
-- autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Gray ctermbg=Gray
-- autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
