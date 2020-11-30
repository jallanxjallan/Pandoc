
local blocks = {}
local below_the_line = 0

store_blocks = {
  Str = function(el)
    -- stop storing blocks after horizonal rule:
    print(pandoc.utils.stringify(el))
    if el.text:match("------") then
        below_the_line = 1
    end
    if below_the_line == 0 then
       table.insert(blocks, el)
    end
    -- print(table.maxn(blocks))
  end
}

function Pandoc(el)
    pandoc.walk_block(pandoc.Div(el.blocks), store_blocks)
    return pandoc.Pandoc(blocks)
end
