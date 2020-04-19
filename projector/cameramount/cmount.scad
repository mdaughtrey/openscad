ViewScale = [0.0254, 0.0254, 0.0254];
include <cmount_model.scad>

module pillars(r)
{
    translate([35+holer, 35+holer, 0])
    circle(r, $fn=96);
    translate([sqw-35-holer, 35+holer, 0])
    circle(r, $fn=96);
    translate([sqw-35-holer, sqh-322-holer, 0])
    circle(r, $fn=96);
    translate([35+holer, sqh-322-holer, 0])
    circle(r, $fn=96);
}

module cameramount()
{
    *translate([-sqw/2, -sqh+322+holer, 480])
    {
//        translate([0, 0, 100]) {
//            linear_extrude(150)
//            pillars(holer-5);
//        }
        linear_extrude(101)
        difference()  {
            pillars(100);
            pillars(25);
        }
    }

    // fit inside hole
    linear_extrude(380)
    difference() {
        circle(1480/2, $fn=96);
        circle(1420/2, $fn=96);
    }

    // collar
    translate([0, 0, 380])
    linear_extrude(100)
    difference() {
        circle(1580/2, $fn=96);
        circle(600/2, $fn=96);
        translate([-sqw/2, -sqh+322+holer, 0])
        pillars(25);
        translate([-300, -600, 0])
        square([600, 600]);
    }

    // arms
    for (ii = [0:180:359])
    rotate([0, 0, ii])
    translate([500, -250, 380]) {
        linear_extrude(100) {
            square([970, 500]);
            translate([770, -500, 0])
            square([200, 1500]);
        }
    }



    
}

scale(ViewScale)
{
//    translate([-sqw/2, -sqh+322+holer, 570])
//     cmount_model();
    cameramount();
}
