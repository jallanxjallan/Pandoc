local sredis = require "sredis"
local identifier = require 'identifier'
local content = ''

extract_content = {
  Para = function(el)
    content = content..pandoc.utils.stringify(el)
  end
}

function Pandoc(el)
  local index_key = el.meta['content']
  local document_key = identifier.uuid()
  local filepath = PANDOC_STATE['input_files'][1]
  pandoc.walk_block(pandoc.Div(el.blocks), extract_content)
  sredis.query({'set', document_key, content})
  sredis.query({'hset', index_key, filepath, document_key})
  sredis.expire(document_key, 60)
  sredis.expire(index_key, 60)
end
