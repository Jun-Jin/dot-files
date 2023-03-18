local options = {
    title = true,
    encoding = "utf-8",
    fileencoding = "utf-8",
    signcolumn = "yes",
    number = true,
    clipboard = "unnamedplus",
    autoindent = true,
    splitbelow = true,
    splitright = true,
    ignorecase = true,
    smartcase = true,
    cursorline = true,
    binary=true,
    hlsearch = true
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
