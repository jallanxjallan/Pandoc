--!/usr/local/bin/lua
sredis = require "sredis"


local document_key
local metadata_key
local content_key
local namespace
local doc
local meta
local filepath
local inode
local words = 0
local texts = ''
local expiry = 18000

extract_text = {
  Str = function(el)
    -- we don't extract a word if it's entirely punctuation:
    if el.text:match("%P") then
      words = words + 1
      texts = texts..' '..el.text
    end
  end
}

function store_content()
  content_key = sredis.key(namespace, 'document.content', inode)
  sredis.query({'set', content_key, texts})
  sredis.expire(content_key, expiry)
end

function store_metadata()
  metadata_key = sredis.key(namespace, 'document.metadata', inode)
  for k, v in pairs(meta) do
    sredis.query({'hset', metadata_key, k, pandoc.utils.stringify(v)})
  end
  sredis.expire(metadata_key, expiry)
end

function Pandoc(content)
  doc = content
  meta = content.meta
  filepath = PANDOC_STATE['input_files'][1]
  inode = sredis.inode(filepath)
  namespace = meta['namespace']
  document_key = sredis.key(namespace, 'document.status', inode)
  pandoc.walk_block(pandoc.Div(doc.blocks), extract_text)

  store_metadata()
  store_content()

  sredis.query({'hset', document_key, 'filepath', filepath})
  sredis.query({'hset', document_key, 'metadata', metadata_key})
  sredis.query({'hset', document_key, 'wordcount', words})
  sredis.query({'hset', document_key, 'content', content_key})
  sredis.query({'hset', document_key, 'last_update', os.time()})
  sredis.expire(document_key, expiry)
end
