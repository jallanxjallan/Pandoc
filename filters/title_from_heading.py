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
    if isinstance(elem, pf.Header) and elem.level == 1:
        doc.metadata['title'] = pf.stringify(elem)
        return []
    return elem

def main(doc=None):
    return pf.run_filter(action,
                         doc=doc)

if __name__ == '__main__':
    main()
