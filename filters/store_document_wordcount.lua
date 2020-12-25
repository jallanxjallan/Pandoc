sredis = require "sredis"
words = 0

wordcount = {
  Str = function(el)
    -- we don't count a word if it's entirely punctuation:
    if el.text:match("%P") then
        words = words + 1
    end
  end
}

function Pandoc(el)
    -- skip metadata, just count body:
  pandoc.walk_block(pandoc.Div(el.blocks), wordcount)

  document_key = sredis.document_key()
  print(document_key..'key')
  sredis.query({'hset', document_key, 'wordcount', words})
end
