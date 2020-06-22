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
from pathlib import Path
from collections import defaultdict

def output_section(doc, heading, content):
    text = ' '.join([pf.stringify(c) for c in content])
    title = heading
    filename = Path(title.lower().replace(' ', '_')).with_suffix('.md')
    pf.run_pandoc(text=text, args=[f'--metadata=title:{title}',
                                   f'-o {str(filename)}',
                                   '--defaults=create_document'])

def prepare(doc):
    doc.current_heading = None
    doc.section_content = defaultdict(list)
    # doc.section_content = []
    # doc.project = doc.get_metadata('project')
    # doc.seq = str(float(doc.get_metadata('seq')) + .01)

def action(elem, doc):
    if isinstance(elem, pf.Header) and elem.level == 1:
        doc.current_heading = pf.stringify(elem)
    else:
        doc.section_content[doc.current_heading].append(elem)
    #     if doc.current_heading and len(doc.section_content) > 50:
    #         output_section(doc)
    #         doc.section_content = []
    #         doc.current_heading = pf.stringify(elem)
    #         doc.seq = str(float(doc.seq) + .01)
    #         doc.current_heading = pf.stringify(elem)
    #     else:
    #         doc.current_heading = pf.stringify(elem)
    #         doc.section_content = []
    # else:
    #     doc.section_content.append(pf.stringify(elem))

def finalize(doc):
    for heading, content in doc.section_content.items():
        try:
            output_section(doc, heading, content)
        except Exception as e:
            pf.debug(e)
    doc.content = []

def main(doc=None):
    return pf.run_filter(action,
                         prepare=prepare,
                         finalize=finalize,
                         doc=doc)

if __name__ == '__main__':
    main()
