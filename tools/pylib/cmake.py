"""
Module which deal with CMake project.
"""

#-
# cmake.py - Module for cmake project.
#
# Created by vamirio on 2022 Apr 16
#-

import os

def is_cmake_project(project_root: str) -> bool:
    """Check if the project is a CMake project which contain a CMakeLists.txt
    in the project root directory."""
    return "CMakeLists.txt" in os.listdir(project_root)


def get_project_name(cmakelist: str) -> str:
    """Return the project name in CMakeLists.txt, or "" if not found."""
    file = open(cmakelist, "r")
    lines = file.readlines()
    project_name = ""

    for line in lines:
        if line.find("project(") == -1 and line.find("PROJECT(") == -1:
            continue
        i = 8
        while i < len(line) and line[i] != ' ' and line[i] != ')':
            i += 1
        project_name = line[8:i]
        break

    return project_name
