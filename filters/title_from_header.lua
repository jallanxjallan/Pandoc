--!/usr/local/bin/lua
local title

function Header(el)
  if el.level == 1 and title == nil then
    title = pandoc.utils.stringify(el)
    return {}
  end
end

function Meta(meta)
  meta.title = title
  return meta
end
