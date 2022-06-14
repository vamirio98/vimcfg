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

import pylib.base
import pylib.cmake


if not pylib.base.check_args_num(sys.argv, 1):
    exit(1)

project_root = pylib.base.find_project_root(sys.argv[1])
if project_root == "":
    print("Error: can't find the root directory of project, check if a",
            pylib.base.project_root_flag, "file/directory in it.")
    exit(1)
if not pylib.cmake.is_cmake_project(project_root):
    print("Error:", project_root, "is not a CMake project.")
    exit(1)

exec_name = pylib.cmake.get_project_name(os.path.join(project_root,
    "CMakeLists.txt"))
exec_name = os.path.join(project_root, "build",
        exec_name + (".exe" if platform.system() == "Windows" else ""))

subprocess.run([exec_name])
