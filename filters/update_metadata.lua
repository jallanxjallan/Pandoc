sredis = require "sredis"

function Meta(meta)
    document_key = sredis.document_key(meta)
    for k,v in pairs(meta) do
      value = pandoc.utils.stringify(v)
      sredis.store_value(document_key, k, value)
    end
end
