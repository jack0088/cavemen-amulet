local herrsch = require("libraries")

local spritesheet = am.load_image("assets/cavemen_spritesheet.png") -- cache example
local people = {vec2(7, 1), vec2(8, 1), vec2(9, 1), vec2(7, 2)}
local monsters = {vec2(8, 2), vec2(7, 3), vec2(8, 3), vec2(9, 3)}

local anim = herrsch.sprite{
    texture = spritesheet,
    color = vec4(1),
    position = vec2(64, 64),
    size = vec2(48, 48),
    frame_size = vec2(8, 8),
    angle = 0,
    pivot = vec2(.5, .5),
    animations = {
        show_people = people,
        show_monsters = monsters,
        showcase_all = herrsch.concat_tables(people, monsters) -- sequence example
    },
    current_animation = "showcase_all",
    fps = 2,
    loop = true
}

return am.group{
    am.rect(0, 0, 128, 128, vec4(.1, .12, .14, 1)),
    anim
}
:action(function()
    anim.angle = anim.angle + 1
    --anim.pivot = vec2(math.random(), math.random())
    --anim.color = vec4(math.random(), math.random(), math.random(), math.random())
    --print(anim.angle)
end)
