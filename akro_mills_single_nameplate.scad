use <drawer_nameplate.scad>

text_lines = ["Ken", "Hiatt"];
tsize = 8;
margin_top = 4.0;

drawer_nameplate(
    text_lines = text_lines,
    text_size=tsize,
    text_margin_top = margin_top,
    width = 50,
    height = 34,
    base_thick = 0.6,
    base_chamfer_top = false,
    top_radius = 1.75,
    p_thick = 1.4,
    p_chamfer_top = true,
    p_top_margin = 0,
    p_side_margin = 2.75,
    p_bottom_margin = 2.75,
    font = "Calibri:style=Regular"
);
