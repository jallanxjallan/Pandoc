sredis = require "sredis"


function Meta(meta)
  index_key = sredis.index_key(meta)
  print('this is the '..index_key)
  -- print(PANDOC_STATE['input_files'][1])
  -- rs = pandoc.pipe('redis-cli', {'hset', 'test:lua', 'msg', 'This is a test' }, '')
end
