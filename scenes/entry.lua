local herrsch = require("libraries")

local anim = herrsch.sprite{
    texture = "assets/cavemen_spritesheet.png",
    x = 1,
    y = 0,
    width = 64,
    height = 64,
    frame_width = 8,
    frame_height = 8,
    animations = {
        show_people = {vec2(7, 1), vec2(8, 1), vec2(9, 1), vec2(7, 2)},
        show_monsters = {vec2(8, 2), vec2(7, 3), vec2(8, 3), vec2(9, 3)}
    },
    current_animation = "show_people",
    fps = 6
}

return am.group{
    am.rect(0, 0, 128, 128, vec4(.1, .12, .14, 1)),
    anim
}
:action(function()
    anim.angle = anim.angle + 2*am.frame_time
    print(anim.angle)
end)
