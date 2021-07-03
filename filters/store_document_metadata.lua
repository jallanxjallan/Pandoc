local sredis = require "sredis"
local identifier = require 'identifier'

function Meta(meta)
  local index_key = meta['metadata']
  local document_key = identifier.uuid()
  local filepath = PANDOC_STATE['input_files'][1]
  for key, value in pairs(meta) do
    sredis.query({'hset', document_key, key, pandoc.utils.stringify(value)})
  end
  sredis.query({'hset', index_key, filepath, document_key})
  sredis.expire(document_key, 60)
  sredis.expire(index_key, 60)
end
