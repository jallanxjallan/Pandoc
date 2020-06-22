local comments = {}

local no = 1
function Span(s)
  for k,v in pairs(s.attributes) do
    if k == 'author' then
      comments[no]= s.content
      s = {}
      no = no + 1
      return s
    end
  end
end

function Meta(meta)
  meta.comments = comments
  return meta
end
