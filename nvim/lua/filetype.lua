-- Set indent options for Python files
vim.api.nvim_exec([[
  set tabstop=4           "タブを含むファイルを開いた際, タブを何文字の空白に変換するか
  set shiftwidth=4        "自動インデントで入る空白数
  set softtabstop=0       "キーボードから入るタブの数
  set expandtab

if has("autocmd")
  filetype plugin on
  filetype indent on

  "sw=shiftwidth, sts=softtabstop, ts=tabstop, et=expandtabの略
  autocmd FileType javascriptreact setlocal sw=2 sts=2 ts=2
  autocmd FileType php        setlocal sw=4 sts=4 ts=4
endif
]], false)
