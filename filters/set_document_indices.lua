sredis = require "sredis"

function Meta(meta)
  filepath = PANDOC_STATE['input_files'][1]
  document_key = sredis.document_key(meta)
  filepath_index_key = sredis.index_key('projects', 'filepath.document')
  document_index_key = sredis.index_key('projects', 'document.filepath')
  update_index_key = sredis.index_key('projects', 'filepath.last_update')
  sredis.query({'hset', document_index_key, document_key, filepath})
  sredis.query({'hset', filepath_index_key, filepath, document_key})
  sredis.query({'hset', update_index_key, filepath, os.time()})
end
