--!/usr/local/bin/lua

text = require "text"

function Pandoc(doc)
  local date = 'None'
  local location = 'None'
  for k,v in pairs(doc.meta) do
    if k == "date" then
      date =  pandoc.utils.stringify(v)
    elseif k == 'location' then
      location = pandoc.utils.stringify(v)
    end
  end
  local slugline = text.upper(date)..':'..location
  table.insert (doc.blocks, 1, pandoc.Header(1, slugline))
  return pandoc.Pandoc(doc.blocks)
end
