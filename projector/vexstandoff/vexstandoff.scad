ViewScale = [0.0254, 0.0254, 0.0254];

module bump()
{
    linear_extrude(100)
    difference() {
    square([170, 170], center=true);
    for(ii=[45:90:315]) {
        rotate([0, 0, ii])
        translate([0, 120, 0])
        square([80, 30], center=true);
    }}
}

module bumps()
{
    translate([-250, 250, 0])
    bump();
    translate([250, -250, 0])
    bump();
}

module body()
{
    linear_extrude(1625)
    difference() {
    square([840, 840], center=true);
    for(ii=[45:90:315]) {
        rotate([0, 0, ii])
        translate([0, 600, 0])
        square([200, 100], center=true);
    }
    translate([250, 250, 0])
    circle(180/2, $fn=96);
    translate([-250, -250, 0])
    circle(180/2, $fn=96);
    }
}


module standoff()
{
    // bumps
    // linear_extrude(715)
    // main bit
    // bumps
}

scale(ViewScale)
{
//    standoff();
    bumps();
    translate([0, 0, 100])
    body();
    translate([0, 0, 1725])
    bumps();
}
