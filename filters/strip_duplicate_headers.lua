local last_header = 'No Date'
function Header(elem)
  header_text = pandoc.utils.stringify(elem)
  if header_text == last_header then
    return {}
  else
    last_header = header_text
    return elem
  end
end
