function RawInline(s)
  if not string.find(s.text, "<!--") then
    return s
  else
    s.text = string.sub(s.text,5, -4)
  end
  if string.find(s.text, "?") then
    s.text = "Question: "..s.text
  elseif string.find(s.text, "!") then
    s.text = "Note: "..s.text
  else 
    s.text = "Comment: "..s.text
  end
  return pandoc.Strong(s.text)
end
