--!/usr/local/bin/lua
function Header(elem)
  elem = pandoc.Para(pandoc.Str('qqq'..elem.identifier..'xxx'))
  return elem
end
