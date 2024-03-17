-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Define an autocmd to format the current buffer with Prettier when saving
vim.cmd([[
    augroup PrettierFormat
        autocmd!
        autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.css,*.scss,*.html,*.json,*.yaml,*.yml %!prettier --stdin-filepath % --write
    augroup END
]])

-- Autocommands for compiling programs
vim.cmd([[
    augroup CompileOnSave
        autocmd! 
        autocmd BufWritePost *.java !javac %
        autocmd BufWritePost *.c !gcc % -o %:r
        autocmd BufWritePost *.cpp !g++ % -o %:r
    augroup END
]])

-- Set the correct tab size
vim.cmd([[
    augroup TabSizeSettings
        autocmd!
        autocmd BufRead,BufNewFile *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
        autocmd BufRead,BufNewFile *.c,*.cpp,*.java setlocal tabstop=4 softtabstop=4 shiftwidth=4
        autocmd BufRead,BufNewFile *.html,*.xml,*.xhtml,*.css,*.js,*.json,*.yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
    augroup END
]])

-- Automatically set the best settings for txt files
vim.cmd([[
    augroup TextFileSettings
        autocmd!
        autocmd BufRead,BufNewFile *.txt,*.ms setlocal spell linebreak wrap
    augroup END
]])
