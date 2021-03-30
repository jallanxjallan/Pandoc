  --!/usr/local/bin/lua

identifier = require "identifier"
sredis = require "sredis"

local meta
local output_filename
local source
local tempdir
local input_file
local output_file
local idn
local seq = 0
local title

function store_metadata(meta, identifier)
  document_key = sredis.key('document', 'metadata', identifier)
  for k,v in pairs(meta) do
    sredis.query({'hset', document_key, k, pandoc.utils.stringify(v)})
  end
  sredis.expire(document_key, 60)
  return document_key
end

local function tchelper(first, rest)
     return first:upper()..rest:lower()
end
  -- Add extra characters to the pattern if you need to. _ and ' are
  --  found in the middle of identifiers and English words.
  -- We must also put %w_' into [%w_'] to make it handle normal stuff
  -- and extra stuff the same.
  -- This also turns hex numbers into, eg. 0Xa7d4
  -- str = str:gsub("(%a)([%w_']*)", tchelper)


remove_header = {
    Header = function(el)
      if el.level == 1
        title = el.text
        return {}
      end
    end
}

function export_section(i, section)
  seq = seq + 1

  -- meta['sequence'] = tostring(i)

  local name = section.identifier:gsub("-", " ")

  sub_meta = {}
  sub_meta['identifier'] = identifier()
  sub_meta['title'] = remove_header()
  -- name:gsub("(%a)([%w_']*)", tchelper)
  sub_meta['source'] = source
  sub_meta['seq'] = tostring(seq)
  sub_meta['status'] = 'Imported'

  local section_filename = output_filename:gsub('.md', '_'..name:gsub(" ", "_"))

  local json_filepath = tempdir..'/'..section_filename..'.json'

  local output_filepath = output_file:gsub(output_filename, section_filename..'.md')

  local sub_doc = pandoc.Pandoc(section.content, sub_meta)

  -- pandoc.walk_block(pandoc.Div(sub_doc), remove_header)

  pandoc.utils.run_json_filter(sub_doc, 'tee', {json_filepath})

  local args = {
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
        document_key = export_section(i, section)
        if document_key ~= nil then
          print(document_key)
        end
      end
    end
    os.exit()
  end
end
