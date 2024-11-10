local M = {}

-- Function to insert `if __name__ == '__main__':` at the end of the file with two new lines
function M.InsertMainGuardAtEnd()
    local main_guard = "if __name__ == '__main__':"

    -- Move to the end of the file
    vim.cmd("normal! G")

    -- Insert two new lines (PEP8 requirement)
    vim.cmd("normal! o")
    vim.cmd("normal! o")

    -- Insert the main guard
    vim.api.nvim_put({ main_guard }, 'l', true, true)
end

return M
