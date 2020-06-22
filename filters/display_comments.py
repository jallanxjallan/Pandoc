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
    if isinstance(elem, pf.RawInline):
        if elem.format == 'html':
            if elem.text.startswith('<!--') and elem.text.endswith('-->'):
                comment = elem.text.replace('<!--', 'question: ').replace('-->', '?')
                token = [pf.Emph(pf.Inline(text=comment))]
                elem = token
                

def main(doc=None):
    pf.run_filter(action, doc=doc)


if __name__ == '__main__':
    main()
