"""
Some basic methods.
"""

#-
# base.py
#
# Created by vamirio on 2022 Apr 23
#-

import os
import sys


def printError(*args, **kwargs):
    """Print messages to stderr."""
    print(*args, file=sys.stderr, **kwargs)


def checkArgsNum(args, num: int, hints: str="") -> bool:
    """Check the number of function arguments."""
    if len(args) != num + 1:
        printError("Error: wrong number of arguments,", len(args) - 1,
                "passed and exactly", num, "expected.")
        if hints != "":
            printError("Hints:", hints)
        return False
    return True


projectRootFlag = (".git", ".root", ".project", ".svn")
def getProjectRoot(curDir: str) -> str:
    """Return the absolute path of the project root directory, or "" if not
    found."""
    foundProjectRoot = False

    curDir = os.path.abspath(curDir)
    while curDir != os.path.abspath(os.path.join(curDir, "..")):
        files = os.listdir(curDir)
        for file in files:
            if file in projectRootFlag:
                foundProjectRoot = True
                break
        if foundProjectRoot:
            break
        curDir = os.path.abspath(os.path.join(curDir, ".."))

    return curDir if foundProjectRoot else ""
