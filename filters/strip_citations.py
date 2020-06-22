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
    if isinstance(elem, pf.Note):
        pf.debug(elem)




def main(doc=None):
    pf.run_filter(action, doc=doc)


if __name__ == '__main__':
    main()
