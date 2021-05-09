--!/usr/local/bin/lua
sredis = require "sredis"


local document_key
local words = 0
local content = ''

extract_content = {
  Para = function(el)
    content = content..pandoc.utils.stringify(el)
  end,
  Note = function(el)
    content = content.."This is a note"
  end
}

wordcount = {
  Str = function(el)
    -- we don't count a word if it's entirely punctuation:
    if el.text:match("%P") then
        words = words + 1
    end
  end
}

function store_wordcount(el)
    pandoc.walk_block(pandoc.Div(el.blocks), wordcount)
    sredis.query({'hset', document_key, 'wordcount', words})
end

function store_content(el)
  pandoc.walk_block(pandoc.Div(el.blocks), extract_content)
  sredis.query({'hset', document_key, 'content', content})
end

function Pandoc(el)
  filepath = PANDOC_STATE['input_files'][1]
  document_key = el.meta['document_key']
  sredis.query({'hset', document_key, 'filepath', filepath})
  for key, value in pairs(el.meta) do
    sredis.query({'hset', document_key, key, pandoc.utils.stringify(value)})
  end
  store_wordcount(el)
  store_content(el)
  sredis.expire(document_key, 60)
  os.exit()
end
