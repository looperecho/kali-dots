local M = {}

-- Function to wrap the word under the cursor into a print(f'{var= }') statement
function M.WrapInPrint()
    -- Get the word under the cursor
    local word = vim.fn.expand("<cword>")

    -- Replace the word with the print statement, wrapping it with f-string
    local wrapped_text = string.format("print(f'{%s=}')", word)

    -- Use substitute command to replace the word with the wrapped text
    vim.cmd(string.format("normal! ciw%s", wrapped_text))
end

return M
