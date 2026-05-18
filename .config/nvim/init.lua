-- Устанавливаем клавишу-лидер на Пробел (очень удобно)
vim.g.mapleader = " "

-- 1. АВТОУСТАНОВКА МЕНЕДЖЕРА ПЛАГИНОВ (Lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 2. БАЗОВЫЕ НАСТРОЙКИ (Олдскул и удобство)
vim.opt.number = true             -- Включаем нумерацию строк
vim.opt.relativenumber = true     -- Относительные номера (удобно для прыжков по коду)
vim.opt.mouse = "a"               -- Поддержка мыши (если вдруг захочется)
vim.opt.clipboard = "unnamedplus" -- Общий буфер обмена с системой
vim.opt.tabstop = 4               -- Табы по 4 пробела
vim.opt.shiftwidth = 4
vim.opt.expandtab = true          -- Превращаем табы в пробелы
vim.opt.termguicolors = true      -- Полноценные цвета в терминале
vim.opt.scrolloff = 8             -- Оставлять 8 строк снизу/сверху при скролле

-- 3. ПЛАГИНЫ
require("lazy").setup({
  -- Цветовая схема: матовый Gruvbox
  { "ellisonleao/gruvbox.nvim", priority = 1000 },

  -- Файловое дерево (открывается на Пробел + e)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30, side = "left" },
        renderer = { group_empty = true },
      })
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    end
  },

  -- Умная подсветка кода (Treesitter)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Базовый набор языков для установки
        ensure_installed = { "lua", "python", "javascript", "typescript", "json", "yaml", "bash" },
        highlight = { enable = true },
      })
    end
  },

  -- Поиск файлов и текста (открывается на Пробел + ff или Пробел + fg)
  {
    "nvim-telescope/telescope.nvim", tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    end
  },

  -- Автокомплит и LSP (подсказки для кода)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",         -- Само окно автокомплита
      "hrsh7th/cmp-nvim-lsp",     -- Связь с LSP
      "L3MON4D3/LuaSnip",         -- Поддержка сниппетов
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp = require("cmp")

      cmp.setup({
        snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Enter для вставки
        }),
        sources = cmp.config.sources({ { name = 'nvim_lsp' } })
      })

      -- Активация языковых серверов
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      lspconfig.pyright.setup({ capabilities = capabilities }) -- Для Python
      lspconfig.ts_ls.setup({ capabilities = capabilities })   -- Для JS/TS
    end
  }
})

-- 4. ПРИМЕНЕНИЕ ТЕМЫ
vim.cmd([[colorscheme gruvbox]])
