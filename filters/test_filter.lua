local file_prefix

function Header(elem)
  filepath = 'tester'..elem.identifier..'md'
  rs = pandoc.pipe('pandoc', {}, 'Test input')

end

function Meta(meta)
  file_prefix = meta['file_prefix']
end
