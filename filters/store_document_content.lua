sredis = require "sredis"
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
    document_key = sredis.document_key(el.meta['namespace'], 'content')
    sredis.query({'set', document_key, content})
    sredis.expire(document_key, 60)
end
