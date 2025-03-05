text_lines = ["M3x8", "BHCS"];
tsize = 5.9;
margin_top = 4.0;

module nameplate_layer(
    width = 50,
    height = 34,
    thick = 0.6,
    top_radius = 1.75,
    chamfer_top = false,
){
    difference () {
        union() {
            cube([width, height - top_radius, thick]);
            if (top_radius > 0) {
                translate([top_radius, height/2, 0])
                    cube([width - (top_radius*2), height/2, thick]);
                translate([top_radius, height-top_radius, 0.0])
                    cylinder(h=thick, r=top_radius, $fn=60);
                translate([width - top_radius, height - top_radius, 0.0])
                    cylinder(h=thick, r=top_radius, $fn=60);
            }
        }
        os_length = sqrt(2 * pow(thick, 2)) + 2;  // length of other sides of cube
        // Chamfer left edge
        translate([0,-1,0])
            rotate(a=[0,-45,0])
            cube([os_length, height+2, os_length]);
        // chamfer right edge
        translate([width, -1, 0])
            rotate(a=[0,-45,0])
            cube([os_length, height+2, os_length]);
        // Chamfer bottom edge
        translate([-1,0,0])
            rotate(a=-[-45, 0, 0])
            cube([width + 2, os_length, os_length]);
        // Chamfer top edge if requested
        if (chamfer_top) {
            translate([-1,height,0])
                rotate(a=-[-45, 0, 0])
                cube([width + 2, os_length, os_length]);
        }
    }
}

module nameplate_text_lines(
    lines = ["M3x8", "BHCS"],
    text_size = 8,
    text_thick = 0.4,
    center_x,
    top_y,
    space_y,
    z_trans
) {
    num_lines = len(lines);
    line_interspace_y = space_y / num_lines;
    for ( index = [0:num_lines-1] ) {
        trans = [
            center_x,
            top_y - line_interspace_y * index,
            z_trans
        ];
        translate(trans)
            color("cyan")
            linear_extrude(text_thick)
            text(
                text = lines[index],
                size = text_size,
                valign = "top",
                halign = "center",
                $fn=100
            );
    }
}

module drawer_nameplate (
    text_lines = ["M3x8", "BHCS", "Foo", "Bar", "Baz"],
    text_size = 8,
    text_margin_top = 4,
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
){
    p_width = width - (2*p_side_margin);
    p_height = height - p_bottom_margin;
    text_thick = 0.4;

    union() {
        // base
        nameplate_layer(width = width, height = height, thick = base_thick, chamfer_top=base_chamfer_top, top_radius=top_radius);

        // plate
        p_y_trans = height - p_height - p_top_margin;
        p_x_trans = (width -p_width) / 2;
        // keep things from being exact
        translate([p_x_trans, p_y_trans, base_thick-0.001])
            nameplate_layer(width = p_width, height = p_height, thick = p_thick, chamfer_top = p_chamfer_top, top_radius = 0);

        // Measurements needed for the text
        text_center_x = width / 2;
        chamfer_adjust = p_chamfer_top ? p_thick : 0;
        text_top_y = height - p_top_margin - chamfer_adjust - text_margin_top;
        text_space_y = p_height - (2 * p_thick) - text_margin_top;
        text_z_trans = base_thick + p_thick - 0.001;

        nameplate_text_lines(
            lines = text_lines,
            text_size = text_size,
            text_thick = text_thick,
            center_x = text_center_x,
            top_y = text_top_y,
            space_y = text_space_y,
            z_trans = text_z_trans
        );
    }
}

drawer_nameplate(
    text_lines = text_lines,
    text_size=tsize,
    text_margin_top = margin_top
);
