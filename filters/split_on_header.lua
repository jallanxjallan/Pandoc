  --!/usr/local/bin/lua

local meta
local output_filename
local tempdir
local input_file
local output_file

local function tchelper(first, rest)
     return first:upper()..rest:lower()
end
  -- Add extra characters to the pattern if you need to. _ and ' are
  --  found in the middle of identifiers and English words.
  -- We must also put %w_' into [%w_'] to make it handle normal stuff
  -- and extra stuff the same.
  -- This also turns hex numbers into, eg. 0Xa7d4
  -- str = str:gsub("(%a)([%w_']*)", tchelper)

local remove_header  = {
    Header = function(el)
      if el.level == 1 then
        return {}
      end
    end
  }

function export_section(i, section)
  local idn = section.identifier
  table.remove(section, 1)
  local sub_doc = pandoc.Pandoc(section, meta)
  -- meta['sequence'] = tostring(i)
  local seq = float(i)
  local name = idn:gsub("-", " ")
  meta['title'] = name:gsub("(%a)([%w_']*)", tchelper)
  meta['seq'] = seq
  local section_filename = output_filename:gsub('.md', '_'..name:gsub(" ", "_")) + seq

  local json_filepath = tempdir..'/'..section_filename..'.json'

  local output_filepath = output_file:gsub(output_filename, section_filename..'.md')

  pandoc.walk_blocks(section, remove_header)
  table.remove(section, 1)

  pandoc.utils.run_json_filter(sub_doc, 'tee', {json_filepath})
  local args = {,
    '--defaults=import_document',
    '--output='..output_filepath,

    json_filepath
  }
  -- --
  rs = pandoc.pipe('pandoc', args, '')
end


function Pandoc(doc)
  meta = doc.meta
  tempdir = pandoc.pipe('mktemp', {'-d'}, ''):gsub('\n', '')
  input_file = PANDOC_STATE['input_files'][1]
  output_file = PANDOC_STATE['output_file']
  output_filename = output_file:match( "([^/]+)$")

  local sections = pandoc.utils.make_sections(false, 1, doc.blocks)
  for i, section in pairs(sections) do
    if section.identifier ~= nil then
      export_section(i, section)
    end
  end
  return pandoc.Pandoc({})
end
