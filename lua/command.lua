local com = vim.api.nvim_command

-- Grep for quickfix list
com [[command! -nargs=+ -complete=file Grep cgetexpr utils#grep(<f-args>)]]

-- Save sessions (force)
com [[command! -nargs=0 SessionSave lua require 'utils/session'.SessionSave()]]

-- Nvim colors to kitty
com [[command! -nargs=0 ColorKitty lua require 'utils/color'.ModifyKittyColors()]]

-- Dirvish
com [[command! -nargs=? -complete=dir Explore Dirvish <args>]]
com [[command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>]]
com [[command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>]]

-- Telescope
com [[command! -nargs=? Thelp lua require 'telescope.builtin'.help_tags(require('telescope.themes').get_dropdown({}))]]
com [[command! -nargs=? TqList lua require 'telescope.builtin'.quickfix(require('telescope.themes').get_dropdown({}))]]
com [[command! -nargs=? Tllist lua require 'telescope.builtin'.loclist(require('telescope.themes').get_dropdown({}))]]
com [[command! -nargs=? Tregs lua require 'telescope.builtin'.registers(require('telescope.themes').get_dropdown({}))]]
com [[command! -nargs=? Tcolors lua require 'telescope.builtin'.colorscheme(require('telescope.themes').get_dropdown({}))]]
com [[command! -nargs=? Tmarks lua require 'telescope.builtin'.marks(require('telescope.themes').get_dropdown({}))]]
com [[command! -nargs=? Tstatus lua require 'telescope.builtin'.git_status(require('telescope.themes').get_dropdown({}))]]
com [[command! -nargs=? Tbranches lua require 'telescope.builtin'.git_branches(require('telescope.themes').get_dropdown({}))]]
com [[command! -nargs=? Tbcommits lua require 'telescope.builtin'.git_bcommits(require('telescope.themes').get_dropdown({}))]]
com [[command! -nargs=? Tcommits lua require 'telescope.builtin'.git_commits(require('telescope.themes').get_dropdown({}))]]
com [[command! -nargs=? Ttree lua require 'telescope.builtin'.treesitter(require('telescope.themes').get_dropdown({}))]]
com [[command! -nargs=? Treferences lua require 'telescope.builtin'.lsp_references(require('telescope.themes').get_dropdown({}))]]
com [[command! -nargs=? Twsymbols lua require 'telescope.builtin'.lsp_workspace_symbols(require('telescope.themes').get_dropdown({}))]]

-- Yank
com [[command! -nargs=? -complete=dir YRelative :let @+ = expand("%")]]
com [[command! -nargs=? -complete=dir YFilename :let @+ = expand("%:t")]]

-- Custom Pickers
com [[command! -nargs=0 Jest lua require 'utils/telescope'.JestPicker(require('telescope.themes').get_dropdown({}))]]
com [[command! -nargs=0 Npm lua require 'utils/telescope'.NpmPicker(require('telescope.themes').get_dropdown({}))]]
com [[command! -nargs=0 SessionLoad lua require 'utils/telescope'.SessionPicker(require('telescope.themes').get_dropdown({}))]]
