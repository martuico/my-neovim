vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	command = "if mode() != 'c' | checktime | endif",
	pattern = { "*" },
})
vim.cmd("filetype plugin indent on")
vim.opt.guifont = { "JetbrainsMono Nerd Font", ":h15" }
-- unload nvim default plugins
vim.opt.termguicolors = true
vim.g.loaded_gzip = false
vim.g.loaded_matchit = false
vim.g.loaded_tarPlugin = false
vim.g.loaded_zipPlugin = false
vim.g.loaded_man = false
vim.g.loaded_2html_plugin = false
vim.g.loaded_remote_plugins = false
vim.g.loaded_perl_provider = false
-- vim.g.loaded_ruby_provider = false

local opt = vim.opt
opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
opt.autoread = true

-- line numbers
opt.number = true
opt.relativenumber = true

-- tabs and indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.swapfile = false
opt.smartindent = true

-- text wrap
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- hightligth active line
opt.cursorline = true
-- " Visual mode better less bright highlight
-- hi Visual cterm=NONE ctermfg=NONE ctermbg=237 guibg=#3a3a3a

-- true color terminal settings
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes" -- enable specific highlights in debug mode

-- backspace settings
opt.backspace = "indent,eol,start"
-- enable native clipboard instead of vim default clipboard behavior
-- opt.clipboard:append "unnamedplus"
vim.opt.clipboard:prepend({ "unnamed", "unnamedplus" })
-- split windows
opt.splitright = true
opt.splitbelow = true
-- set dash as normal letter instead of divide behavior
opt.iskeyword:append("-")
opt.showmode = false

-- auto completion menu height
vim.opt.pumheight = 10

-- backup
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.timeoutlen = 300
opt.updatetime = 300
opt.title = true -- set the title of window to the value of the titlestring
opt.titlestring = "%<%F - nvim" -- what the title of the window will be set to

opt.colorcolumn = "90"
opt.wrapmargin = 2
opt.textwidth = 90

vim.g.python3_host_prog = "/usr/local/bin/python3"
vim.g.loaded_ruby_provider = 0

vim.cmd("highlight Visual cterm=NONE ctermfg=NONE ctermbg=black guibg=#fff58e")
vim.cmd("highlight Search cterm=NONE ctermfg=NONE ctermbg=black guibg=#ff7e7e")
