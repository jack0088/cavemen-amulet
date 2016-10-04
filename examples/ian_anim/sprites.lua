local font_data = {
    minfilter = "linear",
    magfilter = "linear",
    is_premult = true,
    {
        filename = "images/earth1.png",
        x1 = 0, y1 = 0, x2 = 50, y2 = 40,
        s1 = 0.4296875, t1 = 0.6796875, s2 = 0.625, t2 = 0.9921875,
        width = 50, height = 50,
    },
    {
        filename = "images/earth2.png",
        x1 = 0, y1 = 0, x2 = 50, y2 = 40,
        s1 = 0.6328125, t1 = 0.6796875, s2 = 0.828125, t2 = 0.9921875,
        width = 50, height = 50,
    },
    {
        filename = "images/earth3.png",
        x1 = 0, y1 = 0, x2 = 50, y2 = 40,
        s1 = 0.4296875, t1 = 0.3515625, s2 = 0.625, t2 = 0.6640625,
        width = 50, height = 50,
    },
    {
        filename = "images/earth4.png",
        x1 = 0, y1 = 0, x2 = 50, y2 = 40,
        s1 = 0.6328125, t1 = 0.3515625, s2 = 0.828125, t2 = 0.6640625,
        width = 50, height = 50,
    },
    {
        filename = "images/frame1.png",
        x1 = 20, y1 = 6, x2 = 76, y2 = 86,
        s1 = 0.203125, t1 = 0.3671875, s2 = 0.421875, t2 = 0.9921875,
        width = 100, height = 100,
    },
    {
        filename = "images/frame2.png",
        x1 = 22, y1 = 4, x2 = 71, y2 = 89,
        s1 = 0.00390625, t1 = 0.328125, s2 = 0.1953125, t2 = 0.9921875,
        width = 100, height = 100,
    },
}

return am._init_fonts(font_data, "sprites.png")