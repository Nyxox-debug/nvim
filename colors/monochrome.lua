vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "monochrome"
vim.o.background = "dark"

local c = {
  bg        = "#000000",
  fg        = "#e8e8e8",
  dim1      = "#c0c0c0",
  dim2      = "#909090",
  dim3      = "#606060",
  dim4      = "#484848",
  dim5      = "#303030",
  accent    = "#ffffff",
  selection = "#1e1e1e",
  border    = "#404040",
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ── Editor UI
hi("Normal",        { fg = c.fg,     bg = c.bg })
hi("NormalFloat",   { fg = c.fg,     bg = "#111111" })
hi("Cursor",        { fg = c.bg,     bg = c.accent })
hi("CursorLine",    { bg = "#141414" })
hi("CursorLineNr",  { fg = c.dim1,   bold = true })
hi("LineNr",        { fg = c.dim5 })
hi("SignColumn",    { fg = c.dim5,   bg = c.bg })
hi("ColorColumn",   { bg = "#141414" })
hi("VertSplit",     { fg = c.border, bg = c.bg })
hi("StatusLine",    { fg = c.fg,     bg = "#181818" })
hi("StatusLineNC",  { fg = c.dim3,   bg = "#111111" })
hi("Pmenu",         { fg = c.fg,     bg = "#181818" })
hi("PmenuSel",      { fg = c.bg,     bg = c.fg })
hi("PmenuSbar",     { bg = "#222222" })
hi("PmenuThumb",    { bg = c.dim2 })
hi("Visual",        { bg = c.selection })
hi("Search",        { fg = c.bg,     bg = c.dim1 })
hi("IncSearch",     { fg = c.bg,     bg = c.accent })
hi("MatchParen",    { fg = c.accent, bold = true, underline = true })
hi("NonText",       { fg = c.dim5 })
hi("Folded",        { fg = c.dim3,   bg = "#181818", italic = true })
hi("EndOfBuffer",   { fg = c.dim5 })

-- ── Classic syntax groups (fallback for no treesitter)

-- Comments — nearly invisible, italic
hi("Comment",     { fg = c.dim4, italic = true })

-- Keywords — white, bold. Unmissable.
hi("Keyword",     { fg = c.accent, bold = true })
hi("Statement",   { fg = c.accent, bold = true })
hi("Conditional", { fg = c.accent, bold = true })
hi("Repeat",      { fg = c.accent, bold = true })
hi("Exception",   { fg = c.accent, bold = true })
hi("Label",       { fg = c.accent, bold = true })

-- Functions — white bold + underline at definition
hi("Function",    { fg = c.accent, bold = true, underline = true })

-- Types — dim italic
hi("Type",        { fg = c.dim1, italic = true })
hi("Structure",   { fg = c.dim1, italic = true })
hi("Typedef",     { fg = c.dim1, italic = true })

-- Identifiers — plain readable
hi("Identifier",  { fg = c.fg })

-- Builtins / specials — bold italic
hi("Special",     { fg = c.accent, bold = true, italic = true })
hi("PreProc",     { fg = c.dim1,   bold = true })
hi("Include",     { fg = c.dim1,   bold = true })
hi("Define",      { fg = c.dim1,   bold = true })
hi("Macro",       { fg = c.dim1,   bold = true, italic = true })

-- Literals
hi("String",      { fg = c.dim2 })             -- data, fades back
hi("Constant",    { fg = c.dim1, bold = true }) -- slightly pop
hi("Number",      { fg = c.dim1, bold = true })
hi("Float",       { fg = c.dim1, bold = true })
hi("Boolean",     { fg = c.accent, bold = true })

-- Operators & punctuation — fade away
hi("Operator",    { fg = c.dim3 })
hi("Delimiter",   { fg = c.dim3 })

-- Errors / todos
hi("Error",       { fg = c.accent, bold = true, underline = true })
hi("Todo",        { fg = c.bg, bg = c.accent, bold = true })
hi("Underlined",  { underline = true })

-- ── Treesitter (@-prefixed) ───────────────────────────────────

-- Comments
hi("@comment",                    { fg = c.dim4, italic = true })
hi("@comment.documentation",      { fg = c.dim3, italic = true })

-- Keywords — bold white, always pop
hi("@keyword",                    { fg = c.accent, bold = true })
hi("@keyword.function",           { fg = c.accent, bold = true })
hi("@keyword.return",             { fg = c.accent, bold = true })
hi("@keyword.operator",           { fg = c.accent, bold = true })
hi("@keyword.import",             { fg = c.dim1,   bold = true })
hi("@conditional",                { fg = c.accent, bold = true })
hi("@repeat",                     { fg = c.accent, bold = true })
hi("@exception",                  { fg = c.accent, bold = true })
hi("@include",                    { fg = c.dim1,   bold = true })

-- Functions — DEFINITION: bold + underline. CALL: plain fg.
hi("@function",                   { fg = c.accent, bold = true, underline = true })
hi("@function.call",              { fg = c.fg })
hi("@function.builtin",           { fg = c.accent, bold = true, italic = true })
hi("@function.macro",             { fg = c.dim1,   bold = true, italic = true })
hi("@method",                     { fg = c.accent, bold = true, underline = true })
hi("@method.call",                { fg = c.fg })
hi("@constructor",                { fg = c.dim1,   bold = true, underline = true })

-- Variables — plain. You read them, not notice them.
hi("@variable",                   { fg = c.fg })
hi("@variable.builtin",           { fg = c.accent, bold = true, italic = true }) -- self, this, super
hi("@variable.global",            { fg = c.dim1,   bold = true })                -- globals pop slightly
hi("@variable.parameter",         { fg = c.dim1,   italic = true, underline = true }) -- passed in = italic + underline
hi("@variable.member",            { fg = c.fg,     italic = true })              -- obj.field = subtle italic

-- Types — italic signals "shape/contract"
hi("@type",                       { fg = c.dim1, italic = true })
hi("@type.builtin",               { fg = c.dim1, bold = true, italic = true })
hi("@type.definition",            { fg = c.dim1, bold = true, italic = true, underline = true })
hi("@attribute",                  { fg = c.dim1, italic = true })
hi("@namespace",                  { fg = c.dim1, bold = true })

-- Literals — data, not logic, so they fade
hi("@string",                     { fg = c.dim2 })
hi("@string.escape",              { fg = c.dim1, bold = true })  -- \n \t etc pop inside strings
hi("@string.special",             { fg = c.dim1 })
hi("@number",                     { fg = c.dim1, bold = true })
hi("@float",                      { fg = c.dim1, bold = true })
hi("@boolean",                    { fg = c.accent, bold = true })

-- Operators & punctuation — darkest, fade out
hi("@operator",                   { fg = c.dim3 })
hi("@punctuation.bracket",        { fg = c.dim3 })
hi("@punctuation.delimiter",      { fg = c.dim3 })
hi("@punctuation.special",        { fg = c.dim2 })

-- Tags (HTML/JSX/TSX)
hi("@tag",                        { fg = c.fg,   bold = true })
hi("@tag.attribute",              { fg = c.dim1, italic = true })
hi("@tag.delimiter",              { fg = c.dim3 })

-- ── LSP semantic tokens
hi("@lsp.type.function",          { fg = c.accent, bold = true, underline = true })
hi("@lsp.type.method",            { fg = c.accent, bold = true, underline = true })
hi("@lsp.type.keyword",           { fg = c.accent, bold = true })
hi("@lsp.type.type",              { fg = c.dim1,   italic = true })
hi("@lsp.type.class",             { fg = c.dim1,   bold = true, italic = true, underline = true })
hi("@lsp.type.interface",         { fg = c.dim1,   italic = true, underline = true })
hi("@lsp.type.variable",          { fg = c.fg })
hi("@lsp.type.parameter",         { fg = c.dim1,   italic = true, underline = true })
hi("@lsp.type.property",          { fg = c.fg,     italic = true })
hi("@lsp.type.comment",           { fg = c.dim4,   italic = true })
hi("@lsp.type.string",            { fg = c.dim2 })
hi("@lsp.type.number",            { fg = c.dim1,   bold = true })
hi("@lsp.type.operator",          { fg = c.dim3 })
hi("@lsp.type.namespace",         { fg = c.dim1,   bold = true })
hi("@lsp.type.macro",             { fg = c.dim1,   bold = true, italic = true })
hi("@lsp.type.enumMember",        { fg = c.dim1,   bold = true })
hi("@lsp.type.decorator",         { fg = c.dim1,   italic = true })
hi("@lsp.mod.readonly",           { underline = true })
hi("@lsp.mod.static",             { bold = true })
hi("@lsp.mod.deprecated",         { strikethrough = true, fg = c.dim4 })

-- ── Diagnostics
hi("DiagnosticError",             { fg = c.accent, bold = true })
hi("DiagnosticWarn",              { fg = c.dim1 })
hi("DiagnosticInfo",              { fg = c.dim2 })
hi("DiagnosticHint",              { fg = c.dim3 })
hi("DiagnosticUnderlineError",    { underline = true, sp = c.accent })
hi("DiagnosticUnderlineWarn",     { underline = true, sp = c.dim1 })

-- ── Git
hi("GitSignsAdd",                 { fg = c.fg })
hi("GitSignsChange",              { fg = c.dim2 })
hi("GitSignsDelete",              { fg = c.dim4 })
