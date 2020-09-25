json = require "json"
function Pandoc(doc)
    -- skip metadata, just count body:
    m = {}
    for k, v in pairs(doc.meta) do
      m[k] = pandoc.utils.stringify(v)
    end
    io.stderr:write(json.encode(m))
  return doc
end
