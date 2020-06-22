require 'math'

local random = math.random

function Meta(meta)
  if meta.identifier == nil then
    meta.identifier = uuid()
  end
  return meta
end

function uuid()
    local template ='axxxxxxx'
    math.randomseed(os.clock()*100000000000)
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end
