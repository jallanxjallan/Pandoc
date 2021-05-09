--!/usr/local/bin/lua

function Header(el)
  el.level = el.level - 1
  return el
end
