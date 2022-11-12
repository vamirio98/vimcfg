#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#-
# cmake_run.py - Run a CMake project.
#
# Created by vamirio on 2022 Apr 18
#-

import sys
import os
import subprocess
import platform

import pylib.base as base
import pylib.cmake as cmake


if not base.checkArgsNum(sys.argv, 2, "Args: curDir args"):
    exit(1)

curDir, args = sys.argv[1:]

projectRoot = base.getProjectRoot(curDir)
if projectRoot == "":
    base.printError("Error: can't find the root directory of project, check if a",
            base.projectRootFlag, "file/directory in it.")
    exit(1)

cmakelist = cmake.getTopCmakelist(projectRoot)
if cmakelist == "":
    base.printError("Error:", projectRoot, "is not a CMake project.")
    exit(1)

buildDir = os.path.join(os.path.dirname(cmakelist), "build")
execName = cmake.getProjectName(cmakelist)
execPath = os.path.join(buildDir, execName
                        + (".exe" if platform.system() == "Windows" else ""))

subprocess.run([execPath, args])
