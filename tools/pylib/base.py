"""
Some basic methods.
"""

#-
# base.py
#
# Created by vamirio on 2022 Apr 23
#-

import os


def check_args_num(args, num: int) -> bool:
    """Check the number of function arguments."""
    if len(args) != num + 1:
        print("Error: wrong number of arguments,", len(args) - 1,
                "passed and exactly", num, "expected.")
        return False
    return True


project_root_flag = (".git", ".root", ".project", ".svn")


def find_project_root(curr_dir: str) -> str:
    """Return the absolute path of the project root directory, or "" if not
    found. """
    found_project_root = False

    curr_dir = os.path.abspath(curr_dir)
    while curr_dir != os.path.abspath(os.path.join(curr_dir, "..")):
        files = os.listdir(curr_dir)
        for file in files:
            if file in project_root_flag:
                found_project_root = True
                break
        if found_project_root:
            break
        curr_dir = os.path.abspath(os.path.join(curr_dir, ".."))

    if not found_project_root:
        return ""

    return curr_dir


