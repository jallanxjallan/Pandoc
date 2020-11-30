  --!/usr/local/bin/lua

local function tchelper(first, rest)
     return first:upper()..rest:lower()
end
  -- Add extra characters to the pattern if you need to. _ and ' are
  --  found in the middle of identifiers and English words.
  -- We must also put %w_' into [%w_'] to make it handle normal stuff
  -- and extra stuff the same.
  -- This also turns hex numbers into, eg. 0Xa7d4
  -- str = str:gsub("(%a)([%w_']*)", tchelper)

function Pandoc(doc)
  local rows = {}

  local sections = pandoc.utils.make_sections(false, 1, doc.blocks)
  for i, section in pairs(sections) do
      local idn = section.identifier
      local sub_doc = pandoc.Pandoc(section)
      table.insert(rows, sub_doc)
    end
    return pandoc.Pandoc(pandoc.Table({}, {}, {}, {}, rows))
end
