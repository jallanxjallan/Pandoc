#!/home/jeremy/Python3.6Env/bin/python
# -*- coding: utf-8 -*-
#
#  script.py
#
#  Copyright 2019 Jeremy Allan <jeremy@jeremyallan.com>

import sys
import fire
from pathlib import Path
from subprocess import run, PIPE

def create_document(filename):
    metadata = dict(
        title = input('Title: '),
        component = input('Component: '),
        source = input('Source: '),
        synopsis = input('Synopsis: '),
        filepath = filename
    )

    base_path = Path.cwd()
    filepath = base_path.joinpath('text', filename)

    args = [f'-M {k}={v}' for k,v in metadata.items()]
    args.append(f'-o {filepath}')
    args.insert(0,'-d create_document')
    args.insert(0, 'pandoc')

    print('Type or Paste document body text')
    content = sys.stdin.read()


    rs = run(args, stdin=PIPE)

    print(rs)

    print (f'created document {filepath}')


if __name__ == '__main__':
    fire.Fire(create_document)
