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

def format_message(text):
    plen = 20
    padding = '=' * plen
    return pf.Para(pf.Str(padding), pf.Strong(pf.Str(text)), pf.Str(padding))

def prepare(doc):
    doc.start_marker = format_message(doc.get_metadata('start-passage'))
    doc.end_marker = format_message(doc.get_metadata('end-passage'))

def action(elem, doc):
    if isinstance(elem, pf.CodeBlock):
        return [doc.start_marker, elem, doc.end_marker]

def finalize(doc):
    pass
def main(doc=None):
    return pf.run_filter(action,
                         prepare=prepare,
                         finalize=finalize,
                         doc=doc)

if __name__ == '__main__':
    main()
