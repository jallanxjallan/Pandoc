sredis = {}

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

function sredis.document_key(namespace, component)
  local key = string.gsub('namespace:component:identifier','namespace', namespace)
  key = string.gsub(key,'component', component)
  return string.gsub(key,'identifier', sredis.inode(PANDOC_STATE['input_files'][1]))
end

return sredis
