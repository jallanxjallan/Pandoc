sredis = {}

function sredis.expire(key, time)
  pandoc.pipe("redis-cli", {'expire', key, time}, '')
end

function sredis.query(args)
  return pandoc.pipe("redis-cli", args, '')
end

function sredis.inode(filepath)
  local line = pandoc.pipe("stat", {'--terse', filepath}, '')
  local stat = {}
  for substring in line:gmatch("%S+") do
    table.insert(stat, substring)
  end
  return(stat[8])
end

function sredis.document_component_key(component, filepath)
  local dck = 'inode:component'
  local inode = sredis.inode(filepath)
  dck = dck:gsub('inode', inode)
  dck = dck:gsub('component', component)
  component_key = sredis.query({'hget', 'document:index:inode.key', dck})
  return component_key:gsub('\n$', '')
end

return sredis
