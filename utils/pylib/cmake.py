"""
Module which deal with CMake project.
"""

#-
# cmake.py - Module for cmake project.
#
# Created by vamirio on 2022 Apr 16
#-

import os
import queue

def hasCmakelists(dirPath: str) -> bool:
    """Check if there is a CMakeLists.txt in the specified directory."""
    return "CMakeLists.txt" in os.listdir(dirPath)


def getSubCmakelist(curDir: str, projectRoot: str=os.path.abspath(os.sep)) -> str:
    """Get CMakeLists.txt for the subproject, return its absolute path or "" if
    not found"""
    foundCmakelist = hasCmakelists(curDir)
    while not foundCmakelist and curDir != projectRoot:
        curDir = os.path.abspath(os.path.join(curDir, ".."))
        foundCmakelist = hasCmakelists(curDir)

    return os.path.join(curDir, "CMakeLists.txt") if foundCmakelist else ""


def getTopCmakelist(projectRoot: str) -> str:
    """Get the top CMakeLists.txt, return its absolute path or "" if not found."""
    foundCmakelist = False

    curDir = os.path.abspath(projectRoot)
    dirs = queue.Queue()
    dirs.put(curDir)

    while not dirs.empty() and not foundCmakelist:
        dirNum = dirs.qsize()
        for _ in range(0, dirNum):
            curDir = dirs.get()
            files = os.listdir(curDir)
            for file in files:
                if file == "CMakeLists.txt":
                    foundCmakelist = True
                    break

                curFile = os.path.join(curDir, file)
                if os.path.isdir(curFile):
                    dirs.put(curFile)
            if foundCmakelist:
                break

    return os.path.join(curDir, "CMakeLists.txt") if foundCmakelist else ""


def getProjectName(cmakelist: str) -> str:
    """Return the project name in CMakeLists.txt, or "" if not found."""
    file = open(cmakelist, "r")
    lines = file.readlines()
    projectName = ""

    for line in lines:
        if line.find("project(") == -1 and line.find("PROJECT(") == -1:
            continue
        i = 8
        while i < len(line) and line[i] != ' ' and line[i] != ')':
            i += 1
        projectName = line[8:i]
        break

    return projectName
