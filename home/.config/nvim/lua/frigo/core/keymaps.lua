-- vim.g.mapleader = "\\" -- Setting leader to be ALT
vim.g.mapleader = " " -- Setting leader to be SPACE

-- :h keycodes to see vim's names for keys

local keymap = vim.keymap

keymap.set("n", "<leader>l", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<leader>n", ":set relativenumber!<CR>", { desc = "Toggle relative numbers" })

keymap.set("n", "<leader>=", "<C-a>", { desc = "Increase number" })
keymap.set("n", "<leader><kPlus>", "<C-a>", { desc = "Increase number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrease number" })
keymap.set("n", "<leader><kMinus>", "<C-x>", { desc = "Decrease number" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tt", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tT", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
-- keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
