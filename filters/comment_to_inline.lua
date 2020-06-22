function Span(s)
  for k,v in pairs(s.attributes) do
    comment_string = pandoc.utils.stringify(s) 
    if k == 'author' then
        s = pandoc.RawInline(v,"^["..comment_string.."]")
        return s
    end
  end
end


