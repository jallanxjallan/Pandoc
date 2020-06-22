function Span(s)
  for k,v in pairs(s.attributes) do
    if k == 'author' then
        s = pandoc.RawInline('v',"^['..s.text..']")
        return s
    end
  end
end


