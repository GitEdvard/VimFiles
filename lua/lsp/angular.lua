local cwd = vim.fn.getcwd()
local project_library_path = cwd .. "/node_modules"

local cmd = {
    cwd .. "/node_modules/@angular/language-server/bin/ngserver",
    "--ngProbeLocations",
    project_library_path,
    "--tsProbeLocations",
    project_library_path ,
    "--stdio",
}

require'lspconfig'.angularls.setup{
    cmd = cmd,
    on_new_config = function(new_config, new_root_dir)
        new_config.cmd = cmd
    end
}

