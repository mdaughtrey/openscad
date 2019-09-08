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
    translate([250, 250, 0])
    bump();
    translate([250, -250, 0])
    bump();
    translate([-250, 250, 0])
    bump();
    translate([-250, -250, 0])
    bump();
}

module mountmain()
{
    linear_extrude(1104-715)
    difference() {
    square([840, 840], center=true);
    for(ii=[45:90:315]) {
        rotate([0, 0, ii])
        translate([0, 600, 0])
        square([200, 100], center=true);
    }
    circle(180/2, $fn=96);
    }
}

//
//module standoff()
//{
//    // bumps
//    // linear_extrude(715)
//    // main bit
//    // bumps
//}

module disc()
{
    // disc
    linear_extrude(100)
    difference() {
        circle(1000/2, $fn=96);
        circle(170/2, $fn=96);
    }
    // spacer
    translate([0, 0, 100])
    linear_extrude(40)
    difference() {
        circle(460/2, $fn=96);
        circle(170/2, $fn=96);
    }
    // shaft
    translate([0, 0, 120])
    linear_extrude(155)
    difference() {
        circle(310/2, $fn=96);
        circle(170/2, $fn=96);
    }
}

module mount()
{
    // upper disk w/spacer and shaft
    rotate([180, 0, 0])
    disc();
    mountmain();
    // bumps + hole
    translate([0, 0, 1104-715])
    bumps();
}


scale(ViewScale)
{
    disc();
    *translate([1000, 0, 1104+100-715])
    rotate([180,0,0])
    mount();
}
