--!/usr/local/bin/lua
local title

function Header(el)
  if el.level == 1 then
    title = el.content
  end
  return {}
end

function Meta(meta)
  meta.title = title
  return meta
end
