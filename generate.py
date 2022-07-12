import yaml
from packaging import version
import argparse
from itertools import product
import os
import re

from mugibuilder import *

def flavour_name(qt, compiler, arch):
    return "-".join([qt, compiler, arch])

def build_step(qt, compiler, arch, local):
    name = "flavour {} {} {}".format(qt, compiler, arch)
    c = Commander(name, qt, compiler, arch, local)
    c.aqt_install_qt()
    c.aqt_install_mingw()
    c.call_vcvars()
    c.rmdir('release')
    c.rmfile('.qmake.stash')
    c.rmfile('Makefile*')
    c.qmake()
    c.make()
    c._cmds.append('release\\test4.exe')
    return c.pack()

def main():
    parser = ArgumentParser(qt = True)
    qt, compilers, archs, args = parser.parse_args()
    workflow = Workflow()
    workflow.checkout()
    for qt, compiler, arch in filter_specs_qt(product(qt, compilers, archs)):
        print(qt, compiler, arch)
        workflow.github_step(build_step(qt, compiler, arch, local=False))
        workflow.local_step(build_step(qt, compiler, arch, local=True))
    base = os.path.dirname(__file__)
    workflow.save(base)

if __name__ == "__main__":
    main()
