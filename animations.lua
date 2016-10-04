-- propierties (table) are:
--
-- texture (string)
-- x (number)
-- y (number)
-- width (number)
-- height (number)
-- frame_width (number)
-- frame_height (number)
-- animations (table)
-- current_animation (string)
-- fps (number)
-- color (vec4)
--

return function(properties)
    properties.width = properties.width or properties.frame_width
    properties.height = properties.height or properties.frame_height
    properties.color = properties.color or vec4(1)
    properties.current_frame = 1
    properties.fps = properties.fps or 24

    local node = am.group{
        am.translate(properties.x, properties.y)
        ^ am.scale(properties.width, properties.height)
        ^ am.use_program(am.shaders.texturecolor2d)
        ^ am.blend("alpha")
        ^ am.bind{
            vert = am.rect_verts_2d(0, 0, 1, 1),
            uv = am.rect_verts_2d(0, 0, 1, 1),
            tex = am.texture2d(properties.texture),
            color = properties.color
        }
        ^ am.draw("triangles", am.rect_indices())
    }
    :tag("anim_sprite")
    :action(function(grp)
        if not properties.timer or properties.timer <= am.current_time() then
            local anim = properties.animations[properties.current_animation]
            local frm  = properties.current_frame
            local cols = grp("bind").tex.width / properties.frame_width
            local rows = grp("bind").tex.height / properties.frame_height
            local w = 1 / cols
            local h = 1 / rows
            local u = w * (anim[frm].x - 1)
            local v = h * (rows - anim[frm].y)

            grp("bind").uv = am.rect_verts_2d(u, v, u + w, v + h)
            properties.timer = am.current_time() + 1 / properties.fps
            properties.current_frame = anim[frm + 1] and frm + 1 or 1
        end
    end)

    function node:get_x()
        return properties.x
    end

    function node:set_x(x)
        properties.x = x
        self("translate").position2d = vec2(properties.x, properties.y)
    end

    function node:get_y() return properties.y end
    function node:get_width() return properties.width end
    function node:get_height() return properties.height end
    function node:get_current_animation() return properties.current_animation end
    function node:get_fps() return properties.fps end
    function node:get_color() return self("bind").color end

    function node:set_y(y)
        properties.y = y
        self("translate").position2d = vec2(properties.x, properties.y)
    end

    function node:set_width(width)
        properties.width = width
        self("scale").scale2d = vec2(properties.width, properties.height)
    end

    function node:set_height(height)
        properties.height = height
        self("scale").scale2d = vec2(properties.width, properties.height)
    end

    function node:set_current_animation(name)
        properties.current_animation = name
    end

    function node:set_fps(fps)
        properties.fps = fps
    end

    function node:set_color(color)
        self("bind").color = color
    end

    return node
end
