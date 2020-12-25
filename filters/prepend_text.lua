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
  if first_block == nil then
    filename = PANDOC_STATE['input_files'][1]
    print('No text found in'..filename)
  else
    for k,v in pairs(first_block) do
      table.insert(v, 1, pandoc.Space())
      table.insert(v, 1, pandoc.Strong(pandoc.Span(text)))
      break
    end
  end
  return pandoc.Pandoc(doc.blocks)
end
