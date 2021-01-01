--!/usr/local/bin/lua
sredis = require "sredis"
identifier = require "identifier"

function Meta(meta)
  metadata_key = sredis.component_key(meta, 'metadata')
  for k,v in pairs(meta) do
    sredis.query({'hset', metadata_key, k, pandoc.utils.stringify(v)})
  end
end
