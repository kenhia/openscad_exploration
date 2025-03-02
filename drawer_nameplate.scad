t1 = "Line1";
t2 = "Line2";
tsize = 8;

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


module drawer_nameplate (
    text1 = "M3x8",
    text2 = "BHCS",
    text_size = 8
){
    width = 50;
    height = 34;
    base_thick = 0.6;
    p_thick = 1.4;
    p_width = width - (2*2.75);
    p_height = height - 2.75;
    p_from_top = 0;
    font = "Calibri:style=Regular";
    text_thick = 0.4;
    text_margin_top = 4;

    union() {
        // base
        nameplate_layer(width = 50, height = 34, thick = base_thick, chamfer_top=false, top_radius=1.75);

        // plate
        p_y_trans = height - p_height - p_from_top;
        p_x_trans = (width -p_width) / 2;
        // keep things from being exact
        translate([p_x_trans, p_y_trans, base_thick-0.001])
            nameplate_layer(width = p_width, height = p_height, thick = p_thick, chamfer_top = true, top_radius = 0);

        line_1_trans = [
            width/2,
            height - p_from_top - p_thick - text_margin_top,
            base_thick + p_thick - 0.001
        ];
        line_2_trans = [
            width/2,
            line_1_trans.y - 12,
            base_thick + p_thick - 0.001
        ];
        translate(line_1_trans)
        color("cyan")
        linear_extrude(text_thick)
        text(
            text=text1,
            size = text_size,
            valign = "top",
            halign = "center",
            $fn=100
        );
        translate(line_2_trans)
        color("cyan")
        linear_extrude(text_thick)
        text(
            text=text2,
            size = text_size,
            valign = "top",
            halign = "center",
            $fn=100
        );

    }
}

drawer_nameplate(text1 = t1, text2 = t2, text_size=5.5);
