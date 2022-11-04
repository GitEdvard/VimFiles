-- bootstrap packer module when new computer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use {'wbthomason/packer.nvim'}
  -- My plugins here
  use {'chriskempson/base16-vim'}
  use {'mhinz/vim-startify'}
  use {'scrooloose/nerdtree'}
  use {'dyng/ctrlsf.vim'}
  -- use {'junegunn/fzf','dir': '~/.fzf', 'do': './install --all' }
  use {'junegunn/fzf.vim'}
  use {'jlanzarotta/bufexplorer'}
  use {'itchyny/lightline.vim'}
  use {'pearofducks/ansible-vim'}
  use {'stephpy/vim-yaml'}
  use {'kdheepak/lazygit.nvim'}
  use {'tpope/vim-fugitive'}
  use {'tpope/vim-surround'}
  use {'tpope/vim-repeat'}
  use {'ntpeters/vim-better-whitespace'}
  use {'RRethy/vim-illuminate'}
  use {'patstockwell/vim-monokai-tasty'}
  use {'tomasiser/vim-code-dark'}
  use {'Yilin-Yang/vim-markbar'}
  use {'SirVer/ultisnips'}
  use {'honza/vim-snippets'}
  use {'vim-scripts/taglist.vim'}
  use {'michaeljsmith/vim-indent-object'}
  use {'rhysd/vim-textobj-anyblock'}
  use {'kana/vim-textobj-user'}
  use {'bps/vim-textobj-python'}
  use {'thinca/vim-textobj-between'}
  use {'vim-scripts/ReplaceWithRegister'}
  use {'kana/vim-textobj-line'}
  use {'tpope/vim-commentary'}
  use {'tpope/vim-unimpaired'}
  use {'gaving/vim-textobj-argument'}
  use {'vim-test/vim-test'}
  use {'tpope/vim-dispatch'}
  -- stackmap, for switch mappings in quickfix window
  use { 'tjdevries/stackmap.nvim' }

  -- Debugger
  use { 'puremourning/vimspector' }
  -- use { 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}}
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

---
-- Basic config setup
---

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

-- Standard Vim configuration boilerplate
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")
vim.opt.encoding = "utf-8"
vim.opt.number = true
vim.opt.relativenumber = true

-- finding files
vim.cmd("set path+=**")
vim.opt.wildmenu = true

-- To install language servers, manually run:
--   :call InstallCocPlugins()

-- function InstallCocPlugins()
--   CocInstall coc-pyright
--   source ~/.vim/myscripts/coc-settings.vim
-- endfunction
-- command! InstallCocPlugins execute ":call InstallCocPlugins()"

-- Get rid of pesky q:s
vim.opt.guicursor = ""

-- Workaround some broken plugins which set guicursor indiscriminately.
-- autocmd OptionSet guicursor noautocmd set guicursor=

-- https://github.com/neoclide/coc.nvim/issues/3312
-- autocmd VimLeavePre * if get(g:, 'coc_process_pid', 0)
--   \	| call system('kill -9 '.g:coc_process_pid) | endif

-- Make OS X play nicely with Vim
-- (Doesn't seem to work)
vim.opt.clipboard = "unnamed"

-- http://damien.lespiau.name/blog/2009/03/18/per-project-vimrc/comment-page-1/
-- set exrc " enable per-directory .vimrc files
vim.opt.secure = true --disable unsafe commands in local .vimrc files
