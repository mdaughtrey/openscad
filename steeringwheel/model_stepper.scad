module model_stepper_level(p0, p1)
{
    intersection() {
        square([p0, p0], center=true);
        rotate([0, 0, 45])
        square([p1, p1], center=true);
    }
}

module model_stepper()
{
    x = 1660;
    x0 = -(x/2)+190;
    x1 = (x/2) - 190;
    color("lightgrey") {
        linear_extrude(491)
        model_stepper_level(1660, 2110);
    }
    color("DimGray") {
        translate([0, 0, 490])
        linear_extrude(328)
        model_stepper_level(1660, 1975);
    }

    color("lightgrey") {
        translate([0, 0, 817])
        linear_extrude(491)
        difference() {
            model_stepper_level(1660, 2110);
            for (ii = [x0, x1]) {
                for (jj = [x0, x1]) {
                    translate([ii, jj, 0])
                    circle(120/2, $fn=96);
                }
            }
        }
    }
    color("silver") {
        translate([0, 0, 1307])
        linear_extrude(85)
        difference() {
            circle(865/2, $fn=96);
            circle(340/2, $fn=96);
        }
    }

    color("silver") 
    translate([0, 0, 1307])
    linear_extrude(878+85)
    intersection() {
        circle(196/2, $fn=96);
        translate([20, 0, 0])
        square([196, 196], center=true);
    }
}

