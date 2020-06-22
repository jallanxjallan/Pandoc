--!/usr/local/bin/lua

text = require "text"

function Pandoc(doc)
  local title = 'None'
  for k,v in pairs(doc.meta) do
    if k == "title" then
      title =  pandoc.utils.stringify(v)
    end
  end
  table.insert (doc.blocks, 1, pandoc.Header(1, text.upper(title)))
  return pandoc.Pandoc(doc.blocks)
end
