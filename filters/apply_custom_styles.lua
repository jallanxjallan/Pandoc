
local vars = {}

function get_vars (meta)
  for k, v in pairs(meta) do
    if type(v) == 'table' and v.t == 'MetaInlines' then
      vars["%" .. k .. "%"] = {table.unpack(v)}
    end
  end
end

function replace (el)
  if vars[el.text] then
    return pandoc.Span(vars[el.text])
  else
    return el
  end
end


function Strong (elem)
  return pandoc.Str('strong')
end

function Emph (elem)
    return pandoc.Str(vars['emph'])
end

return {{Meta = get_vars}, {Str = replace}}
