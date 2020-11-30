--!/usr/local/bin/lua
sredis = require "sredis"

function Pandoc(doc)
  filepath = PANDOC_STATE['input_files'][1]
  inode = sredis.inode(filepath)
  key = sredis.key('document', 'metadata.reference', inode)
  for k,v in pairs(doc.meta) do
    sredis.query({'hset', key, k, pandoc.utils.stringify(v)})
  end
  sredis.expire(key, 60)
  table.insert (doc.blocks, 1, pandoc.CodeBlock(key, {class='metadata_ref'}))
  return pandoc.Pandoc(doc.blocks)
end
