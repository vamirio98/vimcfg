#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#-
# set_code_style.py
#
# Created by vamirio on 2022 Aug 30
#-

import sys
import subprocess
import os

import pylib.base as base

if not base.checkArgsNum(sys.argv, 2, "Args: srcStyleFile curDir."):
    exit(1)

srcStyleFile, curDir = sys.argv[1:]
projectRoot = base.getProjectRoot(curDir)
if projectRoot == "":
    base.printError("Error: can't find the root directory of project, check if a",
            base.projectRootFlag, "file/directory in it.")
    exit(1)

destStyleFile = os.path.join(projectRoot, ".clang-format")
if os.path.exists(destStyleFile):
    base.printError("Warn:", destStyleFile,
          "is already exists, remove it if you want to reset the code style.")
    exit(1)
subprocess.run(["cp", srcStyleFile, destStyleFile])
