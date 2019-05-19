ViewScale = [0.0254, 0.0254, 0.0254];

module barrel()
{
    difference() {
        circle(1460/2, $fn=96);
        circle(1360/2, $fn=96);
    }
}

module tab()
{
    difference() {
        union() {
            translate([518-190, 0, 0])
            circle(380/2, $fn=96);
            translate([0, -190, 0])
            square([518-190, 380]);
        }
        translate([100, 0, 0]) {
            hull() {
                translate([518-290, 0, 0])
                circle(180/2, $fn=96);
                translate([0, 0, 0])
                circle(180/2, $fn=96);
                //square([518-290, 180]);
            }
        }
    }
}


module lensmount()
{
    translate([0, 0, 299])
    linear_extrude(100) 
    difference() {
        square(2684, center=true);
        circle(1360/2, $fn=96);
        for(ii = [45:90:360]) {
            rotate([0, 0, ii])
            translate([1100, 0, 0])
            circle(350, $fn=96);
        }
        for(ii = [0:90:360]) {
            rotate([0, 0, ii])
            translate([1000, 0, 0])
            circle(200, $fn=96);
        }
    }

    linear_extrude(300) {
        difference() {
            square(2684, center=true);
            square(2484, center=true);
            square([1800, 2800], center=true);
            square([2800, 400], center=true);
        }
        translate([2684/2-1, 2684/2-190, 0])
        tab();
        translate([2684/2-1, 1184/2-190, 0])
        tab();
    }
}

scale(ViewScale)
{
    lensmount();
    translate([0, 0, 399])
    linear_extrude(1000)
    barrel();
}
