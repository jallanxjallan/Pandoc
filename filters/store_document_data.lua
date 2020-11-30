--!/usr/local/bin/lua
sredis = require "sredis"


local document_key
local doc
local meta
local filepath
local project_index_key = sredis.key('projects', 'filepath.document', 'index')
local words = 0

function make_document_key()
  project = pandoc.utils.stringify(meta['project'])
  identifier = pandoc.utils.stringify(meta['identifier'])
  document_key = sredis.key(project, 'document', identifier)
end

wordcount = {
  Str = function(el)
    -- we don't count a word if it's entirely punctuation:
    if el.text:match("%P") then
        words = words + 1
    end
  end
}

function store_wordcount()
    -- skip metadata, just count body:
    pandoc.walk_block(pandoc.Div(doc.blocks), wordcount)
    sredis.query({'hset', document_key, 'wordcount', words})
end

function store_metadata()
  sredis.query({'hset', project_index_key, filepath, document_key})
  sredis.query({'hset', document_key, 'filepath', filepath})
  sredis.query({'hset', document_key, 'last_update', os.time()})
  document_data_key = sredis.key(project, 'document.metadata', identifier)
  sredis.query({'hset', document_key, 'metadata', document_data_key})
  for k,v in pairs(meta) do
    sredis.query({'hset', document_data_key, k, pandoc.utils.stringify(v)})
  end
end
  
function Pandoc(content)
  doc = content
  meta = content.meta
  filepath = PANDOC_STATE['input_files'][1]
  
  if pcall(make_document_key) then
    store_metadata()
    store_wordcount()
  else
    sredis.query({'hset', project_index_key, filepath, 'projects:document:invalid'})
    os.exit()
  end

end
