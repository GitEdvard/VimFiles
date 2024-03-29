let g:python3_host_prog = '~/.virtualenvs/pynvim/bin/python3'
let g:java_exe = '/home/edvard/bin/jdk-17.0.6/bin/java'
let g:jdtls_jar = '/home/edvard/bin/jdt-language-server-latest/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar'
let g:jdtls_config = '/home/edvard/bin/jdt-language-server-latest/config_linux'
let g:ctrlsf_ackprg = '/usr/bin/rg'
let b:node_dir = '/home/edvard/.nvm/versions/node/v14.16.0/bin/'
let g:node_host_prog = b:node_dir . 'node'
let g:java_files_base = '/home/edvard/java_files/'
let $PATH = b:node_dir . ':' . $PATH
set clipboard+=unnamedplus
let g:clipboard = {
              \   'name': 'win32yank-wsl',
          \   'copy': {
              \      '+': 'win32yank.exe -i --crlf',
          \      '*': 'win32yank.exe -i --crlf',
          \    },
          \   'paste': {
              \      '+': 'win32yank.exe -o --lf',
          \      '*': 'win32yank.exe -o --lf',
          \   },
          \   'cache_enabled': 0,
          \ }

command! Compile execute ":!/mnt/c/Program\\\ Files\\\ \\\(x86\\\)/Microsoft\\\ Visual\\\ Studio/2019/BuildTools/MSBuild/Current/Bin/MSBuild.exe /p:WarningLevel=0 /verbosity:minimal /p:Configuration=Release"
command! AppendClipboard execute ":!win32yank.exe -o >> %"
command! PurgeWindowEndings execute ":%s/\r/"
