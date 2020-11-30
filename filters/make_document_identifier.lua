identifier = require "identifier"

function Meta(meta)
  meta['identifier'] = identifier.uuid()
  return meta
end
