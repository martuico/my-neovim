vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-s>", ":w!<CR>")
-- Move text up and down
-- Visual Block --
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>vwm", function()
	require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
	require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
-- local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
--vim.api.nvim_feedkeys(esc, "x", false)
vim.keymap.set("i", "<C-c>", "<Esc>")
--vim.keymap.set("i", "<C-c>", "<Plug>CapsLockToggle")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- use Ctrl+s to save and fix format
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/martuico/packer.lua<CR>")
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

vim.keymap.set("n", "<leader><leader><CR>", function()
	vim.cmd("so")
end)

vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>")
vim.keymap.set("n", "<leader>wv", "<cmd>vs<CR>")
vim.keymap.set("n", "<leader>wh", "<cmd>sp<CR>")
vim.keymap.set("n", "<leader>wq", "<cmd>bd<CR>")
vim.keymap.set("n", "<C-H>", "<C-w>W<CR>")
vim.keymap.set("n", "<C-L>", "<C-w>w<CR>")

-- global
vim.api.nvim_set_keymap(
	"n",
	"<C-`>",
	":ToggleTerm size=10 dir=%:p:h direction=horizontal<CR>",
	{ silent = true, noremap = true }
)

function _G.set_terminal_keymaps()
	local lazy = require("toggleterm.lazy")
	local ui = lazy.require("toggleterm.ui")
	local opts = { noremap = true }
	local has_open = ui.find_open_windows()
	if has_open then
		vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	end
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
