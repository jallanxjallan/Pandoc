local comment_id = 0


function Span(elem)
  comment = elem.attributes['comment']
  if comment == nil then
    return elem
  end
  return elem.content
end
