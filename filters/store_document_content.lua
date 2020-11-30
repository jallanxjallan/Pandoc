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
    key = sredis.document_key('document.content', el.meta)
    sredis.query({'set', key, content})
end
