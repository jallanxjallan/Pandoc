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
import spacy

def prepare(doc):
    nlp = spacy.load('en_core_web_sm')
    ndoc = nlp(pf.stringify(doc))
    doc.pnouns = set([n.text for n in ndoc if n.pos_ == 'PROPN'])

def action(elem, doc):
    if isinstance(elem, pf.Strong):
        for i in range(5):
            e = elem.parent.content[i]
            if isinstance(e, pf.Str):
                if e.text in doc.pnouns:
                    break
                else:
                    elem.parent.content[i] = pf.Str(e.text.lower())
                    break
    return elem

def main(doc=None):
    return pf.run_filter(action,
                         prepare=prepare,
                         doc=doc)

if __name__ == '__main__':
    main()
