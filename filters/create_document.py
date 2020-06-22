#!/home/jeremy/Python3.6Env/bin/python
# -*- coding: utf-8 -*-
#
#  script.py
#
#  Copyright 2019 Jeremy Allan <jeremy@jeremyallan.com>
"""Store document metadata to redis index
"""

import panflute as pf

def action(e, doc):
    pass

def finalize(doc):
    metadata = dict(
        title = input('Title: '),
        component = input('Component: '),
        source = input('Source: '),
        synopsis = input('Synopsis: ')
    )
    for key, value in metadata.items():
        doc.meta[key] = value
    

if __name__ == '__main__':
    pf.run_filter(action, finalize=finalize)
