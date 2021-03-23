#!/bin/bash
#=======================================================
# install.sh - auto install script
#
# Created by hyl on 2021/02/17
# Last Modified: 2021/03/23 16:20:50
#=======================================================


COC_CONFIG_DIR=".config"
VIM_DIR="${HOME}/.vim"
VIM_PLUG_DIR="${VIM_DIR}/plugged"
VIMSPECTOR_DIR="${VIM_PLUG_DIR}/vimspector"
PROJECT_DIR=$(pwd)

# make sure all directories we need exist, if not, create them
if [ ! -d "${VIM_DIR}" ]; then
	mkdir ${VIM_DIR} && echo -e "\033[32mCreated ${VIM_DIR}\033[0m"
fi
if [ ! -d "${VIM_PLUG_DIR}" ]; then
	mkdir ${VIM_PLUG_DIR} && echo -e "\033[32mCreated ${VIM_PLUG_DIR}\033[0m"
fi

# config asynctasks
cp -u ${PROJECT_DIR}/plugcfg/tasks.ini ${VIM_DIR} && \
	echo -e "\033[32mUpdated ${VIM_DIR}/task.ini\033[0m"

# install plugins
vim -c 'PlugInstall! | q | q' && echo -e "\033[32mInstalled plugins\033[0m"


# install coc-plugins
vim -c 'CocInstall -sync coc-json coc-snippets coc-highlight coc-tsserver coc-python coc-html coc-css coc-clangd coc-translator | q | q' && \
	echo -e "\033[32mInstalled coc-plugins\033[0m"


# install vimspector gadget
cd ${VIMSPECTOR_DIR} && echo -e "\033[33mNow in $(pwd)"
./install_gadget.py --all && \
	echo -e "\033[32mInstalled vimspector gadget\033[0m"
cd configurations/linux && echo -e "\033[33mNow in $(pwd)"
if [ ! -d "c" ]; then
	mkdir c && echo -e "\033[32mCreated dir c\033[0m"
fi
if [ ! -d "cpp" ]; then
	mkdir cpp && echo -e "\033[32mCreated dir cpp\033[0m"
fi
cp -u ${PROJECT_DIR}/plugcfg/c.json c/c.json && \
	echo -e "\033[32mUpdated c.json\033[0m"
cp -u ${PROJECT_DIR}/plugcfg/c.json cpp/cpp.json && \
	echo -e "\033[32mUpdated cpp.json\033[0m"

cd ${PROJECT_DIR} && echo -e "\033[33mNow in $(pwd)\033[0m" && \
	echo -e "\033[32mFinished\033[0m"
