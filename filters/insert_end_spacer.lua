function Pandoc(doc)
  table.insert(doc.blocks, #doc.blocks+1, pandoc.RawBlock("\n"))
end
