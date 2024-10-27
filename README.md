# PerfNvim

PerfNvim is a Neovim plugin designed to integrate Perforce version control operations seamlessly into your workflow. It provides easy-to-use key mappings for common Perforce commands, enhancing your productivity.

## Features

- Add current buffer to Perforce (`p4 add`)
- Edit current buffer in Perforce (`p4 edit`)
- Revert unchanged files
- Navigate between changed lines
- View checked out files using Telescope

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

Add the following to your `init.lua` or equivalent configuration file:

```lua
{
    "guillemaru/perfnvim",
    config = function()
        require("perfnvim").setup()

        vim.keymap.set("n", "<leader>pa", function() require("perfnvim").P4add() end, { noremap = true, silent = true, desc = "'p4 add' current buffer" })
        vim.keymap.set("n", "<leader>pe", function() require("perfnvim").P4edit() end, { noremap = true, silent = true, desc = "'p4 edit' current buffer" })
        vim.keymap.set("n", "<leader>pR", ":!p4 revert -a %<CR>", { noremap = true, silent = true, desc = "Revert if unchanged" })
        vim.keymap.set("n", "<leader>pn", function() require("perfnvim").P4next() end, { noremap = true, silent = true, desc = "Jump to next changed line" })
        vim.keymap.set("n", "<leader>pp", function() require("perfnvim").P4prev() end, { noremap = true, silent = true, desc = "Jump to previous changed line" })
        vim.keymap.set("n", "<leader>po", function() require("perfnvim").P4opened() end, { noremap = true, silent = true, desc = "'p4 opened' (telescope)" })
    end
}
```

### Using [vim-plug](https://github.com/junegunn/vim-plug)

Add the following to your `init.vim` or `init.lua`:

```vim
" If using init.vim
call plug#begin('~/.config/nvim/plugged')

Plug 'guillemaru/perfnvim'

call plug#end()

lua << EOF
require("perfnvim").setup()

vim.keymap.set("n", "<leader>pa", function() require("perfnvim").P4add() end, { noremap = true, silent = true, desc = "'p4 add' current buffer" })
vim.keymap.set("n", "<leader>pe", function() require("perfnvim").P4edit() end, { noremap = true, silent = true, desc = "'p4 edit' current buffer" })
vim.keymap.set("n", "<leader>pR", ":!p4 revert -a %<CR>", { noremap = true, silent = true, desc = "Revert if unchanged" })
vim.keymap.set("n", "<leader>pn", function() require("perfnvim").P4next() end, { noremap = true, silent = true, desc = "Jump to next changed line" })
vim.keymap.set("n", "<leader>pp", function() require("perfnvim").P4prev() end, { noremap = true, silent = true, desc = "Jump to previous changed line" })
vim.keymap.set("n", "<leader>po", function() require("perfnvim").P4opened() end, { noremap = true, silent = true, desc = "'p4 opened' (telescope)" })
EOF
```

## Recommended Key Mappings

- `<leader>pa`: `'p4 add'` current buffer
- `<leader>pe`: `'p4 edit'` current buffer
- `<leader>pR`: Revert if unchanged
- `<leader>pn`: Jump to next changed line
- `<leader>pp`: Jump to previous changed line
- `<leader>po`: `'p4 opened'` (telescope)

These key mappings are designed to enhance your workflow by providing quick access to common Perforce commands. Feel free to customize them to your liking.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to open issues or submit pull requests.

