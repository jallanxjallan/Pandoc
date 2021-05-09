--!/usr/local/bin/lua
sredis = require "sredis"

function Pandoc(el)
  document_key = sredis.document_key(el.meta['namespace'], 'filepath')
  sredis.query({'set', document_key, PANDOC_STATE['input_files'][1]})
  sredis.expire(document_key, 60)
end
