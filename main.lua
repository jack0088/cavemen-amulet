require"animations"

local window = am.window{
    width = 576,
    height = 576,
    -- TODO: use am.nodes instead, because of bigger images
    projection = math.ortho(-8, 136, -8, 136),
    clear_color = vec4(0, 0, 0, 1)
}

local player = {
    texture = "assets/cavemen_spritesheet.png",
    x = 0,
    x = 0,
    width = 32,
    height = 32,
    frame_width = 8,
    frame_height = 8,
    animations = {
        show_people = {vec2(7, 1), vec2(8, 1), vec2(9, 1), vec2(7, 2)},
        show_monsters = {vec2(8, 2), vec2(7, 3) vec2(8, 3), vec2(9, 3)}
    }
    current_animation = "show_people",
    fps = 6
}

local test_scene = am.group{
    am.rect(0, 0, 128, 128, vec4(.1, .12, .14, 1)),
    am.sprite_animation(player)
}

window.scene = test_scene
