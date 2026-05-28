vim.g.mapleader = " "

local keymap = vim.keymap.set

keymap("n", "<leader>ch", "<cmd>Telescope git_commits<cr>")
local mono_active = false

keymap("n", "<leader>tm", function()
    if mono_active then
        vim.cmd("colorscheme default")
        vim.cmd("syntax off")
        vim.cmd("highlight Normal guibg=#000000")
        vim.cmd("highlight NormalNC guibg=#000000")
        vim.cmd("highlight SignColumn guibg=#000000")
        mono_active = false
    else
        vim.cmd("colorscheme monochrome")
        mono_active = true
    end
end)
keymap('n', '<leader>ft', '<cmd>TodoTelescope<CR>')
keymap('n', '<C-u>', '<C-u>zz')
keymap('n', '<C-d>', '<C-d>zz')
keymap("i", "jj", "<Esc>")
keymap('n', '<leader>rn', vim.lsp.buf.rename)
keymap('n', '<leader>b', function() print('real lua function') end)
keymap("n", "<leader>uw", ":set wrap!<CR>")
keymap('n', '<leader>pv', '<cmd>:Oil<cr>')
keymap('n', '<leader>R', '<cmd>:restart<cr>')
keymap("n", "<leader>tt", "<cmd>ToggleTerm direction=float<CR>")
keymap("n", "dw", '"_daw')
keymap("n", "<leader>to", "<cmd>tabnew<CR>")
keymap("n", "<leader>tx", "<cmd>tabclose<CR>")
keymap("n", "<leader>tn", "<cmd>tabn<CR>")
keymap("n", "<leader>tp", "<cmd>tabp<CR>")
keymap("n", "<leader>tf", "<cmd>tabnew %<CR>")
keymap('n', '<leader>q', '<cmd>:q<cr>')
keymap("n", "<C-a>", "ggVG")
keymap("n", "wr", ":vertical resize +5<CR>")
keymap("n", "wl", ":vertical resize -5<CR>")
keymap("n", "wk", ":resize +2<CR>")
keymap("n", "wj", ":resize -2<CR>")
keymap('n', 'sv', '<cmd>:vs<cr>')
keymap('n', 'ss', '<cmd>:sp<cr>')
keymap("n", "sh", "<C-w>h")
keymap("n", "sk", "<C-w>k")
keymap("n", "sj", "<C-w>j")
keymap("n", "sl", "<C-w>l")
keymap("n", "<leader>nh", ":nohl<CR>")
keymap('n', '<leader>lg', '<cmd>LazyGit<cr>')
keymap("n", "<leader>fR", "<cmd>FlutterRun<CR>")
keymap("n", "<leader>fr", "<cmd>FlutterReload<CR>")
keymap('n', '<leader>xd', "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")
keymap('n', '<leader>xw', "<cmd>Trouble diagnostics toggle<cr>")
keymap("n", "<leader>fq", "<cmd>FlutterQuit<CR>")
keymap("n", "<leader>wr", "<cmd>AutoSession restore<CR>")
keymap("n", "<leader>ws", "<cmd>AutoSession save<CR>")
keymap("n", "<leader>z", "za", { desc = "Toggle fold" })
keymap("n", "<leader>ts", function()
    if vim.b.ts_disabled then
        pcall(vim.treesitter.start)
        vim.b.ts_disabled = false
    else
        vim.treesitter.stop()
        vim.b.ts_disabled = true
    end
end)

-- img preview keybinds
keymap("n", "<leader>ti", function()
    local img = require("image")
    if img.is_enabled() then
        img.disable()
    else
        img.enable()
    end
end, { desc = "Toggle image.nvim" })

-- Terminal keymaps
keymap("n", "<leader>tv", "<cmd>vsplit | terminal<CR>", { desc = "Terminal in vertical split" })
keymap("n", "<leader>th", "<cmd>split | terminal<CR>", { desc = "Terminal in horizontal split" })
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.opt_local.modified = false
    end,
})


-- Keymaps for C/Cpp
-- Run without arguments
keymap("n", "<leader>r", function()
    local filetype = vim.bo.filetype

    if filetype == 'cpp' or filetype == 'c' then
        local root_dir = vim.fn.getcwd()
        local build_dir = root_dir .. '/build'

        if vim.fn.filereadable(root_dir .. '/CMakeLists.txt') == 1 then
            -- Read CMakeLists.txt to find executable name
            local cmake_content = vim.fn.readfile(root_dir .. '/CMakeLists.txt')
            local exec_name = nil

            for _, line in ipairs(cmake_content) do
                local match = line:match('add_executable%((%w+)')
                if match then
                    exec_name = match
                    break
                end
            end

            exec_name = exec_name or vim.fn.fnamemodify(root_dir, ':t')

            local cmake_commands = string.format(
                'mkdir -p %s && cd %s && cmake .. && cmake --build . && ./%s',
                build_dir,
                build_dir,
                exec_name
            )
            vim.cmd('terminal ' .. cmake_commands)
        else
            -- Fall back to single-file compilation
            local filename = vim.fn.expand('%')
            local output = '/tmp/' .. vim.fn.expand('%:t:r')

            if filetype == 'cpp' then
                vim.cmd('terminal g++ ' .. filename .. ' -o ' .. output .. ' && ' .. output)
            elseif filetype == 'c' then
                vim.cmd('terminal gcc ' .. filename .. ' -o ' .. output .. ' && ' .. output)
            end
        end
    else
        print('Not a C/C++ file')
    end
end, { desc = "Run C/C++ program or CMake project" })


-- Run with arguments
keymap("n", "<leader>rr", function()
    local filetype = vim.bo.filetype

    if filetype == 'cpp' or filetype == 'c' then
        local root_dir = vim.fn.getcwd()
        local build_dir = root_dir .. '/build'

        -- Prompt for arguments
        local args = vim.fn.input('Arguments: ')

        if vim.fn.filereadable(root_dir .. '/CMakeLists.txt') == 1 then
            -- Read CMakeLists.txt to find executable name
            local cmake_content = vim.fn.readfile(root_dir .. '/CMakeLists.txt')
            local exec_name = nil

            for _, line in ipairs(cmake_content) do
                local match = line:match('add_executable%((%w+)')
                if match then
                    exec_name = match
                    break
                end
            end

            exec_name = exec_name or vim.fn.fnamemodify(root_dir, ':t')

            local cmake_commands = string.format(
                'mkdir -p %s && cd %s && cmake .. && cmake --build . && ./%s %s',
                build_dir,
                build_dir,
                exec_name,
                args
            )
            vim.cmd('terminal ' .. cmake_commands)
        else
            -- Fall back to single-file compilation
            local filename = vim.fn.expand('%')
            local output = '/tmp/' .. vim.fn.expand('%:t:r')

            if filetype == 'cpp' then
                vim.cmd('terminal g++ ' .. filename .. ' -o ' .. output .. ' && ' .. output .. ' ' .. args)
            elseif filetype == 'c' then
                vim.cmd('terminal gcc ' .. filename .. ' -o ' .. output .. ' && ' .. output .. ' ' .. args)
            end
        end
    else
        print('Not a C/C++ file')
    end
end, { desc = "Run C/C++ program with arguments" })

-- Keymaps for Rust
-- Run without arguments
keymap("n", "<leader>rs", function()
    local filetype = vim.bo.filetype

    if filetype == 'rust' then
        local root_dir = vim.fn.getcwd()
        local cargo_toml = root_dir .. '/Cargo.toml'

        if vim.fn.filereadable(cargo_toml) == 1 then
            -- Cargo project: build and run
            vim.cmd('terminal cargo run')
        else
            -- Single file fallback via rustc
            local filename = vim.fn.expand('%')
            local output = '/tmp/' .. vim.fn.expand('%:t:r')
            vim.cmd('terminal rustc ' .. filename .. ' -o ' .. output .. ' && ' .. output)
        end
    else
        print('Not a Rust file')
    end
end, { desc = "Run Rust program or Cargo project" })

-- Run with arguments
keymap("n", "<leader>ra", function()
    local filetype = vim.bo.filetype

    if filetype == 'rust' then
        local root_dir = vim.fn.getcwd()
        local cargo_toml = root_dir .. '/Cargo.toml'

        local args = vim.fn.input('Arguments: ')

        if vim.fn.filereadable(cargo_toml) == 1 then
            -- Cargo project: pass args after '--'
            vim.cmd('terminal cargo run -- ' .. args)
        else
            -- Single file fallback via rustc
            local filename = vim.fn.expand('%')
            local output = '/tmp/' .. vim.fn.expand('%:t:r')
            vim.cmd('terminal rustc ' .. filename .. ' -o ' .. output .. ' && ' .. output .. ' ' .. args)
        end
    else
        print('Not a Rust file')
    end
end, { desc = "Run Rust program with arguments" })
