require("lsp")
require("keymaps")


local colors = {
    black      = "#000000",
    white      = "#ffffff",
    light_gray = "#222222",
    gray       = "#555555",
}

-- vim.cmd("colorscheme monochrome")

local opt = vim.opt
opt.clipboard = "unnamedplus"
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = false
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true
opt.mouse = "a"
opt.wrap = false
opt.updatetime = 250
opt.timeoutlen = 400
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Plugins --

local gh = function(x) return 'https://github.com/' .. x end
vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })
vim.pack.add({ gh('stevearc/oil.nvim') })
vim.pack.add({ gh('williamboman/mason.nvim') })
vim.pack.add({ gh('williamboman/mason-lspconfig.nvim') })
vim.pack.add({ gh('kdheepak/lazygit.nvim') })
vim.pack.add({ gh('nvim-lua/plenary.nvim') })
vim.pack.add({ gh('lewis6991/gitsigns.nvim') })
vim.pack.add({ gh('nvim-flutter/flutter-tools.nvim') })
vim.pack.add({ gh('stevearc/dressing.nvim') })
vim.pack.add({ gh('b0o/incline.nvim') })
vim.pack.add({ gh('saghen/blink.cmp') })
vim.pack.add({ gh('nvim-lualine/lualine.nvim') })
vim.pack.add({ gh('nvim-tree/nvim-web-devicons') })
vim.pack.add({ gh('rmagatti/auto-session') })
vim.pack.add({ gh('kylechui/nvim-surround') })
vim.pack.add({ gh('echasnovski/mini.pairs') })
vim.pack.add({ gh('akinsho/toggleterm.nvim') })
vim.pack.add({ gh('nvim-telescope/telescope.nvim') })
vim.pack.add({ gh('folke/todo-comments.nvim') })
vim.pack.add({ gh('folke/noice.nvim') })
vim.pack.add({ gh('MunifTanjim/nui.nvim') })
vim.pack.add({ gh('rcarriga/nvim-notify') })
vim.pack.add({ gh('folke/trouble.nvim') })
vim.pack.add({ gh('goolord/alpha-nvim') })



require('trouble').setup()

require('notify').setup({
    background_colour = "#000000",
    render            = "minimal",
    stages            = "static",
    timeout           = 2500,
    top_down          = false,
})

require('noice').setup({
    presets = { lsp_doc_border = true },
    notify  = { enabled = true },
    cmdline = {
        view   = "cmdline",
        format = {
            search_down = { view = "cmdline" },
            search_up   = { view = "cmdline" },
        },
    },
    routes  = {
        {
            filter = {
                event = "msg_show",
                any   = {
                    { find = "written" },
                    { find = "yanked" },
                    { find = "change" },
                    { find = "line" },
                },
            },
            opts = { skip = true },
        },
    },
})

require('telescope').setup({
    defaults = {
        prompt_prefix    = "  ",
        selection_caret  = " ",
        sorting_strategy = "ascending",
        layout_strategy  = "horizontal",
        layout_config    = {
            prompt_position = "top",
            preview_width   = 0.55,
            width           = 0.87,
            height          = 0.80,
        },
        border           = true,
        borderchars      = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        winblend         = 0,
        color_devicons   = false,
    },
})

require('todo-comments').setup()

vim.cmd("highlight TelescopeNormal          guibg=#000000 guifg=#ffffff")
vim.cmd("highlight TelescopeBorder          guibg=#000000 guifg=#555555")
vim.cmd("highlight TelescopePromptNormal    guibg=#111111 guifg=#ffffff")
vim.cmd("highlight TelescopePromptBorder    guibg=#111111 guifg=#555555")
vim.cmd("highlight TelescopePromptTitle     guibg=#555555 guifg=#000000")
vim.cmd("highlight TelescopePreviewTitle    guibg=#000000 guifg=#555555")
vim.cmd("highlight TelescopeResultsTitle    guibg=#000000 guifg=#000000")
vim.cmd("highlight TelescopeSelection       guibg=#222222 guifg=#ffffff")
vim.cmd("highlight TelescopeMatching        guifg=#ffffff gui=bold")

require('toggleterm').setup({
    size = 15,
    open_mapping = [[<c-\>]],
    direction = 'horizontal',
    shade_terminals = false,
})

require("mini.pairs").setup()

require("auto-session").setup({
    auto_restore_enabled = false,
    auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
})

require('lualine').setup({
    options = {
        theme = {
            normal   = { a = { bg = colors.white, fg = colors.black, gui = "bold" }, b = { bg = colors.light_gray, fg = colors.black }, c = { bg = colors.black, fg = colors.white } },
            insert   = { a = { bg = colors.light_gray, fg = colors.black, gui = "bold" }, b = { bg = colors.light_gray, fg = colors.black }, c = { bg = colors.black, fg = colors.white } },
            visual   = { a = { bg = colors.gray, fg = colors.white, gui = "bold" }, b = { bg = colors.light_gray, fg = colors.black }, c = { bg = colors.black, fg = colors.white } },
            command  = { a = { bg = colors.gray, fg = colors.white, gui = "bold" }, b = { bg = colors.light_gray, fg = colors.black }, c = { bg = colors.black, fg = colors.white } },
            replace  = { a = { bg = colors.black, fg = colors.white, gui = "bold" }, b = { bg = colors.light_gray, fg = colors.black }, c = { bg = colors.black, fg = colors.white } },
            inactive = { a = { bg = colors.black, fg = colors.gray, gui = "bold" }, b = { bg = colors.black, fg = colors.gray }, c = { bg = colors.black, fg = colors.gray } },
        },
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        -- section_separators = '',
        -- component_separators = '│',
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { {
            'branch',
            color = { fg = colors.white, bg = colors.light_gray },
        }, 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
    inactive_sections = {
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
    },
})

require('blink.cmp').setup({
    keymap = {
        preset        = "none",
        ["<Tab>"]     = { "select_next", "fallback" },
        ["<S-Tab>"]   = { "select_prev", "fallback" },
        ["<CR>"]      = { "accept", "fallback" },
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"]     = { "hide" },
    },
    sources = {
        default = { "lsp", "path", "buffer" },
    },
    fuzzy = { implementation = "lua" },
})

require('incline').setup({
    highlight = {
        groups = {
            InclineNormal = {
                guifg = colors.black,
                guibg = colors.white,
            },
            InclineNormalNC = {
                guibg = "#d0d0d0",
                guifg = colors.black,
            },
        },
    },
    window = {
        margin = { vertical = 1, horizontal = 1 },
        padding = 1,
        placement = {
            horizontal = "right",
            vertical = "top",
        },
    },
    render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if vim.bo[props.buf].modified then
            filename = filename .. " ●"
        end
        return filename
    end,
})

require('flutter-tools').setup()

require("gitsigns").setup()

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'rust_analyzer', 'gopls', 'zls', 'ts_ls', 'clangd', 'html', 'cssls', 'svelte', 'pyright', 'jsonls', 'taplo', 'yamlls', 'bashls', 'dockerls', 'tailwindcss' },
    automatic_installation = true,
})

require("oil").setup({
    view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _)
            return name == ".." or name == ".git"
        end,
    },
})
require('nvim-treesitter').setup {
    install_dir = vim.fn.stdpath('data') .. '/site',
}

require('nvim-treesitter').install { 'rust', 'javascript', 'zig', 'lua', 'vimdoc', 'go', 'query', 'markdown', 'cpp', 'css', 'json', 'html', 'dockerfile', 'svelte', 'python' }


vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

local builtin = require('telescope.builtin')

local keymap = vim.keymap.set
keymap('n', '<leader>ff', builtin.find_files)
keymap('n', '<leader>fg', builtin.live_grep)
keymap('n', '<leader>fb', builtin.buffers)
keymap('n', '<leader>fh', builtin.help_tags)

vim.cmd("syntax off")
vim.cmd("highlight Normal guibg=#000000")
vim.cmd("highlight NormalNC guibg=#000000")
vim.cmd("highlight SignColumn guibg=#000000")

vim.cmd("highlight NotifyERRORBorder guifg=#555555 guibg=#000000")
vim.cmd("highlight NotifyERRORIcon   guifg=#ffffff")
vim.cmd("highlight NotifyERRORTitle  guifg=#ffffff")
vim.cmd("highlight NotifyERRORBody   guifg=#ffffff guibg=#000000")

vim.cmd("highlight NotifyWARNBorder  guifg=#555555 guibg=#000000")
vim.cmd("highlight NotifyWARNIcon    guifg=#ffffff")
vim.cmd("highlight NotifyWARNTitle   guifg=#ffffff")
vim.cmd("highlight NotifyWARNBody    guifg=#ffffff guibg=#000000")

vim.cmd("highlight NotifyINFOBorder  guifg=#555555 guibg=#000000")
vim.cmd("highlight NotifyINFOIcon    guifg=#ffffff")
vim.cmd("highlight NotifyINFOTitle   guifg=#ffffff")
vim.cmd("highlight NotifyINFOBody    guifg=#ffffff guibg=#000000")

vim.cmd("highlight NotifyDEBUGBorder guifg=#555555 guibg=#000000")
vim.cmd("highlight NotifyDEBUGIcon   guifg=#555555")
vim.cmd("highlight NotifyDEBUGTitle  guifg=#555555")
vim.cmd("highlight NotifyDEBUGBody   guifg=#555555 guibg=#000000")

vim.cmd("highlight NotifyTRACEBorder guifg=#555555 guibg=#000000")
vim.cmd("highlight NotifyTRACEIcon   guifg=#555555")
vim.cmd("highlight NotifyTRACETitle  guifg=#555555")
vim.cmd("highlight NotifyTRACEBody   guifg=#555555 guibg=#000000")


local alpha = require('alpha')
local dashboard = require('alpha.themes.startify')

local header = {
    type = "text",
    val = {
        [[    /^ ^\           ]],
        [[   / 0 0 \          ]],
        [[   V\ Y /V          ]],
        [[    / - \           ]],
        [[   /    |           ]],
        [[  V__) ||           ]],
        [[                    ]],
        [[  - G O O D BOY -   ]],
    },
    opts = {
        position = "center",
        hl = "Normal",
    },
}

-- local actions = {
--     type = "group",
--     val = {
--         {
--             type = "button",
--             val = "  New file",
--             on_press = function() vim.cmd("enew") end,
--             opts = { shortcut = "n", position = "center", hl = "Normal" },
--         },
--         {
--             type = "button",
--             val = "  Quit",
--             on_press = function() vim.cmd("qa") end,
--             opts = { shortcut = "q", position = "center", hl = "Normal" },
--         },
--     },
-- }

local layout = {
    { type = "padding", val = math.floor(vim.o.lines / 3) },
    header,
    { type = "padding", val = 2 },
    actions,
}

alpha.setup({ layout = layout, opts = {} })
