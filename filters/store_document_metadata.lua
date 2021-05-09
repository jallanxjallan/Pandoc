local sredis = require "sredis"

function Meta(meta)
  if meta['namespace'] == nil then
    return {}
  end
  local document_key = sredis.document_key(meta['namespace'], 'metadata')
  for key, value in pairs(meta) do
    sredis.query({'hset', document_key, key, pandoc.utils.stringify(value)})
  end
  sredis.expire(document_key, 60)
end
