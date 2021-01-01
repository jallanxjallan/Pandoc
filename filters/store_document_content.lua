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
    content_key = sredis.component_key(el.meta, 'content')
    sredis.query({'set', content_key, content})
end
