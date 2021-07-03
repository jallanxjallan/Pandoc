sredis = require "sredis"
local document_key
local links

links = {
  Link = function(el)
    sredis.query({'rpush', document_key, el.target})
  end
}

function Pandoc(el)
    -- skip metadata, just count body:
  document_key = sredis.document_component_key('links')
  pandoc.walk_block(pandoc.Div(el.blocks), links)
end
