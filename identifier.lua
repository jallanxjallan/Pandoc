require 'math'

identifier = {}

local random = math.random

function identifier.uuid()
    local template ='bxxxxxxx'
    math.randomseed(os.clock()*100000000000)
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end

return identifier
