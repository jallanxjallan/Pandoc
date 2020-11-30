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
    filepath = PANDOC_STATE['input_files'][1]
    inode = sredis.inode(filepath)
    key = sredis.key('document', 'metadata', inode)
    -- skip metadata, just count body:
    pandoc.walk_block(pandoc.Div(el.blocks), wordcount)
    sredis.query({'hset', key, 'words', words})
    sredis.expire(key, 3600)
end
