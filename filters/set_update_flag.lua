sredis = require "sredis"

function Meta(meta)
  index_key = sredis.index_key(meta)
  filepath = PANDOC_STATE['input_files'][1]
  sredis.store_value(index_key, filepath, os.time())
  os.exit(0)
end
