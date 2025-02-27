/*
This is an OpenSCAD test project

https://mastering-openscad.eu/buch/basic_ops_and_structure/
*/

/*
adjustment = 0.7;
adjustment_factor = 1.05;
function adjust(x) = (x + adjustment) * adjustment_factor;

radius_with_a_name = adjust(10);    // a very important radius
sphere(r= radius_with_a_name);
*/

// cube(size=10, center = true);


// translate([20,0,0])
//     rotate([0,0,45])
//     cube(size=10, center=true);

// dimensions in millimeter [width, depth, height] ala [x,y,z]
// plate = [100,50,5];

// hole_dm = 6;
// hole_margin = 4;

// difference() {
//     cube(plate);

//     translate
//     ([
//         hole_margin + hole_dm /2,
//         hole_margin + hole_dm /2,
//         0
//     ])
//     color("red")
//     cylinder ( d = hole_dm, h = plate.z + 0.0005);
// }

// include <hole_plate.scad>;
use <hole_plate.scad>;


hole_plate( size = [100, 50, 5], hole_dm = 6, hole_margin = 4);

translate([0,60,0])
    hole_plate(
        size = [50, 50, 5],
        hole_dm = 3,
        hole_margin = 2,
        hole_count = [4, 6]
    );

translate([0,-60,0])
    hole_plate(
        size = [50, 50, 5],
        hole_dm = 10,
        hole_margin = 2,
        hole_count = [1, 1]
    );

translate([60,-60,0])
    hole_plate(
        size = [50, 50, 5],
        hole_dm = 10,
        hole_margin = 2,
        hole_count = [0, 0]
    );

translate([60,60,0])
    hole_plate( size = [50, 50, 5], hole_dm = 3, hole_margin = 2);



/*
// dimensions in mm [width, depth, height]
plate = [100,50,5];

hole_margin = 4;
hole_dm     = 6;
abs_margin = hole_margin + hole_dm/2;

difference() {
    cube (plate);

    // x_values = [abs_margin, plate.x - abs_margin];
    // y_values = [abs_margin, plate.y - abs_margin];

    // // holes
    // for(x = x_values, y = y_values)
    //     translate( [x, y, delta/2])
    //     color("red")
    //     cylinder(d=hole_dm, h = plate.z + delta);

    //             100  - ( 2 * 7 ) => 86
    x_hole_dist = plate.x - 2 * abs_margin;
    //              50  - ( 2 * 7 ) => 36
    y_hole_dist = plate.y - 2 * abs_margin;

    //              7 : 86 : 93 => [7, 93]
    x_values = [abs_margin : x_hole_dist : plate.x - abs_margin ];
    //              7 : 36 : 43 => [7, 43]
    y_values = [abs_margin : y_hole_dist : plate.y - abs_margin ];

    // holes
    for (x = x_values, y = y_values)
        translate( [x, y, -delta/2])
        color("red")
        cylinder( d = hole_dm, h = plate.z + delta);
}
*/

// The long way
// difference() {

//     cube( plate );

//     // Lower left hole
//     translate
//     ([
//         abs_margin,
//         abs_margin,
//         -delta / 2
//     ])
//     color( "red" )
//     cylinder( d = hole_dm, h = plate.z + delta);

//     // Lower right hole
//     translate
//     ([
//         plate.x - abs_margin,
//         abs_margin,
//         -delta / 2
//     ])
//     color( "red" )
//     cylinder( d = hole_dm, h = plate.z + delta);

//     // Upper left hole
//     translate
//     ([
//         abs_margin,
//         plate.y - abs_margin,
//         -delta / 2
//     ])
//     color( "red" )
//     cylinder( d = hole_dm, h = plate.z + delta);

//     // Upper right hole
//     translate
//     ([
//         plate.x - abs_margin,
//         plate.y - abs_margin,
//         -delta / 2
//     ])
//     color( "red" )
//     cylinder( d = hole_dm, h = plate.z + delta);
// }