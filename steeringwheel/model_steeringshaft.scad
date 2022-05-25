module model_steeringShaft()
{
    difference() {
        linear_extrude(2400)
//        difference() {
            circle(780/2, $fn=96);
//            circle(587/2, $fn=96);
//        }

        // End slot cutout
        translate([0, 0, 2400-450])
        rotate([0, -90, 0])
        translate([0, 0, -500])
        linear_extrude(1000)
        hull() {
            translate([230/2, 0, 0])
            circle(230/2, $fn=96);
            translate([800, 0, 0])
            square([230, 230], center=true);
        }
        // Top cutout
        translate([0, 400/2, 2400-130])
        linear_extrude(430)
        square([800, 400], center=true);

        // Crossbar
        translate([0, 0, 2400-1300])
        rotate([0, 90, 0])
        translate([0, 0, -830/2])
        linear_extrude(830)
        circle(125/2, $fn=96);
    }

    // Steering Wheel
    linear_extrude(200)
    circle(1495/2, $fn=96);
    translate([0, 0, 199])
    linear_extrude(285)
    difference() {
        circle(1495/2, $fn=96);
        circle(1260/2, $fn=96);
    }

}

