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
import dateparser
import redis

def make_slugline(elem, doc):
    key = pf.stringify(elem)
    date = doc.r.hget(key, 'date')
    location = doc.r.hget(key, 'location')
    timestamp = dateparser.parse(date)
    try:
        ds = timestamp.strftime("%B %Y")
    except AttributeError:
        pass

    if ds == doc.current_ds:
        slugline = location
    else:
        doc.current_ds = ds
        prefix = 'Flashback to'  if timestamp.year < 1988 else 'Main Timeline'
        slugline  = f'{prefix}: {ds} -- {location}'
    return slugline

def prepare(doc):
    doc.current_ds = ''
    doc.r = redis.Redis(decode_responses=True)

def action(elem, doc):
    if isinstance(elem, pf.CodeBlock):
        if 'metadata_ref' in elem.classes:
            slugline = make_slugline(elem, doc)
            if slugline:
                return  pf.Header(pf.Str(slugline), level=1)
            else:
                return []
    return elem






def main(doc=None):
    return pf.run_filter(action,
                         prepare=prepare,
                         doc=doc)

if __name__ == '__main__':
    main()
