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
    for att in  ('ancestor', 'api_version', 'container', 'content', 'doc', 'format', 'get_metadata', 'index', 'location', 'metadata', 'next', 'offset', 'pandoc_reader_options', 'pandoc_version', 'parent'):
        rs = getattr(doc, att)
        # pf.debug(att, rs)



def action(elem, doc):
    pf.debug(doc.offset(elem))

def finalize(doc):
    pass

def main(doc=None):
    return pf.run_filter(action,
                         prepare=prepare,
                         finalize=finalize,
                         doc=doc)


if __name__ == '__main__':
    main()
