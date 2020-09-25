function RawInline(s)
  if not string.find(s.text, "<!--") then
    return s
  else
    s.text = string.sub(s.text,5, -4)
  end
  if string.find(s.text, "?") then
    return s
  elseif string.find(s.text, "!") then
    return s
  else
    s.text = "Comment: "..s.text
  end
  return pandoc.Strong(s.text)
end
