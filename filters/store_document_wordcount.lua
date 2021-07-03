local sredis = require "sredis"
local identifier = require 'identifier'
local words = 0

wordcount = {
  Str = function(el)
    -- we don't count a word if it's entirely punctuation:
    if el.text:match("%P") then
        words = words + 1
    end
  end
}

function Pandoc(el)
  local index_key = el.meta['wordcount']
  local document_key = identifier.uuid()
  local filepath = PANDOC_STATE['input_files'][1]
  pandoc.walk_block(pandoc.Div(el.blocks), wordcount)
  sredis.query({'set', document_key, words})
  sredis.query({'hset', index_key, filepath, document_key})
  sredis.expire(document_key, 10)
  sredis.expire(index_key, 10)
end
