local opt = vim.opt

-- encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.binary=true

-- ui
opt.title = true
opt.number = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.hlsearch = true
opt.splitbelow = true
opt.splitright = true
opt.listchars = 'tab:¦ ,trail:･'
opt.scrolloff = 5

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- indentation
opt.tabstop = 2       -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2    -- 2 spaces for indent width
opt.expandtab = true  -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- search
opt.ignorecase = true
opt.smartcase = true
