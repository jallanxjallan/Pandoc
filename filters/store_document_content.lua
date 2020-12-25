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
    document_key = sredis.document_key()
    content_key = sredis.key('document', 'content', identifier.uuid())
    sredis.query({'set', content_key, content})
    sredis.expire(content_key, 3600)
    sredis.query({'hset', document_key, 'content', content_key})
end
