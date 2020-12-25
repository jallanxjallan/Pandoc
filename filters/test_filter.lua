
function Pandoc(doc)
  local sections = pandoc.utils.make_sections(false, 1, doc.blocks)
  for i, section in pairs(sections) do
    if section.identifier ~= nil then
      print('empty section')
    else
      print (section.identifier)
    end
  end
end
