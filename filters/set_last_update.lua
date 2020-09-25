
function Header(elem)
  filepath = 'tester'..elem.identifier..'md'
  rs = pandoc.pipe('pandoc', {}, 'Test input')

end

function Meta(meta)
  filepath = PANDOC_STATE['input_files'][1] 

  rs = pandoc.pipe('redis-cli', {'hset', 'test:lua', 'msg', 'This is a test' }, '')

end
