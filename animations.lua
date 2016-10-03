function am.sprite_animation(object)
    object.current_frame = 1
    object.fps = object.fps or 24

    local node = am.sprite{
        texture = object.texture,
        s1 = , -- left
        t1 = , -- bottom
        s2 = , -- right
        t2 = , -- top
        x1 = 0, -- left offset
        y1 = 0, -- bottom offset
        x2 = 0, -- right offset
        y2 = 0, -- top offset
        width = object.frame_width,
        height = object.frame_height
    }

    node:action(function()
        if not object._animation_time then
            object._animation_time = am.current_time + 1 / object.fps
        end

        if object._animation_time < am.current_time then
            local next_frame = object.frames[current_frame + 1]
            if next_frame then
                object.current_frame = next_frame
            end
        end
    end)

    node:tag"sprite_animation"

    return node
end
