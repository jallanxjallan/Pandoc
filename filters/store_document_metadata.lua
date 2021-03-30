--!/usr/local/bin/lua
sredis = require "sredis"
identifier = require "identifier"

function Meta(meta)
  document_key = meta['document_key']
  for k,v in pairs(meta) do
    sredis.query({'hset', document_key, k, pandoc.utils.stringify(v)})
  end
end
