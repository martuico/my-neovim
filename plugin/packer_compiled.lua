-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/marcarlotuico/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/marcarlotuico/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/marcarlotuico/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/marcarlotuico/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/marcarlotuico/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["fidget.nvim"] = {
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["formatter.nvim"] = {
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/formatter.nvim",
    url = "https://github.com/mhartington/formatter.nvim"
  },
  harpoon = {
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/harpoon",
    url = "https://github.com/theprimeagen/harpoon"
  },
  ["lazygit.nvim"] = {
    config = { "\27LJ\2\nL\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\flazygit\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/lazygit.nvim",
    url = "https://github.com/kdheepak/lazygit.nvim"
  },
  ["lsp-zero.nvim"] = {
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17martuico.lsp\frequire\0" },
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/lsp-zero.nvim",
    url = "https://github.com/VonHeikemen/lsp-zero.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason-null-ls.nvim"] = {
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/mason-null-ls.nvim",
    url = "https://github.com/jay-babu/mason-null-ls.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  moonfly = {
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/moonfly",
    url = "https://github.com/bluz71/vim-moonfly-colors"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\n#\0\1\4\1\1\0\0039\1\0\0-\3\0\0D\1\2\0\0À\18root_has_file\20\1\1\2\0\1\0\0033\1\0\0002\0\0€L\1\2\0\0E\0\1\5\3\0\0\14-\1\0\0-\3\1\0B\1\2\2\18\3\0\0B\1\2\2-\2\0\0-\4\2\0B\2\2\2\18\4\0\0B\2\2\2\r\3\1\0X\3\1€\19\3\2\0L\3\2\0\1À\2À\3Àæ\1\0\2\5\0\6\0\r9\2\0\0009\2\1\2\15\0\2\0X\3\b€6\2\2\0009\2\3\2'\4\4\0B\2\2\0016\2\2\0009\2\3\2'\4\5\0B\2\2\1K\0\1\0Fcommand! -buffer FormattingSync lua vim.lsp.buf.formatting_sync()=command! -buffer Formatting lua vim.lsp.buf.formatting()\bcmd\bvim\24document_formatting\24server_capabilitiesò\5\1\0\15\0\"\1X6\0\0\0'\2\1\0B\0\2\0023\1\2\0005\2\3\0005\3\4\0005\4\5\0005\5\6\0005\6\n\0005\a\b\0003\b\a\0=\b\t\a=\a\v\0065\a\f\0\18\b\1\0\18\n\2\0B\b\2\2=\b\t\a=\a\r\0065\a\14\0\18\b\1\0\18\n\3\0B\b\2\2=\b\t\a=\a\15\0065\a\16\0\18\b\1\0\18\n\4\0B\b\2\2=\b\t\a=\a\17\0065\a\18\0\18\b\1\0\18\n\5\0B\b\2\2=\b\t\a=\a\19\0063\a\20\0009\b\21\0005\n\31\0004\v\a\0009\f\22\0009\f\23\f9\f\24\f9\f\25\f9\14\r\6B\f\2\2>\f\1\v9\f\22\0009\f\26\f9\f\24\f9\f\25\f9\14\v\6B\f\2\2>\f\2\v9\f\22\0009\f\26\f9\f\27\f9\f\25\f9\14\15\6B\f\2\2>\f\3\v9\f\22\0009\f\26\f9\f\28\f9\f\25\f9\14\17\6B\f\2\2>\f\4\v9\f\22\0009\f\26\f9\f\29\f9\f\25\f9\14\19\6B\f\2\2>\f\5\v9\f\22\0009\f\30\f9\f\24\f9\f\25\f9\14\r\6B\f\2\0?\f\0\0=\v \n=\a!\nB\b\2\0012\0\0€K\0\1\0\14on_attach\fsources\1\0\0\17code_actions\15elm_format\vstylua\rprettier\15formatting\twith\reslint_d\16diagnostics\rbuiltins\nsetup\0\26elm_format_formatting\1\0\0\22stylua_formatting\1\0\0\24prettier_formatting\1\0\0\23eslint_diagnostics\1\0\0\22eslint_formatting\1\0\0\14condition\1\0\0\0\1\2\0\0\relm.json\1\3\0\0\16stylua.toml\17.stylua.toml\1\4\0\0\16.prettierrc\19.prettierrc.js\21.prettierrc.json\1\4\0\0\14.eslintrc\17.eslintrc.js\19.eslintrc.json\0\fnull-ls\frequire\r€€À™\4\0" },
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/nvim-compe",
    url = "https://github.com/hrsh7th/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/nvim-tree/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["rose-pine"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\26colorscheme rose-pine\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/rose-pine",
    url = "https://github.com/rose-pine/neovim"
  },
  ["schemastore.nvim"] = {
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/schemastore.nvim",
    url = "https://github.com/b0o/schemastore.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  undotree = {
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/Users/marcarlotuico/.local/share/nvim/site/pack/packer/start/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: rose-pine
time([[Config for rose-pine]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\26colorscheme rose-pine\bcmd\bvim\0", "config", "rose-pine")
time([[Config for rose-pine]], false)
-- Config for: lazygit.nvim
time([[Config for lazygit.nvim]], true)
try_loadstring("\27LJ\2\nL\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\flazygit\19load_extension\14telescope\frequire\0", "config", "lazygit.nvim")
time([[Config for lazygit.nvim]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\n#\0\1\4\1\1\0\0039\1\0\0-\3\0\0D\1\2\0\0À\18root_has_file\20\1\1\2\0\1\0\0033\1\0\0002\0\0€L\1\2\0\0E\0\1\5\3\0\0\14-\1\0\0-\3\1\0B\1\2\2\18\3\0\0B\1\2\2-\2\0\0-\4\2\0B\2\2\2\18\4\0\0B\2\2\2\r\3\1\0X\3\1€\19\3\2\0L\3\2\0\1À\2À\3Àæ\1\0\2\5\0\6\0\r9\2\0\0009\2\1\2\15\0\2\0X\3\b€6\2\2\0009\2\3\2'\4\4\0B\2\2\0016\2\2\0009\2\3\2'\4\5\0B\2\2\1K\0\1\0Fcommand! -buffer FormattingSync lua vim.lsp.buf.formatting_sync()=command! -buffer Formatting lua vim.lsp.buf.formatting()\bcmd\bvim\24document_formatting\24server_capabilitiesò\5\1\0\15\0\"\1X6\0\0\0'\2\1\0B\0\2\0023\1\2\0005\2\3\0005\3\4\0005\4\5\0005\5\6\0005\6\n\0005\a\b\0003\b\a\0=\b\t\a=\a\v\0065\a\f\0\18\b\1\0\18\n\2\0B\b\2\2=\b\t\a=\a\r\0065\a\14\0\18\b\1\0\18\n\3\0B\b\2\2=\b\t\a=\a\15\0065\a\16\0\18\b\1\0\18\n\4\0B\b\2\2=\b\t\a=\a\17\0065\a\18\0\18\b\1\0\18\n\5\0B\b\2\2=\b\t\a=\a\19\0063\a\20\0009\b\21\0005\n\31\0004\v\a\0009\f\22\0009\f\23\f9\f\24\f9\f\25\f9\14\r\6B\f\2\2>\f\1\v9\f\22\0009\f\26\f9\f\24\f9\f\25\f9\14\v\6B\f\2\2>\f\2\v9\f\22\0009\f\26\f9\f\27\f9\f\25\f9\14\15\6B\f\2\2>\f\3\v9\f\22\0009\f\26\f9\f\28\f9\f\25\f9\14\17\6B\f\2\2>\f\4\v9\f\22\0009\f\26\f9\f\29\f9\f\25\f9\14\19\6B\f\2\2>\f\5\v9\f\22\0009\f\30\f9\f\24\f9\f\25\f9\14\r\6B\f\2\0?\f\0\0=\v \n=\a!\nB\b\2\0012\0\0€K\0\1\0\14on_attach\fsources\1\0\0\17code_actions\15elm_format\vstylua\rprettier\15formatting\twith\reslint_d\16diagnostics\rbuiltins\nsetup\0\26elm_format_formatting\1\0\0\22stylua_formatting\1\0\0\24prettier_formatting\1\0\0\23eslint_diagnostics\1\0\0\22eslint_formatting\1\0\0\14condition\1\0\0\0\1\2\0\0\relm.json\1\3\0\0\16stylua.toml\17.stylua.toml\1\4\0\0\16.prettierrc\19.prettierrc.js\21.prettierrc.json\1\4\0\0\14.eslintrc\17.eslintrc.js\19.eslintrc.json\0\fnull-ls\frequire\r€€À™\4\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: lsp-zero.nvim
time([[Config for lsp-zero.nvim]], true)
try_loadstring("\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17martuico.lsp\frequire\0", "config", "lsp-zero.nvim")
time([[Config for lsp-zero.nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
