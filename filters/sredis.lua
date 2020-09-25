--!/usr/local/bin/lua

local sredis = {} -- The main table

function redis.index_key(meta)
  project = pandoc.utils.stringify(el.meta['project'])
  identifier = pandoc.utils.stringify(el.meta['identifier'])
  return string.gsub('project:filepath:index','project', project)
end

function sredis.store_value(rkey, key, value)
  pandoc.pipe("redis-cli", {"hset",rkey, key, value}, '')
end

function sredis.document_key(meta)
  project = pandoc.utils.stringify(el.meta['project'])
  identifier = pandoc.utils.stringify(el.meta['identifier'])
  document_key = string.gsub('project:document:identifier','project', project)
  return string.gsub(document_key,'identifier', identifier)
end

return sredis
