vim.g.mapleader = " " -- set leader key to space
vim.g.copilot_no_tab_map = true

local keymap = vim.keymap -- for conciseness
-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Personal config
-- keymap('n', '<Space>', '<Nop>', { desc = "" })
keymap.set('n', '<C-w><Space>', 'o<ESC>', { desc = "Add new line" })
keymap.set('n', '<ESC><ESC>', ':nohl<CR>', { desc = "Turn off search highlight", silent = true })
keymap.set('n', '~', '~h', { desc = "Don't continue" })

keymap.set('i', 'jj', '<ESC>', { desc = "Escape with jj" })
keymap.set('i', 'kk', '<ESC>la', { desc = "Escape and re-enter insert mode" })
keymap.set('i', 'zz', '<ESC>zza', { desc = "Do \"zz\" and re-enter insert mode" })

-- keymap.set('v', 'J', ':m `>+1<CR>gv=gv', { desc = "a" })
-- keymap.set('v', 'K', ':m `>-2<CR>gv=gv', { desc = "a" })
