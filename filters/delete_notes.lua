--!/usr/local/bin/lua
function Note(el)
  return {}
end


   --  for i, section in pairs(sections) do
   --
   --    cwd = pandoc.system.get_working_directory ()
   --    dir = doc.meta["target-dir"]
   --    prefix = doc.meta["prefix"]
   --    template = doc.meta["template"]
   --    name =  section.identifier
   --    filename = string.format("%s/%s/%s_%s.md", cwd, dir, prefix, name)
   --    args = {}
   --    for key, value in pairs(doc.meta) do
   --      args[key] = string.format("-M %s=%s", key, value)
   --    end
   --    table.insert(args, string.format("-M title=%s", name))
   --    table.insert(args, string.format("-M sequence=%s", i))
   --    table.insert(args, "--template=edit_document.tpl")
   --    table.insert(args, "-s")
   --    table.insert(args, "-f=markdown")
   --    table.insert(args, "-t=markdown")
   --
   --    text = pandoc.utils.stringify(section)
   --    output = pandoc.pipe('pandoc', args, text)
   --    outfile = io.open (filename, "w")
   --    outfile:write(output)
   --    io.close(outfile)
   --
   -- end
