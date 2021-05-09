--!/usr/local/bin/lua
function Meta(meta)
  output_filepath = PANDOC_STATE['output_file']
  output_filename = output_filepath:match( "([^/]+)$")
  output_extention = output_filename:match("[^.]+$")
  output_stem = output_filename:gsub("."..output_extention, '')
  meta.title = output_stem
  return meta
end
