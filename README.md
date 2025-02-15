# vimcfg

Personal **Vim** Profile.

## Install

```bash
# Edit ~/.vimrc, add the following code:
source path/to/vimcfg/init.vim
```

After the steps above, open Vim and use the command
`:PlugInstall` to install all plugins. Then use the command
`:CocInstall extension` to install the extension wanted.

Optional vimspector configurations:

To use configurations provided in `plugcfg/vimspector`, you can create symbolic
links in `/path/to/vimspector/configurations/OS/` which have the same
name as the files in `plugcfg/vimspector`, where the `OS` is the system name.

```bash
# Example:
# Unix:
cd /path/to/vimspector/configurations/linux
mkdir c
cd c
ln -s /path/to/plugcfg/vimspector/vscode_cpptools.json

# Windows:
cd path\to\vimspector\configurations\windows
mkdir python
cd python
mklink debugpy.json path\to\plugcfg\vimspector\debugpy.json
```

## Reference

[skywind3000/vim](https://github.com/skywind3000/vim)
[LazyVim](https://github.com/LazyVim/starter)
