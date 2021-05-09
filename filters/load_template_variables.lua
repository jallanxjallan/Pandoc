local vars = {}
--
function Vars(vars)
  for k,v in pairs(vars) do
    vars["$"..k.."$"] = pandoc.utils.stringify(v)
  end
  print(#vars)
end


-- function replace (el)
--   if vars[el.text] then
--     return pandoc.Span(pandoc.Str('This is a Var'))
--   else
--     return el
--   end
-- end
--
-- return {{Doc = get_vars}, {Str = replace}}
