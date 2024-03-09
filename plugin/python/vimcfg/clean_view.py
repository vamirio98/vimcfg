#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
from os import path
import time

from vimcfg import vpath

class CleanView:
    """
    remove all files older than @ago in @viewDir
    """
    def __init__(self, viewDir: str, ago: int) -> None:
        self.viewDir = viewDir
        self.ago = ago

    def execute(self):
        now: float = time.time()
        t = now - 60 * 60 * 24 * self.ago # Number of seconds in @ago
        for top, _, files in vpath.walk(self.viewDir):
            for file in files:
                if path.getmtime(path.join(top, file)) < t:
                    os.remove(path.join(top, file))
