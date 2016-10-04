win = am.window{}
sprites = require "sprites"

-- dancing figure
figure_node = am.sprite(sprites.frame1)
figure_frames = {sprites.frame1, sprites.frame2}
current_figure_frame = 1
last_figure_update_time = 0
function animate_figure()
    if am.frame_time - last_figure_update_time > 0.5 then
        current_figure_frame = current_figure_frame % #figure_frames + 1
        figure_node.source = figure_frames[current_figure_frame]
        last_figure_update_time = am.frame_time
    end
end

-- ground
ground_quads = am.quads(1, {"vert", "vec2", "uv", "vec2"})
ground_frames = {sprites.earth1, sprites.earth2, sprites.earth3, sprites.earth4}
current_ground_frame = 1
last_ground_update_time = -1
for x = -200, 150, 50 do
    ground_quads:add_quad{
        vert = {x, 0, x, -50, x+50, -50, x+50, 0},
        uv = {0, 0, 0, 0, 0, 0, 0, 0},
    }
end
function animate_ground()
    if am.frame_time - last_ground_update_time > 0.1 then
        current_ground_frame = current_ground_frame % #ground_frames + 1
        local frame = ground_frames[current_ground_frame]
        for q = 1, 8 do
            ground_quads:quad_uv(q, {
                frame.s1, frame.t2, 
                frame.s1, frame.t1, 
                frame.s2, frame.t1, 
                frame.s2, frame.t2})
        end
        last_ground_update_time = am.frame_time
    end
end
animate_ground() -- to set initial uvs

ground_program = am.program([[
    precision highp float;
    attribute vec2 vert;
    attribute vec2 uv;
    uniform mat4 MV;
    uniform mat4 P;
    varying vec2 v_uv;
    void main() {
        v_uv = uv;
        gl_Position = P * MV * vec4(vert, 0.0, 1.0);
    }
]],
[[
    precision mediump float;
    uniform sampler2D tex;
    varying vec2 v_uv;
    void main() {
        gl_FragColor = texture2D(tex, v_uv);
    }
]])

ground_node = am.blend"premult"
    ^ am.use_program(ground_program)
    ^ am.bind{tex = sprites.texture}
    ^ ground_quads

-- put it all together in a scene
win.scene = am.group{am.translate(0, 30) ^ figure_node, ground_node}

-- run the animation update functions
win.scene:action(function()
    animate_figure()
    animate_ground()
end)

