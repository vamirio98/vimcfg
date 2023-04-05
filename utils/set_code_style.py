#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# -
# set_code_style.py
#
# Created by vamirio on 2022 Aug 30
# -

import sys
import shutil
import os

import pylib.base as base


def setDestFile(language: str) -> str:
    destFile = ""
    if language == "c" or language == "cpp":
        destFile = ".clang-format"
    elif language == "lua":
        destFile = ".stylua.toml"
    else:
        pass

    return destFile


def main():
    if not base.checkArgsNum(sys.argv, 3, "Args: srcFile curDir language."):
        exit(1)

    srcFile, curDir, language = sys.argv[1:]

    projectRoot = base.getProjectRoot(curDir)
    if projectRoot == "":
        base.printError(
            "Error: can't find the root directory of project, check if a",
            base.projectRootFlag,
            "file/directory in it.",
        )
        exit(1)

    fileName = setDestFile(language)
    if fileName == "":
        base.printError("Error: unknown language:", language)
        exit(1)

    destFile = os.path.join(projectRoot, fileName)
    if os.path.exists(destFile):
        base.printError(
            "Warn:",
            destFile,
            "is already exists, remove it if you want to reset the code style.",
        )
        exit(1)

    shutil.copyfile(srcFile, destFile)


if __name__ == '__main__':
    main()
