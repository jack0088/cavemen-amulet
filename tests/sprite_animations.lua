function am.sprite_animation(object)
    object.width = object.width or object.frame_width
    object.height = object.height or object.frame_height
    object.current_frame = 1
    object.fps = object.fps or 24

    local texture_image = am.texture2d(object.texture)

    local function update_uv()
        local cols = texture_image.width / object.frame_width
        local rows = texture_image.height / object.frame_height
        local w = 1 / cols
        local h = 1 / rows
        local u = w * (object.animations[object.current_animation][object.current_frame].x - 1)
        local v = h * (rows - object.animations[object.current_animation][object.current_frame].y)
        object.s1 = u -- left
        object.t1 = v -- bottom
        object.s2 = u + w -- right
        object.t2 = v + h -- top
    end

    update_uv()

    local node = am.translate(object.x + object.width/2, object.y + object.height/2)
        ^ am.sprite{
            texture = texture_image,
            s1 = object.s1, -- left
            t1 = object.t1, -- bottom
            s2 = object.s2, -- right
            t2 = object.t2, -- top
            x1 = 0, -- left offset
            y1 = 0, -- bottom offset
            x2 = object.width, -- right offset
            y2 = object.height, -- top offset
            width = object.width,
            height = object.height
        }

    node:action(function()
        if not object.animation_time
        or object.animation_time <= am.current_time()
        then
            object.animation_time = am.current_time() + 1 / object.fps
            update_uv()

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
    width = 16,
    height = 16,
    frame_width = 8,
    frame_height = 8,
    animations = {
        show_people = {vec2(7, 1), vec2(8, 1), vec2(9, 1), vec2(7, 2)},
        show_monsters = {vec2(8, 2), vec2(7, 3), vec2(8, 3), vec2(9, 3)}
    },
    current_animation = "show_people",
    fps = 3
}

local scene = am.group{
    am.rect(0, 0, 128, 128, vec4(.1, .12, .14, 1)),
    am.sprite_animation(sprite)
}

window.scene = scene
