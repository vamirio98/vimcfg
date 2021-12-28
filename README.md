# vimcfg

Personal **Vim** Profile.

## Requirements

```english
Vim >= 8.0
nodejs >= 12.12
npm
```

## Install

* In Unix

```bash
// Clone this project.
cd ~/.vim
git clone https://github.com/vamirio98/vimcfg.git

// Edit ~/.vimrc, add the following code:
source ~/.vim/vimcfg/init.vim
```

* In Windows

```bash
// Clone this project.
cd ~/vimfiles
git clone https://github.com/vamirio98/vimcfg.git

// Edit ~/_vimrc, add the following code:
source ~/vimfiles/vimcfg/init.vim
```

After the steps above in correspond OS, open Vim and use the command
`:PlugInstall` to install all plugins. Then use the command
`:CocInstall extension` to install the extension you want.

Optional coc extensions:

```text
coc-json        // Parse and complete JSON, the coc-extensions' configure
                // language.
coc-clangd      // Parse and complete C/C++, need clangd.
coc-pyright     // Parse and complete python.
coc-snippets    // Complete snippets, need plugin vim-snippets or something 
                // provided the same function.
coc-translator  // Online translator.
coc-ecdict      // Offline translator.
```

Optional vimspector configurations:

To use configurations provided in `plugcfg/vimspector`, you can create symbolic
links in `/path/to/vimspector/configurations/OS/` which have the same
name as the files in `plugcfg/vimspector`, where the `OS` is the system name.

```bash
// Example:
// Unix:
cd /path/to/vimspector/configurations/linux
mkdir c
cd c
ln -s /path/to/plugcfg/vimspector/vscode_cpptools.json

// Windows:
cd path\to\vimspector\configurations\windows
mkdir python
cd python
mklink debugpy.json path\to\plugcfg\vimspector\debugpy.json
```

## Reference

[skywind3000/vim-init](https://github.com/skywind3000/vim-init)
