local window = am.window{
    width = 576,
    height = 576,
    -- TODO: use am.nodes instead, because of bigger images
    projection = math.ortho(-8, 136, -8, 136),
    clear_color = vec4(0, 0, 0, 1)
}

function test(t)
    local node = am.translate(64, 64) ^ am.text("t", vec4(1, 1, 1, 1))
    node:action(function()
        t.n = t.n + 1
        t.k = t.k*2
        print(t.n, t.k)
    end)
    return node, t
end

local numbers = {n = 0, k = -1}

window.scene = am.rect(0, 0, 128, 128, vec4(.1, .12, .14, 1)) ^ test(numbers)

window.scene:action(function()
    --numbers.k = 0
end)
