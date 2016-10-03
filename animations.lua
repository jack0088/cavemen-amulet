function am.sprite_animation(object)
    object.width = object.width or object.frame_width
    object.height = object.height or object.frame_height
    object.current_frame = 1
    object.fps = object.fps or 24

    local texture_image = am.load_image(object.texture)

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
            texture = am.texture2d(texture_image),
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

            -- print(object.s1, object.t1, object.s2, object.t2)

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
