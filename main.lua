local animation = require("animations")

local window = am.window{
    width = 576,
    height = 576,
    projection = math.ortho(-8, 136, -8, 136),
    clear_color = vec4(0, 0, 0, 1)
}

local animated_sprite = animation{
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

local scene = am.group{
    am.rect(0, 0, 128, 128, vec4(.1, .12, .14, 1)),
    animated_sprite
}

window.scene = scene

window.scene:action(function()
    animated_sprite.x = animated_sprite.x + am.frame_time
    animated_sprite.y = animated_sprite.y + am.frame_time
end)
