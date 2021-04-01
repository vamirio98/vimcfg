#!/bin/bash
#=======================================================
# install.sh - auto install script
#
# Created by hyl on 2021/02/17
# Last Modified: 2021/04/01 15:04:58
#=======================================================


VIM_DIR="${HOME}/.vim"
VIM_PLUG_DIR="${VIM_DIR}/plugged"

# make sure all directories we need exist, if not, create them
if [ ! -d "${VIM_DIR}" ]; then
	echo -e "\033[32mCreating ${VIM_DIR}...\033[0m"
	mkdir ${VIM_DIR}
fi
if [ ! -d "${VIM_PLUG_DIR}" ]; then
	echo -e "\033[32mCreating ${VIM_PLUG_DIR}...\033[0m"
	mkdir ${VIM_PLUG_DIR}
fi

# install plugins
echo -e "\033[32mInstalling plugins...\033[0m"
vim -c 'PlugInstall! | q | q'


# install coc-plugins
echo -e "\033[32mInstalling coc-plugins...\033[0m"
vim -c 'CocInstall -sync coc-json coc-snippets coc-highlight coc-tsserver coc-python coc-html coc-css coc-clangd coc-translator | q | q'

echo -e "\033[32mFinish!\033[0m"
