-- propierties (table) are:
--
-- texture (string or image buffer)
-- color (vec4)
-- position (vec2)
-- size (vec2)
-- frame_size (vec2)
-- angle (number)
-- pivot (vec2)
-- animations (table)
-- current_animation (string)
-- fps (number)
-- loop (boolean)
--

return function(properties)
    properties.color = properties.color or vec4(1)
    properties.size = properties.size or properties.frame_size
    properties.angle = properties.angle or 0
    properties.pivot = properties.pivot or vec2(0, 0)
    properties.current_frame = 1
    properties.fps = properties.fps or 24
    properties.loop = properties.loop or true

    print(properties.pivot * properties.frame_size)

    local node = am.group{
        am.translate(properties.position)
        ^ am.scale(properties.size)
        ^ am.rotate(math.rad(properties.angle))
        ^ am.translate(-(properties.pivot * properties.size / properties.size)):tag("pivot")
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
            local cols = grp("bind").tex.width / properties.frame_size.x
            local rows = grp("bind").tex.height / properties.frame_size.y
            local w = 1 / cols
            local h = 1 / rows
            local u = w * (anim[frm].x - 1)
            local v = h * (rows - anim[frm].y)

            grp("bind").uv = am.rect_verts_2d(u, v, u + w, v + h)
            properties.timer = am.current_time() + 1 / properties.fps
            properties.current_frame = anim[frm + 1] and frm + 1 or 1

            if frm == #anim and not properties.loop then
                properties.current_frame = frm
            end
        end
    end)

    -- Getters

    function node:get_color()
        return self("bind").color
    end

    function node:get_position()
        return self("translate").position2d
    end

    function node:get_size()
        return self("scale").scale2d
    end

    function node:get_angle()
        return math.deg(self("rotate").angle)
    end

    function node:get_pivot()
        return self("pivot").position2d
    end

    function node:get_current_animation()
        return properties.current_animation
    end

    function node:get_fps()
        return properties.fps
    end

    function node:get_loop()
        return properties.loop
    end

    -- Setters

    function node:set_color(color)
        self("bind").color = color
    end

    function node:set_positon(position)
        self("translate").position2d = position
    end

    function node:set_size(size)
        self("scale").scale2d = size
    end

    function node:set_angle(angle)
        self("rotate").angle = math.rad(angle)
    end

    function node:set_pivot(pivot)
        self("pivot").position2d = pivot
    end

    function node:set_current_animation(name)
        properties.current_animation = name
    end

    function node:set_fps(fps)
        properties.fps = fps
    end

    function node:set_loop(flag)
        properties.loop = flag
    end

    return node
end
