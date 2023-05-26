#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# -
# set_code_style.py
#
# Created by vamirio on 2022 Aug 30
# -

import pprint
import sys
import shutil
import os


STYLE = {
    "cpp": ("clang-format", ".clang-format"),
    "lua": ("stylua.toml", ".stylua.toml"),
}


def main():
    pp = pprint.PrettyPrinter(indent=4, width=70)
    language, cfgDir, projectRoot = sys.argv[1:]

    src = os.path.join(cfgDir, STYLE[language][0])
    dest = os.path.join(projectRoot, STYLE[language][1])
    if os.path.exists(dest):
        pp.pprint(
            "Warn: "
            + dest
            + " is already exists, remove it if you want to reset the code style"
        )
        exit(1)
    shutil.copyfile(src, dest)


if __name__ == '__main__':
    main()
