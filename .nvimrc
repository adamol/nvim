function SyncToVM()
    let currentFile = fnamemodify(expand('%'), ':~:.')
    let apiRemotePath = "~/workspace/api1/"
    let currentPath = getcwd() . "/"

    let remoteFile = apiRemotePath . currentFile
    let currentFile = currentPath . currentFile

    silent execute "!rsync " . currentFile . " vm:" . remoteFile . " &"
endfunction
autocmd BufWritePost * :call SyncToVM()

let g:vdebug_options.path_maps = {"/home/adamo/workspace/api1": "/home/adam/PhpstormProjects/api1"}
