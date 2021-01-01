  --!/usr/local/bin/lua

local meta
local output_filename
local source
local tempdir
local input_file
local output_file
local idn

local function tchelper(first, rest)
     return first:upper()..rest:lower()
end
  -- Add extra characters to the pattern if you need to. _ and ' are
  --  found in the middle of identifiers and English words.
  -- We must also put %w_' into [%w_'] to make it handle normal stuff
  -- and extra stuff the same.
  -- This also turns hex numbers into, eg. 0Xa7d4
  -- str = str:gsub("(%a)([%w_']*)", tchelper)

local remove_identifer =

  {
      Para = function (elem)
        if elem.content[1].text == idn then
          return {}
        else
          return elem
        end
      end
  }

local remove_header  = {
    Header = function(el)
      if el.level == 1 then
        return {}
      end
    end
  }

function export_section(i, section)
  idn = section.identifier


  -- meta['sequence'] = tostring(i)

  local name = idn:gsub("-", " ")

  sub_meta = {}
  sub_meta['title'] = name:gsub("(%a)([%w_']*)", tchelper)
  sub_meta['source'] = source
  local section_filename = output_filename:gsub('.md', '_'..name:gsub(" ", "_"))

  local json_filepath = tempdir..'/'..section_filename..'.json'

  local output_filepath = output_file:gsub(output_filename, section_filename..'.md')

  -- table.remove(section, 1)
  local sub_doc = pandoc.Pandoc(section, sub_meta)
  -- pandoc.walk_block(sub_doc.blocks, remove_identifer)


  pandoc.utils.run_json_filter(sub_doc, 'tee', {json_filepath})

  local args = {
    '--defaults='..'import_document',
    '--output='..output_filepath,
    json_filepath
  }
  -- --
  rs = pandoc.pipe('pandoc', args, '')
  return sub_meta['title']..','..output_filepath
end


function Pandoc(doc)
  meta = doc.meta
  source = meta['source']
  tempdir = pandoc.pipe('mktemp', {'-d'}, ''):gsub('\n', '')
  input_file = PANDOC_STATE['input_files'][1]
  output_file = PANDOC_STATE['output_file']

  output_filename = output_file:match( "([^/]+)$")

  local sections = pandoc.utils.make_sections(false, 1, doc.blocks)
  if #sections == 1 then
    return doc
  else
    for i, section in pairs(sections) do
      if section.identifier ~= nil then
        out_file = export_section(i, section)
        print(out_file)
      end
    end
    os.exit()
  end
end
