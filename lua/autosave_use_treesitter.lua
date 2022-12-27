local query_module = require'vim.treesitter.query'
local ts_utils = require'nvim-treesitter.ts_utils'
local ts = require'vim.treesitter'

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
    -- print("node repr: " .. vim.inspect(vim.trim(node:field("type"))))
    print("node repr: " .. vim.inspect(vim.trim(vim.inspect(node:field("name")))))
    -- print("get_node_text: " .. vim.inspect(vim.trim(query.get_node_text(node, vim.api.nvim_get_current_buf()) or '')))
    local line = transform_fn(vim.trim(query.get_node_text(node) or ''))
    -- Escape % to avoid get_method_name to evaluate content as expression
    return line:gsub('%%', '%%%%')
end

local matches_pattern = function(node, type_patterns)
    local node_type = node:type()
    local is_valid = false
    for _, rgx in ipairs(type_patterns) do
        if node_type:find(rgx) then
            is_valid = true
            break
        end
    end
    return is_valid
end

local query_string = [[
(
(method_declaration
name: (identifier) @name)
)
]]

local find_position = function(start_node, bufnr, query_string)
    local query = ts.parse_query("c_sharp", query_string)
    for id, node in query:iter_captures(start_node, bufnr, 0, -1) do
        if id == 1 then
            local start = { node:start() }
            local start_byte = start[3]
            local end_ = { node:end_() }
            local end_byte = end_[3]
            -- return { start_byte, end_byte }
            return query_module.get_node_text(node, bufnr)
        end
    end
    return nil
end

function get_method_name(bufnr)
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
        local matches = matches_pattern(expr, type_patterns)
        if matches then
            break
        end
        expr = expr:parent()
    end
    local method_node = expr
    local pos = find_position(method_node, bufnr, query_string)
    return pos
end

local group = vim.api.nvim_create_augroup("edvard-automagic", { clear = true })

local attach_to_buffer = function(bufnr)
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = group,
        pattern = "*.cs",
        callback = function()
            local text = get_method_name(bufnr)
            print(vim.inspect(text))
        end,
    } )
end

vim.api.nvim_create_user_command("ShowSemantic", function()
    attach_to_buffer(vim.api.nvim_get_current_buf())
end, {})

