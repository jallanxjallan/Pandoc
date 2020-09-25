#!/home/jeremy/Python3.6Env/bin/python
# -*- coding: utf-8 -*-
#
#  script.py
#
#  Copyright 2019 Jeremy Allan <jeremy@jeremyallan.com>
"""Extract metadata to redis
"""


import panflute as pf
import redis



r = redis.Redis()

def action(e, doc):
    pass

def finalize(doc):
    for key, value in doc.get_metadata().items():
        r.hset('pandoc:document:metadata', key, value)
        r.expire('pandoc:document:metadata', 5)


if __name__ == '__main__':
    pf.run_filter(action, finalize=finalize)
