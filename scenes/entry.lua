local herrsch = require("libraries")

local spritesheet = am.load_image("assets/cavemen_spritesheet.png") -- cache example
local still = {vec2(12, 1)}
local people = {vec2(7, 1), vec2(8, 1), vec2(9, 1), vec2(7, 2)}
local monsters = {vec2(8, 2), vec2(7, 3), vec2(8, 3), vec2(9, 3)}

local anim = herrsch.sprite{
    texture = spritesheet,
    color = vec4(1),
    --position = vec2(64, 64),
    size = vec2(16, 16),
    frame_size = vec2(8, 8),
    angle = 0,
    pivot = vec2(0, .5),
    animations = {
        default = still,
        show_people = people,
        show_monsters = monsters,
        showcase_all = herrsch.table.concat(people, monsters) -- sequence example
    },
    current_animation = "show_monsters",
    fps = 3,
    -- loop = true
}

return am.group{
    am.rect(0, 0, 128, 128, vec4(.1, .12, .14, 1)),
    anim
}
:action(function()
    -- anim.pivot = vec2(math.random(), math.random())
    -- anim.color = vec4(math.random(), math.random(), math.random(), 1)
    -- anim.angle = anim.angle + 1
end)
