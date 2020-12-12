--!/usr/local/bin/lua

text = require "text"

function Pandoc(doc)
  local date = 'None'
  local location = 'None'
  for k,v in pairs(doc.meta) do
    if k == "prepend" then
      text =  pandoc.utils.stringify(v)
    end
  end

  first_block = doc.blocks[1]
  for k,v in pairs(first_block) do
    table.insert(v, 1, pandoc.Space())
    table.insert(v, 1, pandoc.Strong(pandoc.Span(text)))
    break
  end
  return pandoc.Pandoc(doc.blocks)
end
