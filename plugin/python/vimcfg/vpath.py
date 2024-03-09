#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Module to opearte directory.

import os as __os


def walk(
    top: str,
    topdown: bool = True,
    followLink: bool = False,
    maxLevel: int = 100,
):
    """
    Directory tree genrator with max level.
    """
    if maxLevel == 0:
        return

    dirs: list[str] = []
    files: list[str] = []
    walkDirs: list[str] = []
    with __os.scandir(top) as iterator:
        for entry in iterator:
            if entry.is_dir():
                dirs.append(entry.name)
            else:
                files.append(entry.name)
            if not topdown and entry.is_dir():
                if followLink or not entry.is_symlink():
                    walkDirs.append(entry.name)
        if topdown:
            yield top, dirs, files
            for dirname in dirs:
                newTop = __os.path.join(top, dirname)
                if followLink or not __os.path.islink(newTop):
                    yield from walk(newTop, topdown, followLink, maxLevel - 1)
        else:
            for newTop in walkDirs:
                yield from walk(newTop, topdown, followLink, maxLevel - 1)
            yield top, dirs, files
