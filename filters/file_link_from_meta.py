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

def action(elem, doc):
    return elem

def finalize(doc):
    try:
        filepath = doc.get_metadata('filepath')
        label = 'Link'
    except:
        filepath = ''
        label = 'No link'
    doc.content.insert(0, pf.Para(pf.Link(pf.Str(label), url=filepath)))
    return doc

def main(doc=None):
    return pf.run_filter(action,
                         finalize=finalize,
                         doc=doc)

if __name__ == '__main__':
    main()
