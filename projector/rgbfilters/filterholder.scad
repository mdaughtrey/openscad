ViewScale = [0.0254, 0.0254, 0.0254];


module cmount()
{
    linear_extrude(100)
    difference() {
        circle(1290/2, $fn=96);
        circle(1160/2, $fn=96);
    }
}

module smount()
{
    linear_extrude(100)
    difference() {
        square([1380, 1380], center=true);
        square([1160, 1160], center=true);
    }
}

module slid()
{
    linear_extrude(100)
    difference() {
        square([1500, 1500], center=true);
        square([1260, 1260], center=true);
    }
    translate([0, 0, 100])
    linear_extrude(100)
    difference() {
        square([1500, 1500], center=true);
        square([1400, 1400], center=true);
    }
    // tab
    translate([1000, 0, 150])
    linear_extrude(50)
    square([500, 500], center=true);

}

scale(ViewScale)
{
    translate([0, 0, 100])
    rotate([180, 0, 0]) {
    cmount();
    translate([0, 0, -100])
    smount();
    }

    translate([1700, 0, 0])
    slid();
}
