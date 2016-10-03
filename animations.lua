function am.sprite_animation(object)
    object.width = object.width or object.frame_width
    object.height = object.height or object.frame_height
    object.current_frame = 1
    object.fps = object.fps or 24

    local image = am.read_image(object.texture)

    self.atlas:setRectTex(self.mask,
        1 / self.cols * (self.frames[i].x - 1),
        (1 / self.rows * (self.rows - self.frames[i].y)),
        1/self.cols,
        1/self.rows)

    local function get_uv()
        local cols = image.width / object.frame_width
        local rows = image.height / object.frame_height
        local u = 1 / cols * object.animations[object.current_animation].x
        local v = 1 / rows * object.animations[object.current_animation].y
        local w = 1 / cols
        local h = 1 / rows
        return u, v, w, h
    end

    local node = am.sprite{
        texture = image,
        s1 = object._u, -- left
        t1 = object._v, -- bottom
        s2 = object._w, -- right
        t2 = object._h, -- top
        x1 = 0, -- left offset
        y1 = 0, -- bottom offset
        x2 = 0, -- right offset
        y2 = 0, -- top offset
        width = object.width,
        height = object.height
    }

    node:action(function()
        if not object.animation_time
        or object.animation_time <= am.current_time
        then
            object.animation_time = am.current_time + 1 / object.fps
            local next_frame = object.frames[current_frame + 1]

            if next_frame then

                object.current_frame = next_frame
            end
        end
    end)

    node:tag"sprite_animation"

    return node
end
