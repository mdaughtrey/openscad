
module tab()
{
    // tab big bit
    *linear_extrude(160)
    intersection() {
        difference() {
            circle(1660/2, $fn=96);
            circle(1460/2, $fn=96);
        }
        rotate([0, 0, 52]) 
        translate([0, 700, 0])
        square([380, 260], center=true);
    }
    //translate([0, 0, 160])
    // tab little bit
    linear_extrude(130)
    intersection() {
        difference() {
            circle(1600/2, $fn=96);
            circle(1460/2, $fn=96);
        }
        rotate([0, 0, 45]) 
        translate([0, 700, 0])
        square([180, 300], center=true);
    }
}

module tabs()
{
    tab();
    rotate([0, 0, 120])
    tab();
    rotate([0, 0, 240])
    tab();

    linear_extrude(200)
    difference() {
        circle(1461/2, $fn=96);
        circle(1355/2, $fn=96);
    }

}

module case()
{
    // front
    linear_extrude(20)
    difference() {
        circle(1420/2, $fn=96);
        circle(740/2, $fn=96);
    }

    // Inner ring
    translate([0, 0, 19])
    linear_extrude(100)
    difference() {
        circle(880/2, $fn=96);
        circle(780/2, $fn=96);
        translate([400, 0, 0])
        square(150, center=true);
    }
    // Outer
    translate([0, 0, 19])
    linear_extrude(392-20+70+20)
    difference() {
        circle(1420/2, $fn=96);
        circle(1350/2, $fn=96);
    }
    // Inner ribs
    *translate([0, 0, 19])
    linear_extrude(392-20+20)
    for(ii = [0:120:360]) {
        rotate([0, 0, ii])
        translate([600, 0, 0])
        square(180, center=true);
    }
    // Inserts
    *translate([0, 0, 19+392-19+20])
    linear_extrude(70)
    for(ii = [0:120:360]) {
        rotate([0, 0, ii])
        translate([620, 0, 0])
        square([120, 100], center=true);
    }
    
}

module mount()
{
    case();
    tabs();
}
