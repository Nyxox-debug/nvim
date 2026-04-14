local lsp = vim.lsp

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local buf = args.buf
    local k = function(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, { buffer = buf }) end

    k('n', 'gd',         lsp.buf.definition)
    k('n', 'gD',         lsp.buf.declaration)
    k('n', 'gr',         lsp.buf.references)
    k('n', 'gi',         lsp.buf.implementation)
    k('n', 'K',          lsp.buf.hover)
    k('n', '<leader>rn', lsp.buf.rename)
    k('n', '<leader>ca', lsp.buf.code_action)
    k('n', '<leader>f',  function() lsp.buf.format({ async = true }) end)
  end,
})

local function start(server, config)
  vim.api.nvim_create_autocmd('FileType', {
    pattern = config.filetypes,
    callback = function()
      vim.lsp.start(vim.tbl_extend('keep', config, {
        name = server,
        root_dir = vim.fs.root(0, config.root_markers or { '.git' }),
      }))
    end,
  })
end

start('rust-analyzer', {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml' },
})

start('lua-language-server', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.git' },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file('', true),
      },
      diagnostics = { globals = { 'vim' } },
    },
  },
})

start('gopls', {
  cmd = { 'gopls' },
  filetypes = { 'go' },
  root_markers = { 'go.mod', '.git' },
})

start('zls', {
  cmd = { 'zls' },
  filetypes = { 'zig' },
  root_markers = { 'build.zig', '.git' },
})

start('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  root_markers = { 'package.json', 'tsconfig.json', '.git' },
})
