# vimcfg

Personal **Vim** Profile.

## Requirements

```english
Vim >= 8.0
nodejs >= 12.12
npm
clangd
```

## Install

* In Unix

```bash
// Clone this project
cd ~/.vim
git clone https://github.com/vamirio98/vimcfg.git

// Edit ~/.vimrc, add the following code:
source ~/.vim/vimcfg/init.vim
```

* In Windows

```bash
// Clone this project
cd ~/vimfiles
git clone https://github.com/vamirio98/vimcfg.git

// Edit ~/_vimrc, add the following code:
source ~/vimfiles/vimcfg/init.vim
```

After the steps above in correspond OS, open Vim and use the command:
`
:PlugInstall
`
to install all plugins.
Then use the command:
`
:CocInstall extension
`
to install the extension you want.

Necessary extensions:

```text
coc-json      // Parse and complete JSON, the coc-extensions configure language
coc-clangd    // Parse and complete C/C++, need clangd
coc-snippets  // Complete snippets, need plugin vim-snippets or something
              // provide the same function
```

Optional extensions:

```text
coc-translator  // online translator
coc-ecdict      // offline translator
```

## Reference

[skywind3000/vim-init](https://github.com/skywind3000/vim-init)
