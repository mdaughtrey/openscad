//include <model_encoder.scad>
include <model_indexwheels.scad>
include <model_bearing_4_11_4_flanged.scad>
include <encoder_enclosure.scad>
include <coupler.scad>

ViewScale = [0.0254, 0.0254, 0.0254];

//module bump()
//{
//    linear_extrude(100)
//    difference() {
//    square([170, 170], center=true);
//    for(ii=[45:90:315]) {
//        rotate([0, 0, ii])
//        translate([0, 120, 0])
//        square([80, 30], center=true);
//    }}
//}
//
//module bumps()
// {
//     translate([-250, 250, 0])
//     bump();
//     translate([250, -250, 0])
//     bump();
// }


// module vexmount()
// {
//     // vex mount
//     linear_extrude(200)
//     difference() {
//         translate([-600, 0, 0]) 
//         hull() {
//             circle(250, $fn=96);
//             translate([1200, 0, 0])
//             circle(250, $fn=96);
//         }
//         translate([-500, 0, 0])
//         circle(170/2, $fn=96);
//         translate([500, 0, 0])
//         circle(170/2, $fn=96);
//     }
// }
// 
// module shaftholder()
// {
//     translate([0, 0, 500])
//     rotate([90, 0, 0])
//     translate([0, 0, -250])
//     linear_extrude(500)
//     difference() {
//         square([500, 800], center=true);
//         circle(50, $fn=96);
//     }
// }
// 
// module front()
// {
//     vexmount();
//     translate([0, 0, 199])
//     shaftholder();
//     // vex mount
//     // shaft holder
//     // upper mount
// }

module forViewing()
{
    model_encoder();
    translate([0, 0, 4850+250])
    //translate([0, 0, 4550])
    rotate([180, 0, 0])
    model_indexwheels();

    color("dodgerblue")
    //translate([0, 0, 3600])
    translate([0, 0, 4800-800])
    rotate([180, 0, 0])
    model_bearing_4_11_4_flanged();

    color("dodgerblue")
    translate([0, 0, 2710])
    rotate([180, 0, 0])
    model_bearing_4_11_4_flanged();

    translate([0, 0, 1000])
    encoder_enclosure();

    translate([0, 0, 1610]) {
        couplehalf(outerradius=330, lowershafth=400, lowershaftr=245/2, uppershafth=400, uppershaftr=160/2,
            boltheadr=150/2, boltshaftwr=80/2, boltshaftnr=50/2);
        rotate([0, 0, 180])
        couplehalf(outerradius=330, lowershafth=400, lowershaftr=245/2, uppershafth=400, uppershaftr=160/2,
            boltheadr=150/2, boltshaftwr=80/2, boltshaftnr=50/2);
    }
//    coupler(upperlength = 400, lowerlength = 400, lowerradius=245, upperradius=160, outer_radius=330);
}

module forViewing0()
{
//    !couplehalf(radius=500, headr=100, wider=80, narrowr=60);
    couplehalf(outerradius=330, lowershafth=400, lowershaftr=245/2, uppershafth=400, uppershaftr=160/2,
        boltheadr=150/2, boltshaftwr=80/2, boltshaftnr=50/2);
}

module forPrinting()
{
    couplehalf(outerradius=330, lowershafth=400, lowershaftr=245/2, uppershafth=400, uppershaftr=160/2,
        boltheadr=150/2, boltshaftwr=80/2, boltshaftnr=50/2);
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
