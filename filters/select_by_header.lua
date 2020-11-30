  --!/usr/local/bin/lua
local doc
local section_heading

function get_section_heading(meta)
  section_heading = meta['section_heading']:gsub(' ', '-'):lower()
end

function Pandoc(doc)
  local status, retval = pcall(get_section_heading,doc.meta)
  if status == true then
    local sections = pandoc.utils.make_sections(false, 1, doc.blocks)
    for i, section in pairs(sections) do
        if section.identifier == section_heading then
          doc = pandoc.Pandoc(section, doc.meta)
          break
        end
    end
  end
  return doc
end
