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
  tempdir = pandoc.pipe('mktemp', {'-d'}, ''):gsub('\n', '')
  local meta = doc.meta
  local input_file = PANDOC_STATE['input_files'][1]
  local output_file = PANDOC_STATE['output_file']
  local output_filename = output_file:match( "([^/]+)$")

  local sections = pandoc.utils.make_sections(false, 1, doc.blocks)
  for i, section in pairs(sections) do
      local idn = section.identifier
      local sub_doc = pandoc.Pandoc(section, meta)
      -- meta['sequence'] = tostring(i)
      local seq = tostring(i)
      local name = idn:gsub("-", " ")
      meta['title'] = name:gsub("(%a)([%w_']*)", tchelper)
      local section_filename = output_filename:gsub('.md', '_'..name:gsub(" ", "_"))

      local json_filepath = tempdir..'/'..section_filename..'.json'

      local output_filepath = output_file:gsub(output_filename, section_filename..'.md')

      pandoc.utils.run_json_filter(sub_doc, 'tee', {json_filepath})
      local args = {'-s',
        '--defaults=split_defaults',
        '--output='..output_filepath,
        json_filepath
      }
      -- --
      rs = pandoc.pipe('pandoc', args, '')

    end
    return pandoc.Pandoc({})
end
