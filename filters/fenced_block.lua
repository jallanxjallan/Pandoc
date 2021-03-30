--!/usr/local/bin/lua


function Pandoc(doc)
  local title
  local component
  for k,v in pairs(doc.meta) do
    if k == "title" then
      title = pandoc.utils.stringify(v)
    end
    if k == "component" then
      component = pandoc.utils.stringify(v)
    end
  end
  if title ~= nil and component ~= nil then

    table.insert (doc.blocks, 1, pandoc.Header(1, title))
    table.insert(doc.blocks, 1, pandoc.Para(pandoc.Str('---'..component..'---')))
    local alen = #doc.blocks
    table.insert(doc.blocks, alen+1, pandoc.Para(pandoc.Str('---end of '..component..'---')))
  end
  return doc
  -- return pandoc.Pandoc(doc.blocks)
end
