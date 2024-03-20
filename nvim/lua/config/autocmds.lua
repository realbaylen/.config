-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Automatic updates
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup("autoupdate"),
  callback = function()
    require("lazy").update({
      show = false,
    })
  end,
})

-- Define an autocmd to format the current buffer with Prettier when saving
vim.cmd([[
    augroup PrettierFormat
        autocmd!
        autocmd BufWritePost *.js,*.jsx,*.ts,*.tsx,*.css,*.scss,*.html,*.json,*.yaml,*.yml %!prettier --stdin-filepath % --write
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
        autocmd BufRead,BufNewFile *.py setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
        autocmd BufRead,BufNewFile *.c,*.cpp,*.java setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
        autocmd BufRead,BufNewFile *.html,*.xml,*.xhtml,*.css,*.js,*.json,*.yaml setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
    augroup END
]])

-- Automatically set the best settings for txt files
vim.cmd([[
    augroup TextFileSettings
        autocmd!
        autocmd BufRead,BufNewFile *.txt,*.ms setlocal spell spelllang=en_us linebreak wrap tabstop=4 softtabstop=4 shiftwidth=4 smartindent
        autocmd InsertCharPre * if search('\v(%^|[.!?]\_s)\_s*%#', 'bcnw') != 0 | let v:char = toupper(v:char) | endi
    augroup END
]])
