-- Neovim custom keymaps

-- Call leader map first
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- semicolon for command mode
-- vim.keymap.set("n", ";", ":")

-- Navigate out of insert mode
vim.keymap.set("i", "jj", "<esc>")
vim.keymap.set("i", "kk", "<esc>")
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("i", "kj", "<esc>")

-- Navigate within insert mode
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")

-- Move selected
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Search cursor middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Almost autopairs
vim.keymap.set("i", '""', '""<Left>')
vim.keymap.set("i", "''", "''<Left>")
vim.keymap.set("i", "[]", "[]<Left>")
vim.keymap.set("i", "{}", "{}<Left>")

-- Make file executable
vim.keymap.set("n", "<leader>dx", "<cmd>!chmod +x %<CR>", {silent=true, desc="Make Current File Executable"})
--
-- Return to netrw
vim.keymap.set("n", "<leader>gn", vim.cmd.Ex, {desc="⟶ Netrw"})

-- Toggle undotree
vim.keymap.set('n', '<leader>tu', vim.cmd.UndotreeToggle, {desc="Undo Tree"})

-- Toggle Colorizer
vim.keymap.set('n', '<leader>tc', vim.cmd.ColorizerToggle, {desc="Colorizer"})


-- Macros
-- Wrap var in print=
local wrap_in_print = require('kali.macros.python_wrap_in_print')
vim.keymap.set('n', '<leader>mp',
    function() wrap_in_print.WrapInPrint() end,
    { noremap = true, silent = true, desc = "Wrap in print(f'{var=}') statement" })

-- Insert `if __name__ == '__main__':` at the end of the file with two new lines
local insert_main_guard = require('kali.macros.python_if_name_dunder')
vim.keymap.set('n', '<leader>mg',
    function() insert_main_guard.InsertMainGuardAtEnd() end,
    { noremap = true, silent = true, desc = "Insert main guard" })

