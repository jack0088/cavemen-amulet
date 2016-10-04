function sprite_animation(object)
    object.width = object.width or object.frame_width
    object.height = object.height or object.frame_height
    object.verts = {object.x, object.y, object.x + object.width, object.y + object.height}
    object.uv = {0, 0, 1, 1}
    object.color = object.color or vec4(1)
    object.current_frame = 1
    object.fps = object.fps or 24

    local time = 0

    local texture_image = am.texture2d(object.texture)
    local node = am.use_program(am.shaders.texturecolor2d)
        ^ am.blend"alpha"
        ^ am.bind{
            vert = am.rect_verts_2d(unpack(object.verts)),
            uv = am.rect_verts_2d(unpack(object.uv)),
            tex = texture_image,
            color = object.color
        }
        ^ am.draw("triangles", am.rect_indices())

    node:action(function()
        if not time
        or time <= am.current_time()
        then
            local cols = texture_image.width / object.frame_width
            local rows = texture_image.height / object.frame_height
            local w = 1 / cols
            local h = 1 / rows
            local u = w * (object.animations[object.current_animation][object.current_frame].x - 1)
            local v = h * (rows - object.animations[object.current_animation][object.current_frame].y)

            time = am.current_time() + 1 / object.fps
            object.uv = {u, v, u + w, v + h}
            node"bind".uv = am.rect_verts_2d(unpack(object.uv))

            if object.animations[object.current_animation][object.current_frame + 1] then
                object.current_frame = object.current_frame + 1
            else
                object.current_frame = 1
            end
        end
    end)

    node:tag"sprite_animation"

    return node
end

local window = am.window{
    width = 576,
    height = 576,
    projection = math.ortho(-8, 136, -8, 136),
    clear_color = vec4(0, 0, 0, 1)
}

local sprite = {
    texture = "../assets/cavemen_spritesheet.png",
    x = 0,
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
    fps = 3
}

local test = {
    texture = "../assets/cavemen_spritesheet.png",
    x = 64,
    y = 0,
    width = 64,
    height = 64,
    frame_width = 8,
    frame_height = 8,
    animations = {
        show_monsters = {vec2(8, 2), vec2(7, 3), vec2(8, 3), vec2(9, 3)}
    },
    current_animation = "show_monsters",
    fps = 3
}

local scene = am.group{
    am.rect(0, 0, 128, 128, vec4(.1, .12, .14, 1)),
    sprite_animation(sprite),
    sprite_animation(test)
}

window.scene = scene

window.scene:action(function(node)
    --print("updated player.x =", sprite.x)
    sprite.x = sprite.x + am.frame_time
end)
