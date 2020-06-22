local style_map = {}

function get_style_map (meta)
  for k, v in pairs(meta) do
    style_map[k] = v
  end
end

function Strong (elem)
  elem.style = style_map['strong']
  return elem
end

function Emph (elem)
  elem.style = style_map['emph']
  return elem
end
