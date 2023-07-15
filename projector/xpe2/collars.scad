
module cutouts()
{
   difference() {
        circle(1600/2, $fn=96);
        circle(1490/2, $fn=96);
        // tab
        rotate([0, 0, 45]) 
        translate([0, 700, 0])
        square([200, 200], center=true);
        // tab
        rotate([0, 0, 165]) 
        translate([0, 700, 0])
        square([200, 200], center=true);
        // tab
        rotate([0, 0, 285]) 
        translate([0, 700, 0])
        square([200, 200], center=true);
        *translate([-600, 0, 0])
        square([500, 100], center=true);
    }
}

module cutouts2()
{
   difference() {
        circle(1600/2, $fn=96);
        circle(1490/2, $fn=96);
        // tab
        rotate([0, 0, 53]) 
        translate([0, 700, 0])
        square([400, 200], center=true);
        // tab
        rotate([0, 0, 173]) 
        translate([0, 700, 0])
        square([400, 200], center=true);
        // tab
        //#rotate([0, 0, 240]) 
        rotate([0, 0, 293]) 
        translate([0, 700, 0])
        square([400, 200], center=true);
        *translate([-600, 0, 0])
        square([500, 100], center=true);
        *translate([-600, 0, 0])
        square([500, 100], center=true);
    }
}

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

    *linear_extrude(200)
    difference() {
        circle(1461/2, $fn=96);
        circle(1355/2, $fn=96);
    }

}

module tabbed_accept_collar()
{
    $fn=96;
    diff()
    tube(od=1600,id=1490,h=300) {
    tag("remove") zrot_copies(n=3) up(1) left(120)  position(RIGHT+TOP) cube([200,200,152],anchor=LEFT+TOP);
    tag("remove") zrot_copies(n=3) back(100) left(120) down(1) position(RIGHT+BOT) cube([200,400,151],anchor=LEFT+BOT);
    }
//    linear_extrude(151)
//    cutouts2();
//
//    translate([0, 0, 149])
//    linear_extrude(151)
//    cutouts();
}

module tabbed_insert_collar()
{
    tabs();
}

