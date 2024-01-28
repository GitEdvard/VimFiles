require("telescope").load_extension("git_worktree")
local R = require("java.prepare_jdtls")
local L = require("java.launcher")

-- <Enter> - switches to that worktree
-- <c-d> - deletes that worktree
-- <c-f> - toggles forcing of the next deletion

local Worktree = require("git-worktree")

local create_flag = false
local created_branch = ""

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

local initiate_new_branch = function(path, branch)
  local cmd = R.generate_update_branch_command(branch)
  local instruction1 = { "silent", cmd, "nvim adapt" }
  local instructions = R.generate_hide_commands_poly()
  table.insert(instructions, 1, instruction1)
  -- P(instructions)
  require'trigger-commands'.run_poly( instructions )
end

Worktree.on_tree_change(function(op, metadata)
  if op == Worktree.Operations.Switch then
    if create_flag then
      create_flag = false
      initiate_new_branch(metadata.path, created_branch)
      created_branch = ""
    end
    print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
    local cmd = "ant prepare-runner"
    require'trigger-commands'.run_silent{cmd, "Prepare launching completed", "Prepare lanching failed"}
  end
  if op == Worktree.Operations.Create then
    create_flag = true
    created_branch = metadata.branch
    print("Creating new worktree branch")
    print("create: path: " .. metadata.path)
    print("new branch name: " .. metadata.branch)
  end
  if op == Worktree.Operations.Delete then
    local split_path = mysplit(metadata.path, "/")
    local branch = split_path[#split_path]
    require'java.prepare_jdtls'.delete_java_files(branch)
    vim.cmd("Git br -D " .. branch)
    print("deleted branch path: " .. metadata.path)
    L.delete_old_run_catalogs()
  end
end)

local reset = function()
    package.loaded['git-worktree'] = nil
    package.loaded['telescope'] = nil
end

vim.keymap.set('n', '<leader>yw', "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", bufopts)
vim.keymap.set('n', '<leader>yc', "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", bufopts)
vim.keymap.set('n', '<leader>uv', reset, bufopts)
