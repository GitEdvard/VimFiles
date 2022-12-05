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
