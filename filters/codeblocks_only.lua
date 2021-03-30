
function CodeBlock(block)
  return pandoc.Para(pandoc.Str(block.text))
end

function Para(elem)
  return {}
end
