-- mark code blocks with wrap messges

messages = function(key)
  for k, v in pairs(pandoc.Meta) do
    if type(v) == 'table' and v.t == 'MetaInlines' then
      vars["%" .. k .. "%"] = {table.unpack(v)}
    end
  end
end


function format_marker(key)
  print(messages[key])
  padding = '===='
  return {}
   -- pandoc.Para(pandoc.Str(padding), pandoc.Strong(pandoc.Str(text)), pandoc.Str(padding))
end


local start_marker = format_marker('start-passage')
local end_marker = format_marker('end-passage')

function CodeBlock(elem)
  return pandoc.Span(start_marker)
end
