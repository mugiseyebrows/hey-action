import os
import sys
import argparse

print(__file__)

def walk(top, topdown=True, onerror=None, followlinks=False, maxdepth=0):
    return _walk(os.fspath(top), topdown, onerror, followlinks, maxdepth)

def _walk(top, topdown, onerror, followlinks, maxdepth):
    dirs = []
    nondirs = []
    walk_dirs = []
    try:
        scandir_it = os.scandir(top)
    except OSError as error:
        if onerror is not None:
            onerror(error)
        return

    with scandir_it:
        while True:
            try:
                try:
                    entry = next(scandir_it)
                except StopIteration:
                    break
            except OSError as error:
                if onerror is not None:
                    onerror(error)
                return

            try:
                is_dir = entry.is_dir()
            except OSError:
                is_dir = False

            if is_dir:
                dirs.append(entry.name)
            else:
                nondirs.append(entry.name)

            if not topdown and is_dir:
                if followlinks:
                    walk_into = True
                else:
                    try:
                        is_symlink = entry.is_symlink()
                    except OSError:
                        is_symlink = False
                    walk_into = not is_symlink

                if walk_into:
                    walk_dirs.append(entry.path)

    maxdepth -= 1
    if maxdepth == 0:
        walk_dirs = []

    if topdown:
        yield top, dirs, nondirs
        if maxdepth == 0:
            return
        islink, join = os.path.islink, os.path.join
        for dirname in dirs:
            new_path = join(top, dirname)
            if followlinks or not islink(new_path):
                yield from _walk(new_path, topdown, onerror, followlinks, maxdepth)
    else:
        for new_path in walk_dirs:
            yield from _walk(new_path, topdown, onerror, followlinks, maxdepth)
        yield top, dirs, nondirs

parser = argparse.ArgumentParser()
parser.add_argument('path')
parser.add_argument('-o', '--output')
parser.add_argument('-d', type=int, default=0)
args = parser.parse_args()

with open(args.output, 'w', encoding='utf-8') as f:
    for root, dirs, files in walk(args.path, args.d):
        for name in dirs + files:
            try:
                f.write(os.path.realpath(os.path.join(root,name)) + "\n")
            except UnicodeEncodeError:
                pass

