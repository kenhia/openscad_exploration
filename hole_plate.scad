module hole_plate( size, hole_dm, hole_margin, hole_count = [2,2] ) {
    delta = 2;
    s_delta = 0.1;
    if (hole_count.x == 0 || hole_count.y == 0) {
        cube( size );
    } else {
        difference() {
            cube( size );

            abs_margin = hole_margin + hole_dm/2;
            x_hole_dist = hole_count.x > 1 ? (size.x - 2*abs_margin) / (hole_count.x - 1) : 0;
            y_hole_dist = hole_count.y > 1 ? (size.y - 2*abs_margin) / (hole_count.y - 1) : 0;

            x_values = hole_count.x > 1 ?
                [abs_margin : x_hole_dist : size.x - abs_margin + s_delta] :
                [size.x / 2];
            y_values = hole_count.y > 1 ?
                [abs_margin : y_hole_dist : size.y - abs_margin + s_delta] :
                [size.y / 2];

            // holes
            for (x = x_values, y = y_values)
                translate([x, y, -delta/2])
                color("red")
                cylinder( d = hole_dm, h = size.z + delta);
        }
    }
}
