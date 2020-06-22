#!/home/jeremy/Python3.6Env/bin/python
# -*- coding: utf-8 -*-
#
#  script.py
#
#  Copyright 2019 Jeremy Allan <jeremy@jeremyallan.com>

import panflute as pf

def prepare(doc):
    doc.comment_key = doc.get_metadata('document_key').replace('document', 'comment')
    # r.expire(doc.comment_key, 600)

def action(elem, doc):
    if isinstance(elem, pf.RawInline):
        if elem.format == 'html':
            if elem.text.startswith('<!--') and elem.text.endswith('-->'):
                comment = elem.text.replace('<!--', '').replace('-->', '')
                # r.rpush(doc.comment_key, comment)

def main(doc=None):
    pf.run_filter(action, prepare=prepare, doc=doc)


if __name__ == '__main__':
    main()
