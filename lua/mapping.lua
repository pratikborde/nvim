-- Mappings

local K = require "utils"

-- Using backtick for marks drops you on the exact column
K.Key_mapper("n", "`", "'")
K.Key_mapper("n", "'", "`")

-- Command mode
K.Key_mapper("n", ":", ";")
K.Key_mapper("n", ";", ":")
K.Key_mapper("x", ":", ";")
K.Key_mapper("x", ";", ":")

-- Completion
K.Key_mapper("i", "<C-]>", "<C-x><C-]>") -- Tag
K.Key_mapper("i", "<C-k>", "<C-x><C-o>") -- Omni
K.Key_mapper("i", "<C-n>", "<C-x><C-n>") -- Keyword
K.Key_mapper("i", "<C-f>", "<C-x><C-f>") -- File name
K.Key_mapper("i", "<C-l>", "<C-x><C-l>") -- Line
K.Key_mapper("i", "<C-f>", "<C-x><C-s>") -- Spell
K.Key_mapper("i", "<Tab>", "pumvisible() ? '<C-n>' : '<Tab>'", true) -- Spell
K.Key_mapper("i", "<S-Tab>", "pumvisible() ? '<C-n>' : '<S-Tab>'", true) -- Spell

-- Tabs
K.Key_mapper("n", "<Tab>", "gt")
K.Key_mapper("n", "<S-Tab>", "gT")

-- Center search
K.Key_mapper("n", "n", "nzvzz")
K.Key_mapper("n", "N", "Nzvzz")
K.Key_mapper("n", "*", "*zvzz")
K.Key_mapper("n", "#", "#zvzz")
K.Key_mapper("n", "``", "``zz")

-- Terminal
K.Key_mapper("t", "<Esc>", "<C-\\><C-n>")

-- Location list
K.Key_mapper("n", "<Up>", [[:call togglelist#ToggleList('Location List', 'l')<CR>]], true, false, true) -- Toggle Location list
K.Key_mapper("n", "]l", ":lnext<CR>")
K.Key_mapper("n", "[l", ":lprevious<CR>")
K.Key_mapper("n", "[L", ":lfirst<CR>")
K.Key_mapper("n", "]L", ":llast<CR>")
K.Key_mapper("n", "]<C-L>", ":lnfile<CR>")
K.Key_mapper("n", "[<C-L>", ":lpfile<CR>")

-- Quickfix list
K.Key_mapper("n", "<Down>", [[:call togglelist#ToggleList('Quickfix List', 'c')<CR>]], true, false, true) -- Toggle Quickfix list
K.Key_mapper("n", "]q", ":cnext<CR>")
K.Key_mapper("n", "[q", ":cprevious<CR>")
K.Key_mapper("n", "[Q", ":cfirst<CR>")
K.Key_mapper("n", "]Q", ":clast<CR>")
K.Key_mapper("n", "]<C-F>", ":cnfile<CR>")
K.Key_mapper("n", "[<C-F>", ":cpfile<CR>")

-- Buffers
K.Key_mapper("n", "<BS>", "<C-^>")
K.Key_mapper("n", "]b", ":bnext<CR>")
K.Key_mapper("n", "[b", ":bprevious<CR>")

-- Args
K.Key_mapper("n", "]a", ":next<CR>")
K.Key_mapper("n", "[a", ":previous<CR>")

-- Substitute
K.Key_mapper("n", "<Bslash>s", ":%s/\\v<<C-r><C-w>>/")

-- Global
K.Key_mapper("n", "<Bslash>g", ":g//#<Left><Left>")
-- Lists
K.Key_mapper("n", "<Bslash>F", ":global //#<left><left>")
K.Key_mapper("n", "<Bslash>f", ":global /<C-R><C-W>/#")

-- New lines
K.Key_mapper("n", "]<space>", "o<C-c>")
K.Key_mapper("n", "[<space>", "O<C-c>")

-- Find
K.Key_mapper("n", "<space>f", ":find<space>")
K.Key_mapper("n", "<space>c", ":Cfind<space>")
K.Key_mapper("n", "<space>s", ":sfind<space>")
K.Key_mapper("n", "<space>v", ":vert sfind<space>")
K.Key_mapper("n", "<space>t", ":tabfind<space>")

-- Edit
K.Key_mapper("n", "<space>ee", ":e <C-R>='%:h/'<CR>")
K.Key_mapper("n", "<space>ev", ":vsp <C-R>='%:h/'<CR>")
K.Key_mapper("n", "<space>es", ":sp <C-R>='%:h/'<CR>")

-- Lists
K.Key_mapper("c", "<CR>", "listcommands#CR()", false, true, false)
