ViewScale = [0.0254, 0.0254, 0.0254];

module shaft()
{
    // with cutout
    linear_extrude(470)
    intersection() {
        circle(124, $fn=96);
        translate([30, 0, 0])
        square([250, 400], center=true);
    }

    // without cutout
    translate([0, 0, 470])
    linear_extrude(120)
    circle(124, $fn=96);

    // base
    translate([0, 0, 590])
    linear_extrude(250)
    circle(235, $fn=96);

}

module screwFace()
{
    difference() {
    circle(725, $fn=96);
    for (ii = [0:60:360]) {
        rotate([0, 0, ii])
        translate([600, 0, 0])
        circle(75, $fn=96);
    }}
}

module gearbox()
{
    circle(725, $fn=96);
}

module motor()
{
    circle(625, $fn=96);
}

module backRibs()
{
    linear_extrude(114) {
    square([312, 1250], center=true);
    rotate([0, 0, 90])
    square([112, 1250], center=true);
    }
    translate([0, 0, 114])
    linear_extrude(120)
    circle(145, $fn=96);
}


module geared2()
{
    translate([260, 0, 0])
    shaft();

    translate([0, 0, 840])
    linear_extrude(135)
    rotate([0, 0, 30])
    screwFace();

    translate([0, 0, 975])
    linear_extrude(815)
    gearbox();

    translate([0, 0, 1790])
    linear_extrude(730)
    motor();

    translate([0, 0, 2510])
    backRibs();
}

scale(ViewScale)
{
    geared2();
}
