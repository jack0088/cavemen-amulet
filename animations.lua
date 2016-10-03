function am.sprite_animation(object)
    object.width = object.width or object.frame_width
    object.height = object.height or object.frame_height
    object.current_frame = 1
    object.fps = object.fps or 24

    local texture_image = am.load_image(object.texture)

    local function update_uv()
        local cols = texture_image.width / object.frame_width
        local rows = texture_image.height / object.frame_height
        object.s2 = 1 / cols -- right
        object.t2 = 1 / rows -- top
        object.s1 = object.s2 * object.animations[object.current_animation][object.current_frame].x -- left
        object.t1 = object.t2 * object.animations[object.current_animation][object.current_frame].y -- bottom
    end

    update_uv()

    local node = am.translate(object.x, object.y)
        ^ am.sprite{
            texture = am.texture2d(texture_image),
            s1 = object.s1, -- left
            t1 = object.t1, -- bottom
            s2 = object.s2, -- right
            t2 = object.t2, -- top
            x1 = 0, -- left offset
            y1 = 0, -- bottom offset
            x2 = 0, -- right offset
            y2 = 0, -- top offset
            width = object.width,
            height = object.height
        }

    node:action(function()
        if not object.animation_time
        or object.animation_time <= am.current_time()
        then
            object.animation_time = am.current_time() + 1 / object.fps
            local next_frame = object.animations[object.current_animation][object.current_frame + 1]

            if next_frame then
                update_uv()
                object.current_frame = next_frame
            end
        end
    end)

    node:tag"sprite_animation"

    return node
end
