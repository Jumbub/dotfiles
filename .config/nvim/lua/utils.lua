function GetCurrentSelection()
    local start_line, start_col = unpack(vim.api.nvim_buf_get_mark(0, '<'))
    local end_line, end_col = unpack(vim.api.nvim_buf_get_mark(0, '>'))
    --
    -- Read the visually selected text
    local lines = vim.api.nvim_buf_get_text(0, start_line - 1, start_col,
                                            end_line, end_col, {})

    if #lines > 0 then
        -- Merge lines into a single string
        local selection = table.concat(lines, "\n")
        -- If multiple lines, end_col seems to always be 0. Using length of the last line instead.
        if #lines > 1 then end_col = #lines[#lines] end
        selection = selection:sub(start_col + 1,
                                  #selection - (#lines[#lines]) + end_col)

        -- Base64 encode the selection
        local b64 = vim.fn.base64encode(selection)

        -- Replace the visual selection with the Base64 encoding
        if #lines == 1 then
            local line = lines[1]
            local new_line = line:sub(1, start_col) .. b64 ..
                                 line:sub(end_col + 1)
            vim.api.nvim_buf_set_lines(0, start_line - 1, start_line, false,
                                       {new_line})
        else
            local first_line = lines[1]:sub(1, start_col) .. b64
            local last_line = lines[#lines]:sub(end_col + 1)
            vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false,
                                       {first_line, last_line})
        end
    end
end
