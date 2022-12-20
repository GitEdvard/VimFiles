local query = require'nvim-treesitter.query'
local ts_utils = require'nvim-treesitter.ts_utils'

-- Trim spaces and opening brackets from end
local transform_line = function(line)
    return line:gsub('%s*[%[%(%{]*%s*$', '')
end

local get_line_for_node = function(node, type_patterns, transform_fn)
    local node_type = node:type()
    local is_valid = false
    for _, rgx in ipairs(type_patterns) do
        if node_type:find(rgx) then
            is_valid = true
            break
        end
    end
    if not is_valid then return '' end
    local line = transform_fn(vim.trim(ts_utils.get_node_text(node)[1] or ''))
    -- Escape % to avoid statusline to evaluate content as expression
    return line:gsub('%%', '%%%%')
end

function statusline()
    local options = {}
    local indicator_size = 100
    local type_patterns = {'class', 'function', 'method'}
    local transform_fn = transform_line
    local separator = ' -> '

    local current_node = ts_utils.get_node_at_cursor()
    if not current_node then return "" end

    local lines = {}
    local expr = current_node

    while expr do
        local line = get_line_for_node(expr, type_patterns, transform_fn)
        if line ~= '' and not vim.tbl_contains(lines, line) then
            table.insert(lines, 1, line)
        end
        expr = expr:parent()
    end

    local text = table.concat(lines, separator)
    return text
end
local group = vim.api.nvim_create_augroup("edvard-automagic", { clear = true })

local attach_to_buffer = function(bufnr)
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = group,
        pattern = "*.cs",
        callback = function()
            local text = statusline()
            print(text)
        end,
    } )
end

vim.api.nvim_create_user_command("ShowSemantic", function()
    attach_to_buffer(vim.api.nvim_get_current_buf())
end, {})

