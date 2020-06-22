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
    doc.code_blocks = []

def action(elem, doc):
    if isinstance(elem, pf.CodeBlock):
        doc.code_blocks.append(elem.text)

def finalize(doc):
    text = '\n\n'.join(doc.code_blocks)
    doc.content = pf.convert_text(text)

def main(doc=None):
    return pf.run_filter(action,
                         prepare=prepare,
                         finalize=finalize,
                         doc=doc)


if __name__ == '__main__':
    main()
