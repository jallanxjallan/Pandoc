--!/usr/local/bin/lua
sredis = require "sredis"

function Meta(meta)
  filepath = PANDOC_STATE['input_files'][1]
  inode = sredis.inode(filepath)
  key = sredis.key('document', 'metadata', inode)
  for k,v in pairs(meta) do
    sredis.query({'hset', key, k, pandoc.utils.stringify(v)})
  end
  sredis.expire(key, 3600)
  print(inode,  os.time())
end


