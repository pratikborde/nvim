local M = {}

-- Save session
function M.SessionSave()
  if vim.fn.finddir(".git", ",;") == ".git" then
    local root = vim.fn.substitute(vim.fn.fnamemodify(vim.fn.getcwd(0), ":t"), "^\\.", "", "")
    vim.api.nvim_command("mks! " .. vim.fn.stdpath("config") .. "/tmp/dir_session/" .. root .. ".vim")
  end
end

return M
