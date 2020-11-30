sredis = require "sredis"

function Meta(meta)
  key = sredis.document_key(meta)
  filepath = PANDOC_STATE['input_files'][1]
  sredis.query({'hset', key, 'last_update', os.time()})
  os.exit()
end
