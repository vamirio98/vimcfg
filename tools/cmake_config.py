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


if not base.check_args_num(sys.argv, 1):
    exit(1)

project_root = base.find_project_root(sys.argv[1])
if project_root == "":
    base.eprint("Error: can't find the root directory of project, check if a",
            base.project_root_flag, "file/directory in it.")
    exit(1)
if not cmake.is_cmake_project(project_root):
    base.eprint("Error:", project_root, "is not a CMake project.")
    exit(1)

build_dir = os.path.join(project_root, "build")
if not os.path.isdir(build_dir):
    os.mkdir(build_dir, 0o755)

os.chdir(build_dir)
subprocess.run(["cmake", "..", "-DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=ON"])
