#!/home/jeremy/Python3.6Env/bin/python
# -*- coding: utf-8 -*-
#
#  script.py
#
#  Copyright 2019 Jeremy Allan <jeremy@jeremyallan.com>
"""Store document metadata to redis index
"""

import panflute as pf

def action(e, doc):
    pass

def finalize(doc):
    metadata = doc.get_metadata()
    metadata_key = metadata['document_key'].replace('document', 'metadata')
    del metadata['document_key']
    # del metadata['filepath']
    # r = Redis()
    # r.hmset(metadata_key, metadata)
    # r.expire(metadata_key, 600)

if __name__ == '__main__':
    pf.run_filter(action, finalize=finalize)
