let mapleader = " "

set mouse=a
set mousemoveevent
set number
set relativenumber
set smarttab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set updatetime=300

" Системный буфер обмена
set clipboard+=unnamedplus

" Умный поиск
set ignorecase
set smartcase
set incsearch
set hlsearch
nnoremap <silent> <Esc> :nohlsearch<CR>

" NERDTree команды (через Пробел)
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
" Для русской раскладки
nnoremap <leader>в :NERDTreeToggle<CR>
nnoremap <leader>т :NERDTreeFocus<CR>

" Навигация в стиле Yazi внутри дерева NERDTree (h - назад/закрыть, l - открыть)
function! s:nerd_h()
  let l:node = g:NERDTreeFileNode.GetSelected()
  if empty(l:node)
    call nerdtree#ui_glue#upDir(0)
    return
  endif
  if l:node.path.isDirectory && l:node.isOpen
    call l:node.close()
    call b:NERDTree.render()
    call l:node.putCursorHere(0, 0)
  elseif !empty(l:node.parent) && !l:node.parent.isRoot()
    call l:node.parent.close()
    call b:NERDTree.render()
    call l:node.parent.putCursorHere(0, 0)
  else
    call nerdtree#ui_glue#upDir(0)
  endif
endfunction

function! s:nerd_l()
  call nerdtree#ui_glue#invokeKeyMap(g:NERDTreeMapActivateNode)
endfunction

augroup NERDTreeYaziNav
  autocmd!
  autocmd FileType nerdtree nnoremap <buffer> <silent> h :call <SID>nerd_h()<CR>
  autocmd FileType nerdtree nnoremap <buffer> <silent> р :call <SID>nerd_h()<CR>
  autocmd FileType nerdtree nnoremap <buffer> <silent> l :call <SID>nerd_l()<CR>
  autocmd FileType nerdtree nnoremap <buffer> <silent> д :call <SID>nerd_l()<CR>
  autocmd FileType nerdtree nnoremap <buffer> <silent> 0 :NERDTreeCWD<CR>
  autocmd FileType nerdtree nnoremap <buffer> <silent> ~ :NERDTreeCWD<CR>
  autocmd FileType nerdtree nnoremap <buffer> <silent> Ё :NERDTreeCWD<CR>
augroup END

" Перемещение по окнам (слева / справа / снизу / сверху) через Пробел + навигация
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k

" Перемещение по окнам через Пробел + стрелочки
nnoremap <leader><Left> <C-w>h
nnoremap <leader><Right> <C-w>l
nnoremap <leader><Down> <C-w>j
nnoremap <leader><Up> <C-w>k

" Дублирование для русской раскладки
nnoremap <leader>р <C-w>h
nnoremap <leader>д <C-w>l
nnoremap <leader>о <C-w>j
nnoremap <leader>л <C-w>k

" Разделение окон: Пробел + [ (слева), Пробел + ] (справа)
nnoremap <leader>[ :leftabove vsplit<CR>
nnoremap <leader>] :rightbelow vsplit<CR>
nnoremap <leader>х :leftabove vsplit<CR>
nnoremap <leader>ъ :rightbelow vsplit<CR>

" Закрытие окна: Пробел + q
nnoremap <leader>q :close<CR>
nnoremap <leader>й :close<CR>

" Комментирование строк и блоков (Ctrl + / и русская раскладка псс / пс)
nmap <C-/> gcc
xmap <C-/> gc
nmap <C-_> gcc
xmap <C-_> gc
nmap псс gcc
xmap пс gc

" Ctrl + клик мыши — переход к функции/классу/импорту (как в PyCharm / VS Code)
nnoremap <C-LeftMouse> <LeftMouse><Cmd>lua vim.lsp.buf.definition()<CR>
inoremap <C-LeftMouse> <Esc><LeftMouse><Cmd>lua vim.lsp.buf.definition()<CR>

" Ctrl + Enter — переход к функции/классу/импорту с клавиатуры (в Normal и Insert режимах)
nnoremap <C-CR> <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <C-Enter> <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <C-Return> <Cmd>lua vim.lsp.buf.definition()<CR>
inoremap <C-CR> <Esc><Cmd>lua vim.lsp.buf.definition()<CR>
inoremap <C-Enter> <Esc><Cmd>lua vim.lsp.buf.definition()<CR>
inoremap <C-Return> <Esc><Cmd>lua vim.lsp.buf.definition()<CR>

" Боковые кнопки мыши: Назад / Вперёд по истории переходов
nnoremap <X1Mouse> <C-o>
nnoremap <X2Mouse> <C-i>
inoremap <X1Mouse> <Esc><C-o>
inoremap <X2Mouse> <Esc><C-i>

" Выход из Insert mode на jj и оо
inoremap jj <Esc>
inoremap оо <Esc>

" Отступы в Visual mode через Tab и Shift-Tab (с сохранением выделения)
xnoremap <Tab> >gv
xnoremap <S-Tab> <gv
xnoremap > >gv
xnoremap < <gv

" Поддержка русской раскладки в Normal mode
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz,Ж;:,ж;\;,э;',х;[,ъ;],Х;{,Ъ;}

" Быстрые команды сохранения/выхода на русской раскладке
cnoreabbrev ц w
cnoreabbrev й q
cnoreabbrev цй wq
cnoreabbrev йц wq
cnoreabbrev ц! w!
cnoreabbrev й! q!

call plug#begin()
" Внешний вид и темы
Plug 'navarasu/onedark.nvim'
Plug 'vim-airline/vim-airline' 
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

" Подсветка синтаксиса
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Поиск файлов и текста (Telescope)
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" LSP & Mason
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

" Автодополнение
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Файловый менеджер Yazi
Plug 'mikavilpas/yazi.nvim'

" Всплывающий терминал
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

" Автозакрытие скобок и кавычек
Plug 'windwp/nvim-autopairs'

" Окружение скобками и кавычками (Surround)
Plug 'kylechui/nvim-surround'

" Git изменения в реальном времени
Plug 'lewis6991/gitsigns.nvim'

" Быстрые прыжки по экрану
Plug 'folke/flash.nvim'

" Подсветка цветов (HEX/RGB)
Plug 'NvChad/nvim-colorizer.lua'

" Подсказки параметров функций (Signature Help)
Plug 'ray-x/lsp_signature.nvim'
call plug#end()

set rtp+=~/.local/share/nvim/plugged/nvim-treesitter/runtime
syntax on
set termguicolors
set background=dark
colorscheme onedark

let g:airline_theme = 'onedark'
let g:airline_powerline_fonts = 1

" Верхняя панель открытых файлов (Tabline)
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Переключение и закрытие вкладок (открытых файлов)
nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprevious<CR>
nnoremap <leader>w :bdelete<CR>
nnoremap <leader>ц :bdelete<CR>

" Telescope горячие клавиши
nnoremap <C-p> :Telescope find_files<CR>
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fh :Telescope help_tags<CR>
" Поиск файлов по всей домашней директории
nnoremap <leader>fa :Telescope find_files prompt_title=Home\ Search cwd=~<CR>

" Yazi файловый менеджер (Пробел + y)
nnoremap <leader>y :Yazi<CR>
nnoremap <leader>yw :Yazi cwd<CR>

" Всплывающие терминалы 1-9 (Пробел + 1 .. Пробел + 9)
nnoremap <silent> <leader>1 :1ToggleTerm<CR>
nnoremap <silent> <leader>2 :2ToggleTerm<CR>
nnoremap <silent> <leader>3 :3ToggleTerm<CR>
nnoremap <silent> <leader>4 :4ToggleTerm<CR>
nnoremap <silent> <leader>5 :5ToggleTerm<CR>
nnoremap <silent> <leader>6 :6ToggleTerm<CR>
nnoremap <silent> <leader>7 :7ToggleTerm<CR>
nnoremap <silent> <leader>8 :8ToggleTerm<CR>
nnoremap <silent> <leader>9 :9ToggleTerm<CR>
nnoremap <leader>t :ToggleTerm<CR>

" Внутри терминала: Alt + 1..9 для переключения между терминалами
tnoremap <silent> <M-1> <Cmd>1ToggleTerm<CR>
tnoremap <silent> <M-2> <Cmd>2ToggleTerm<CR>
tnoremap <silent> <M-3> <Cmd>3ToggleTerm<CR>
tnoremap <silent> <M-4> <Cmd>4ToggleTerm<CR>
tnoremap <silent> <M-5> <Cmd>5ToggleTerm<CR>
tnoremap <silent> <M-6> <Cmd>6ToggleTerm<CR>
tnoremap <silent> <M-7> <Cmd>7ToggleTerm<CR>
tnoremap <silent> <M-8> <Cmd>8ToggleTerm<CR>
tnoremap <silent> <M-9> <Cmd>9ToggleTerm<CR>

nnoremap <silent> <C-\> :ToggleTerm<CR>
tnoremap <silent> <C-\> <C-\><C-n>:ToggleTerm<CR>

" Личная шпаргалка по конфигу (:dock или Пробел + ?)
command! Dock vsplit ~/.config/nvim/cheatsheet.md
cnoreabbrev dock Dock
cnoreabbrev Dock Dock
cnoreabbrev вщсл Dock
cnoreabbrev док Dock
cnoreabbrev доск Dock
nnoremap <leader>? :Dock<CR>

" Документация по чистому Vim (:vimdock)
command! Vimdock vsplit ~/.config/nvim/vimdoc.md
cnoreabbrev vimdock Vimdock
cnoreabbrev Vimdock Vimdock
cnoreabbrev vimdoc Vimdock
cnoreabbrev Vimdoc Vimdock
cnoreabbrev мшьвщсл Vimdock
cnoreabbrev мшьвщс Vimdock
cnoreabbrev вимдок Vimdock
cnoreabbrev вимдоск Vimdock

lua << EOF
-- Безопасная инициализация плагинов после их установки
-- Добавляем директорию запросов Treesitter в runtimepath
vim.opt.rtp:append(vim.fn.expand('~/.local/share/nvim/plugged/nvim-treesitter/runtime'))

-- Настройка OneDark с насыщенными цветами для кода
local ok_onedark, onedark = pcall(require, 'onedark')
if ok_onedark then
  onedark.setup {
    style = 'dark',
    transparent = false,
    code_style = {
      comments = 'italic',
      keywords = 'bold',
      functions = 'none',
      strings = 'none',
      variables = 'none'
    },
  }
  onedark.load()
end

-- Treesitter подсветка синтаксиса
local ok_ts, ts = pcall(require, 'nvim-treesitter')
if ok_ts and ts.setup then
  ts.setup()
  pcall(function() ts.install({ "solidity", "javascript", "typescript", "tsx", "python", "json", "html", "css", "lua", "vim", "vimdoc", "bash", "markdown" }) end)
end

-- Включение Treesitter подсветки для поддерживаемых языков
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'solidity', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'python', 'json', 'html', 'css', 'lua', 'vim', 'bash', 'sh', 'yaml', 'markdown' },
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

local ok_telescope, telescope = pcall(require, 'telescope')
if ok_telescope then
  telescope.setup({
    defaults = {
      file_ignore_patterns = { "node_modules", "%.git/" }
    }
  })
end

-- Yazi setup
local ok_yazi, yazi = pcall(require, 'yazi')
if ok_yazi then
  yazi.setup({
    open_for_directories = false,
  })
end

-- ToggleTerm setup
local ok_toggleterm, toggleterm = pcall(require, 'toggleterm')
if ok_toggleterm then
  toggleterm.setup({
    open_mapping = [[<c-\>]],
    direction = 'float',
    float_opts = {
      border = 'curved',
    },
    winbar = {
      enabled = true,
      name_formatter = function(term)
        return " 💻 Terminal #" .. term.count .. " "
      end
    },
  })
end

local ok_mason, mason = pcall(require, 'mason')
local ok_mason_lsp, mason_lspconfig = pcall(require, 'mason-lspconfig')
if ok_mason and ok_mason_lsp then
  mason.setup()
  mason_lspconfig.setup({
    ensure_installed = { "pyright" },
    automatic_installation = true,
  })
end

local ok_cmp, cmp = pcall(require, 'cmp')
local ok_luasnip, luasnip = pcall(require, 'luasnip')
if ok_cmp and ok_luasnip then
  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
      { name = 'path' },
    })
  })
end

-- Подсветка символа при наведении мышью с зажатым Ctrl, если для него есть определение
local ns_def_hl = vim.api.nvim_create_namespace('lsp_goto_definition')
vim.api.nvim_set_hl(0, 'LspGotoDefinition', { underline = true, sp = '#61afef', bold = true })

local current_highlighted_buf = nil
local last_word_info = nil

local function clear_mouse_highlight()
  if current_highlighted_buf and vim.api.nvim_buf_is_valid(current_highlighted_buf) then
    vim.api.nvim_buf_clear_namespace(current_highlighted_buf, ns_def_hl, 0, -1)
  end
  current_highlighted_buf = nil
  last_word_info = nil
end

local function on_ctrl_mouse_move()
  local mouse = vim.fn.getmousepos()
  if mouse.winid <= 0 or not vim.api.nvim_win_is_valid(mouse.winid) or mouse.line <= 0 or mouse.column <= 0 then
    clear_mouse_highlight()
    return
  end

  local bufnr = vim.api.nvim_win_get_buf(mouse.winid)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  local has_def = false
  for _, c in ipairs(clients) do
    if c.server_capabilities and c.server_capabilities.definitionProvider then
      has_def = true
      break
    end
  end
  if not has_def then
    clear_mouse_highlight()
    return
  end

  local line_str = vim.api.nvim_buf_get_lines(bufnr, mouse.line - 1, mouse.line, false)[1] or ''
  local c_1 = mouse.column
  if not line_str:sub(c_1, c_1):match('[%w_]') then
    clear_mouse_highlight()
    return
  end

  local s = c_1
  while s > 1 and line_str:sub(s - 1, s - 1):match('[%w_]') do s = s - 1 end
  local e = c_1
  while e <= #line_str and line_str:sub(e, e):match('[%w_]') do e = e + 1 end

  if last_word_info and last_word_info.bufnr == bufnr and last_word_info.line == mouse.line and last_word_info.s == s and last_word_info.e == e then
    return
  end

  last_word_info = { bufnr = bufnr, line = mouse.line, s = s, e = e }

  local params = {
    textDocument = vim.lsp.util.make_text_document_params(bufnr),
    position = {
      line = mouse.line - 1,
      character = mouse.column - 1,
    },
  }

  vim.lsp.buf_request(bufnr, 'textDocument/definition', params, function(err, result)
    if not vim.api.nvim_buf_is_valid(bufnr) then return end
    if not last_word_info or last_word_info.bufnr ~= bufnr or last_word_info.line ~= mouse.line or last_word_info.s ~= s or last_word_info.e ~= e then
      return
    end

    if current_highlighted_buf and vim.api.nvim_buf_is_valid(current_highlighted_buf) then
      vim.api.nvim_buf_clear_namespace(current_highlighted_buf, ns_def_hl, 0, -1)
    end

    if result and not vim.tbl_isempty(result) then
      current_highlighted_buf = bufnr
      vim.api.nvim_buf_set_extmark(bufnr, ns_def_hl, mouse.line - 1, s - 1, {
        end_col = e - 1,
        hl_group = 'LspGotoDefinition',
        priority = 200,
      })
    else
      current_highlighted_buf = nil
    end
  end)
end

local function on_mouse_move()
  if current_highlighted_buf or last_word_info then
    clear_mouse_highlight()
  end
end

vim.keymap.set({ 'n', 'i', 'v' }, '<C-MouseMove>', on_ctrl_mouse_move, { silent = true })
vim.keymap.set({ 'n', 'i', 'v' }, '<MouseMove>', on_mouse_move, { silent = true })

-- Очистка подсветки при переключении буфера, вводе текста или перемещении курсора
vim.api.nvim_create_autocmd({ 'BufLeave', 'InsertEnter', 'CursorMoved', 'CursorMovedI' }, {
  callback = function()
    if current_highlighted_buf then
      clear_mouse_highlight()
    end
  end,
})

-- LSP Настройки и горячие клавиши
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local bufopts = { noremap = true, silent = true, buffer = ev.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)

    -- Подсказки параметров функций на лету (Signature Help)
    local ok_sig, lsp_signature = pcall(require, 'lsp_signature')
    if ok_sig then
      lsp_signature.on_attach({
        bind = true,
        floating_window = true,
        hint_enable = true,
        hint_prefix = "📌 ",
        handler_opts = { border = "rounded" },
      }, ev.buf)
    end
  end,
})

local ok_cmp_lsp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok_cmp_lsp and vim.lsp.config then
  vim.lsp.config('*', {
    capabilities = cmp_nvim_lsp.default_capabilities(),
  })
end

-- Автоматическое обнаружение и подключение виртуального окружения Python (.venv, venv, .env, env и др.)
local function find_python_path(workspace)
  -- 1. Если переменная VIRTUAL_ENV уже задана в системе/терминале
  if vim.env.VIRTUAL_ENV then
    local venv_py = vim.fn.has('win32') == 1
      and (vim.env.VIRTUAL_ENV .. '\\Scripts\\python.exe')
      or (vim.env.VIRTUAL_ENV .. '/bin/python')
    if vim.fn.executable(venv_py) == 1 then
      return venv_py, vim.env.VIRTUAL_ENV
    end
  end

  -- 2. Ищем директорию виртуального окружения в проекте или вышестоящих папках
  local search_start = workspace
  if not search_start or search_start == '' then
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname ~= '' then
      search_start = vim.fs.dirname(bufname)
    else
      search_start = vim.fn.getcwd()
    end
  end

  local venv_names = { '.venv', 'venv', '.env', 'env', '.vevn', '.virtualenv', 'virtualenv' }
  local matches = vim.fs.find(venv_names, { path = search_start, upward = true, type = 'directory' })
  for _, match in ipairs(matches) do
    local candidates = vim.fn.has('win32') == 1
      and { match .. '\\Scripts\\python.exe', match .. '/Scripts/python.exe' }
      or { match .. '/bin/python', match .. '/bin/python3' }

    for _, py in ipairs(candidates) do
      if vim.fn.executable(py) == 1 then
        return py, match
      end
    end
  end

  return nil, nil
end

local function sync_venv_env(venv_dir)
  if venv_dir and vim.env.VIRTUAL_ENV ~= venv_dir then
    vim.env.VIRTUAL_ENV = venv_dir
    local bin_dir = vim.fn.has('win32') == 1 and (venv_dir .. '\\Scripts') or (venv_dir .. '/bin')
    local sep = vim.fn.has('win32') == 1 and ';' or ':'
    if not string.find(vim.env.PATH or '', bin_dir, 1, true) then
      vim.env.PATH = bin_dir .. sep .. (vim.env.PATH or '')
    end
  end
end

if vim.lsp.config then
  vim.lsp.config('pyright', {
    root_markers = { '.venv', 'venv', '.env', 'env', '.vevn', '.virtualenv', 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
    before_init = function(params, config)
      local python_path, venv_dir = find_python_path(config.root_dir)
      if python_path then
        config.settings = config.settings or {}
        config.settings.python = config.settings.python or {}
        config.settings.python.pythonPath = python_path
        if venv_dir then
          config.settings.python.venvPath = vim.fs.dirname(venv_dir)
          config.settings.python.venv = vim.fs.basename(venv_dir)
        end
        config.settings.python.analysis = config.settings.python.analysis or {}
        config.settings.python.analysis.autoSearchPaths = true
        config.settings.python.analysis.useLibraryCodeForTypes = true
        sync_venv_env(venv_dir)
      end
    end,
  })
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function(args)
    local _, venv_dir = find_python_path(vim.fs.dirname(vim.api.nvim_buf_get_name(args.buf)))
    sync_venv_env(venv_dir)
  end,
})

if vim.lsp.enable then
  vim.lsp.enable('pyright')
end

-- Autopairs (автозакрытие скобок)
local ok_autopairs, autopairs = pcall(require, 'nvim-autopairs')
if ok_autopairs then
  autopairs.setup({})
  local ok_cmp_autopairs, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
  local ok_cmp, cmp = pcall(require, 'cmp')
  if ok_cmp and ok_cmp_autopairs then
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end
end

-- Surround (магия со скобками и кавычками)
local ok_surround, surround = pcall(require, 'nvim-surround')
if ok_surround then
  surround.setup({})
end

-- Gitsigns (Git в реальном времени)
local ok_gitsigns, gitsigns = pcall(require, 'gitsigns')
if ok_gitsigns then
  gitsigns.setup({
    signs = {
      add          = { text = '┃' },
      change       = { text = '┃' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end
      map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, {expr=true, desc='Next Git Hunk'})
      map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, {expr=true, desc='Prev Git Hunk'})
      map('n', '<leader>hp', gs.preview_hunk, {desc='Preview Git Hunk'})
      map('n', '<leader>hr', gs.reset_hunk, {desc='Reset Git Hunk'})
      map('n', '<leader>hb', function() gs.blame_line{full=true} end, {desc='Blame Line'})
    end
  })
end

-- Flash (мгновенные прыжки по экрану)
local ok_flash, flash = pcall(require, 'flash')
if ok_flash then
  flash.setup({})
  vim.keymap.set({ "n", "x", "o" }, "s", function() flash.jump() end, { desc = "Flash Jump" })
  vim.keymap.set({ "n", "x", "o" }, "S", function() flash.treesitter() end, { desc = "Flash Treesitter" })
  vim.keymap.set({ "n", "x", "o" }, "ы", function() flash.jump() end, { desc = "Flash Jump (RU)" })
  vim.keymap.set({ "n", "x", "o" }, "Ы", function() flash.treesitter() end, { desc = "Flash Treesitter (RU)" })
end

-- Colorizer (подсветка цветов в коде)
local ok_colorizer, colorizer = pcall(require, 'colorizer')
if ok_colorizer then
  colorizer.setup()
end
EOF
