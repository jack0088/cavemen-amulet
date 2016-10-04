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

    local timer
    local sprite = am.texture2d(properties.texture)

    return am.group{
        am.use_program(am.shaders.texturecolor2d)
        ^ am.blend("alpha")
        ^ am.bind{
            vert = am.rect_verts_2d(
                properties.x,
                properties.y,
                properties.x + properties.width,
                properties.y + properties.height
            ),
            uv = am.rect_verts_2d(0, 0, 1, 1),
            tex = sprite,
            color = properties.color
        }
        ^ am.draw("triangles", am.rect_indices())
    }
    :tag("anim_sprite")
    :action(function(grp)
        if not timer or timer <= am.current_time() then
            local anim = properties.animations[properties.current_animation]
            local frm  = properties.current_frame
            local cols = sprite.width / properties.frame_width
            local rows = sprite.height / properties.frame_height
            local w = 1 / cols
            local h = 1 / rows
            local u = w * (anim[frm].x - 1)
            local v = h * (rows - anim[frm].y)

            grp("bind").uv = am.rect_verts_2d(u, v, u + w, v + h)
            timer = am.current_time() + 1 / properties.fps
            properties.current_frame = anim[frm + 1] and frm + 1 or 1
        end
    end)
end
