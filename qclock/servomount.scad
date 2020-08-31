ViewScale = [0.0254, 0.0254, 0.0254];

include <model_9gservo.scad>

servoL = 889;
servoW = 484;
tabL = 1270;

module screwmount()
{
    difference() {
        circle(130, $fn=96);
        circle(135/2, $fn=96);
    }

    scale([1, 1.2, 1]) {
        difference() {
            circle(260, $fn=96);
            circle(230, $fn=96);
        }

        for (ii = [0,90,180,270]) {
            rotate([0, 0, ii])
            translate([170, 0, 0])
            square([140, 50], center=true);
        }
    }
}


module servomount()
{
    linear_extrude(160)
    difference() {
        translate([-200, 0, 0])
        square([tabL+400, servoW + 150], center=true);
        square([servoL + 5, servoW + 5], center=true);
        translate([servoL/2-230-500, 0, 0])
        difference() {
            scale([1, 1.2, 1]) circle(260, $fn=96);
            screwmount();
        }
        translate([servoL/2-230-1000, 0, 0])
        difference() {
            scale([1, 1.2, 1]) circle(260, $fn=96);
            screwmount();
        }
    }

    translate([servoL/2-230-500, 0, 159])
    linear_extrude(850)
    difference() {
        screwmount();
        translate([servoL/2-200, 0, 0])
        circle(240/2, $fn=96);
    }


    translate([servoL/2-230-1000, 0, 159])
    linear_extrude(850)
    screwmount();
}

module axlemount()
{
    linear_extrude(135)
    difference() {
        circle(460/2, $fn=96);
        circle(190/2, $fn=96);
    }

    *translate([0, 0, 134])
    linear_extrude(31)
    circle(460/2, $fn=96);

    translate([0, 0, 134])
    linear_extrude(431)
    difference() {
        circle(460/2, $fn=96);
        square([130, 130], center=true);
    }
}

module forviewing()
{
    color("cornflowerblue")
    model_9gservo();
    translate([0, 0, 730])
    servomount();
    translate([servoL/2-230, 0, 1060])
    axlemount();
}

module forprinting()
{
//    translate([ii, 0, 885])
    servomount();
    translate([0, 700, 0])
    axlemount();
}

scale(ViewScale)
{
//    forviewing();
    forprinting();
}
