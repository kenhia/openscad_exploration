
debug_me = true;
circle_fn = 512;

module filament_swatch_2dbase(width = 70, height = 32, fillet=5, center=false) {
    r_adj = fillet * 2;
    fillet_diameter = fillet * 2;
    fillet_half = fillet / 2;

    t_x = center? 0 : width/2;
    t_y = center? fillet : -(height/2-fillet);
    t_z = 0;

//    translate([width/2,height/2+fillet,0]) {
    translate([t_x, t_y, t_z]) {
        translate([0, -fillet/2, 0])
            square([width, height-(fillet)], center=true);
        translate([0, -fillet, 0])
            square([width - fillet_diameter, height], center=true);

        translate([width/2 - fillet,-height/2, 0])
            circle(fillet, $fn=circle_fn);
        translate([-(width/2 - fillet),-height/2, 0])
            circle(fillet, $fn=circle_fn);
    }
}

module filament_swatch_extrude(width=70, height=32, depth=2.5, fillet=5, center=false) {
    t_z = center? -depth/2 : 0;
    translate([0,0,t_z])
        linear_extrude(depth)
            filament_swatch_2dbase(width=width, height=height, fillet=fillet, center=center);
}


module filament_swatch(center=false) {
    filament_swatch_extrude(center=center);
}

if (debug_me) {
    color([0,1,0])
    cylinder(h=10, r=0.5);
}

/*
linear_extrude(25) {
square([5,30], center=true);
circle(10, $fn=256);
}
*/

/*
linear_extrude(2.5)
    filament_swatch_2dbase(fillet=3, center=true);
*/
filament_swatch(center=true);
/*
color([0,1,0])
linear_extrude(2.5)
    filament_swatch_2dbase(fillet=3);
*/
