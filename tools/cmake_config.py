#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#-
# cmake_config.py - Configure a CMake project.
#
# Created by vamirio on 2022 Apr 23
#-

import sys
import os
import subprocess

import pylib.base as base
import pylib.cmake as cmake


if not base.checkArgsNum(sys.argv, 3, "Args: curDir projectType['top', 'sub'] buildType"):
    exit(1)

curDir, projectType, buildType = sys.argv[1:]

projectRoot = base.getProjectRoot(curDir)
if projectRoot == "":
    base.printError("Error: can't find the root directory of project, check if a",
                    base.projectRootFlag, "file/directory in it.")
    exit(1)

if projectType not in ("top", "sub"):
    base.printError("Error: unknown project type:", projectType, ". ['top', 'sub']")
    exit(1)
cmakelist = (cmake.getTopCmakelist(projectRoot) if projectType == "top"
                    else cmake.getSubCmakelist(curDir, projectRoot))
if cmakelist == "":
    base.printError("Error:", projectRoot, "is not a CMake project.")
    exit(1)

buildDir = os.path.join(os.path.dirname(cmakelist), "build")
if not os.path.isdir(buildDir):
    os.mkdir(buildDir, 0o755)

os.chdir(buildDir)
subprocess.run(["cmake", "..", "-DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=ON", "-DCMAKE_BUILD_TYPE=" + buildType])
