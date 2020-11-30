sredis = require "sredis"

function Meta(meta)
  index_key = sredis.index_key('projects', 'filepath.last_update')
  filepath = PANDOC_STATE['input_files'][1]
  sredis.query({'hset', index_key, filepath, os.time()})
  os.exit()
end
