sredis = require "sredis"
identifier = require "identifier"
content = ''

extract_content = {
  Para = function(el)
    content = content..pandoc.utils.stringify(el)
  end,
  Note = function(el)
    content = content.."This is a note"
  end
}

function Pandoc(el)
    -- skip metadata, just count body:
    pandoc.walk_block(pandoc.Div(el.blocks), extract_content)
    document_key = el.meta['document_key']
    sredis.query({'hset', document_key, 'content', content})
end
