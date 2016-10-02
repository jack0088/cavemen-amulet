local window = am.window{
    width = 512,
    height = 512,
    projection = math.ortho(0, 128, 0, 128),
    clear_color = vec4(0, 0, 0, 1)
}

window.scene = am.rect(0, 0, 128, 128, vec4(.1, .12, .14, 1))
