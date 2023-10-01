require("telescope").load_extension("git_worktree")

-- <Enter> - switches to that worktree
-- <c-d> - deletes that worktree
-- <c-f> - toggles forcing of the next deletion

local Worktree = require("git-worktree")

-- op = Operations.Switch, Operations.Create, Operations.Delete
-- metadata = table of useful values (structure dependent on op)
--      Switch
--          path = path you switched to
--          prev_path = previous worktree path
--      Create
--          path = path where worktree created
--          branch = branch name
--          upstream = upstream remote name
--      Delete
--          path = path where worktree deleted

Worktree.on_tree_change(function(op, metadata)
  if op == Worktree.Operations.Switch then
    print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
  end
  if op == Worktree.Operations.Create then
    print("Creating new worktree branch")
    print("create: path: " .. metadata.path)
    require'java.prepare_jdtls'.update_branch(metadata.branch)
  end
  if op == Worktree.Operations.Delete then
    local split_path = mysplit(metadata.path, "/")
    local branch = split_path[#split_path]
    vim.cmd("Git br -D " .. branch)
    print("deleted branch path: " .. metadata.path)
  end
end)

local reset = function()
    package.loaded['git-worktree'] = nil
    package.loaded['telescope'] = nil
end

vim.keymap.set('n', '<leader>yw', "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", bufopts)
vim.keymap.set('n', '<leader>yc', "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", bufopts)
vim.keymap.set('n', '<leader>uv', reset, bufopts)
