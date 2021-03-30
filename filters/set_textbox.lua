--!/usr/local/bin/lua
local text = require("text")
local textboxes = {'anecdote', 'infobox', 'interview'}

function Meta(meta)
  for key, value in pairs(meta) do
    if key == 'component' then
      component = pandoc.utils.stringify(value)
      for i, value2 in pairs(textboxes) do
        name = pandoc.utils.stringify(value2)
        if name == component then
          meta['textbox'] = text.upper(component)
        end
      end
    end
  end
  return meta
end
