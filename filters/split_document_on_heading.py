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

def output_section(doc):
    text = ' '.join(doc.section_content)
    title = doc.current_heading
    filepath = Path(doc.file_prefix + title.lower().replace(' ', '_')
    filepath = filename.with_suffix('.md')
                                   f'--metadata=seq:{doc.seq}',
                                   f'--metadata=project:{doc.project}',
                                   f'-o {str(filename)}',
                                   '--defaults=create_document'])

def prepare(doc):
    doc.headers = []

def action(elem, doc):
    if isinstance(elem, pf.Header) and elem.level == 1:
        if doc.current_heading and len(doc.section_content) > 10:
            output_section(doc)
            doc.section_content = []
            doc.current_heading = pf.stringify(elem)
            doc.seq = str(float(doc.seq) + float(doc.seq_inc))
            doc.current_heading = pf.stringify(elem)
        else:
            doc.current_heading = pf.stringify(elem)
            doc.section_content = []
    else:
        doc.section_content.append(pf.stringify(elem))

def finalize(doc):
    doc.project = doc.get_metadata('project')
    doc.seq = 1
    doc.file_prefix = doc.get_metadata('output-file-prefix')
    doc.output_dir =  doc.get_metadata('output-dir')

def main(doc=None):
    return pf.run_filter(action,
                         prepare=prepare,
                         finalize=finalize,
                         doc=doc)

if __name__ == '__main__':
    main()
