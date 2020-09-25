#!/home/jeremy/Python3.6Env/bin/python
# -*- coding: utf-8 -*-
#
#  script.py
#
#  Copyright 2019 Jeremy Allan <jeremy@jeremyallan.com>
"""Extract document to redis
"""

import panflute as pf
import redis

r = redis.Redis()

def action(e, doc):
    pass

def finalize(doc):
    metadata = doc.get_metadata()
    identifier = metadata['identifier']
    project = metadata['project']
    document_key = f'{project}:document:{identifier}'
    metadata_key = f'{project}:metadata:{identifier}'
    content_key  = f'{project}:content:{identifier}'
    for key, value in metadata.items():
        r.hset(metadata_key, key, value)
    r.set(content_key, pf.stringify(doc))
    for name in ('document', 'metadata', 'content'):
        r.expire(f'{project}:{name}:{identifier}', 60)
    r.hset(document_key, 'metadata', metadata_key)
    r.hset(document_key, 'content', content_key)
    doc.content = pf.convert_text(content_key)


if __name__ == '__main__':
    pf.run_filter(action, finalize=finalize)
