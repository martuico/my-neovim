## My Neovim Setup
My personal setup projects with [javascript, typescript, react, vue, nextjs, nuxtjs, python, ruby, php]
//Todo @add (flutter, golang) in lsconfig + Mason
![Screenshot 2023-06-20 at 5 37 11 PM](https://github.com/martuico/my-neovim/assets/2949921/87133372-6ef7-4ea0-b7b1-df0d1b7f6873)


### Download Neovim use Packer
1. All packer scripts are in the ~/.config/nvim folder
2. git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
3. cd ./lua/martuico/packer.nvim Run :PackerInstall
4. Set settings on iTerm2
![Screenshot 2023-06-20 at 5 35 02 PM](https://github.com/martuico/my-neovim/assets/2949921/507bebe3-785c-436f-b6f1-d4cdb79dc7f6)


### Neovim Map
1. mapleader = "<Space>"
2. Vertical Split Window = "<leader>wv"
3. Horizontal Split Window = "<leader>wh"
3. Move to other window = "<C-l>" //ctrl + l
4. Show buffers = "<C-b">
5. For bookmarking files please check harpoon

### Surround Map
    Old text                    Command         New text
--------------------------------------------------------------------------------
    surr*ound_words             ysiw)           (surround_words)
    *make strings               ys$"            "make strings"
    [delete ar*ound me!]        ds]             delete around me!
    remove <b>HTML t*ags</b>    dst             remove HTML tags
    'change quot*es'            cs'"            "change quotes"
    <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
    delete(functi*on calls)     dsf             function calls

### Git Lazy
1. LazyGit = "<leader>gg"

## LSP Diagnostics
1. Toggle LSP Diagnostics = "??"
