--!/usr/local/bin/lua

function Meta(meta)
  redis_key = pandoc.utils.stringify(meta['redis_key'])

  for k,v in pairs(meta) do
    data = pandoc.utils.stringify(v)
    pandoc.pipe("redis-cli", {"hset",}, redis_key, k, data)
  end
end
