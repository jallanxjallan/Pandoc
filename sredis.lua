sredis = {}

local document_index = 'document:inode.document_key:index'

function sredis.key(namespace, component, identifier)
  local key = string.gsub('namespace:component:identifier','namespace', namespace)
  key = string.gsub(key,'component', component)
  key = string.gsub(key,'identifier', identifier)
  return key
end

function sredis.expire(key, time)
  pandoc.pipe("redis-cli", {'expire', key, time}, '')
end

function sredis.query(args)
  return pandoc.pipe("redis-cli", args, '')
end

function sredis.inode(filepath)
  line = pandoc.pipe("stat", {'--terse', filepath}, '')
  stat = {}
  for substring in line:gmatch("%S+") do
    table.insert(stat, substring)
  end
  return(stat[8])
end

function sredis.document_key()
  filepath = PANDOC_STATE['input_files'][1]
  inode = sredis.inode(filepath)
  document_key = sredis.query({'hget', document_index, inode})
  return document_key:gsub("\n", "")
end

return sredis
