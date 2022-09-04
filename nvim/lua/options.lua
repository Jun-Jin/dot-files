local options = {
    title = true,
    encoding = "utf-8",
    fileencoding = "utf-8",
    signcolumn = "yes",
    number = true,
    expandtab = true,
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    clipboard = "unnamedplus",
    hlsearch = true,
    autoindent = true,
    splitbelow = true,
    splitright = true,
    ignorecase = true,
    smartcase = true,
    cursorline = true,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
