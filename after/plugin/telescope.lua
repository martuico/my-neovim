local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')

telescope.setup(
  {
    picker = {
      hidden = true
    },
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--trim" -- add this value
      },
      file_ignore_patterns = {
        ".git/",
        "target/",
        "docs/",
        "vendor/",
        "%.lock",
        "__pycache__/*",
        "%.sqlite3",
        "%.ipynb",
        "node_modules/*",
        "%.jpg",
        "%.jpeg",
        "%.png",
        "%.svg",
        "%.otf",
        "%.ttf",
        "%.webp",
        ".dart_tool/",
        ".github/",
        ".gradle/",
        ".idea/",
        ".settings/",
        ".vscode/",
        "__pycache__/",
        "build/",
        "dist/",
        "%.pdb",
        "%.dll",
        "%.class",
        "%.exe",
        "%.ico",
        "%.pdf",
        "%.dylib",
        "%.so",
        "%.out",
        "%.mkv",
        "%.mp4",
        "%.lock",
        "node_modules",
        "packer_compiled.lua",
      }
    }
  }
)
local default_opts = { noremap = true }
vim.keymap.set('n', '<leader>pf', telescope_builtin.find_files, default_opts)
vim.keymap.set('n', '<C-p>', telescope_builtin.git_files, default_opts)
vim.keymap.set('n', '<C-b>', telescope_builtin.buffers, default_opts)
vim.keymap.set('n', '<leader>vh', telescope_builtin.help_tags, default_opts)
vim.keymap.set('n', '<leader>ps', function()
  telescope_builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>.', function() telescope_builtin.find_files({ cwd = vim.fn.expand('%:p:h') }) end)
