#!/home/jeremy/Python3.6Env/bin/python
# -*- coding: utf-8 -*-
#
#  script.py
#
#  Copyright 2019 Jeremy Allan <jeremy@jeremyallan.com>

"""
Pandoc filter using panflute
"""

import panflute as pf


def prepare(doc):
    doc.title = doc.get_metadata('title')


def action(elem, doc):
    return elem

def finalize(doc):
    try:
        doc.content.insert(0, pf.Header(pf.Str(doc.title), level=1))
    except:
        return doc
    return doc

def main(doc=None):
    return pf.run_filter(action,
                         prepare=prepare,
                         finalize=finalize,
                         doc=doc)

if __name__ == '__main__':
    main()
