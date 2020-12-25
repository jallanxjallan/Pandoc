--!/usr/local/bin/lua
sredis = require "sredis"
identifier = require "identifier"

function Meta(meta)
  document_key = sredis.document_key()
  metadata_key = sredis.key('document', 'metadata', identifier.uuid())
  for k,v in pairs(meta) do
    sredis.query({'hset', metadata_key, k, pandoc.utils.stringify(v)})
  end
  sredis.expire(metadata_key, 3600)
  sredis.query({'hset', document_key, 'metadata', metadata_key})
end
