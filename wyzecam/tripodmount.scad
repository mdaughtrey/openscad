ViewScale = [0.0254, 0.0254, 0.0254];

module segments()
{
    segs = 6;
    outer = 2240/2;
    inner = 1840/2;
    hub = 400;
    difference() {
        circle(outer, $fn=96);
    circle(hub, $fn=96);
    difference() {
    circle(outer, $fn=96);
    circle(inner, $fn=96);
    }
    for (isegs = [0: segs])
    {
        rotate([0, 0, isegs*(360/segs)])
        square([10+2*inner, 200], center=true);
    }
    }
}

module base()
{
    // hole only
    translate([0, 0, 100])
    linear_extrude(50)
    difference() {
        square(2240, center=true);
        segments();
//    circle(1130, $fn=96);
    circle(130, $fn=96);
    }

    // hex nut cutout
    translate([0, 0, 150])
    linear_extrude(250)
    difference() {
        square(2240, center=true);
        segments();
//    circle(1130, $fn=96);
    circle(130, $fn=96);
    circle(260, $fn=6);
    }

    // projection into depression
    //#translate([0, 0, 450])
    linear_extrude(102)
    difference() {
        circle(250, $fn=96);
        circle(130, $fn=96);
    }
}

module camera_mount()
{
    // sides
    linear_extrude(270)
    difference() {
    square(2240, center=true);
    square(2040, center=true);
    translate([0, -200, 0])
    square(2040, center=true);
    }

    // top
    translate([0, 0, 270])
    linear_extrude(100)
    difference() {
    square(2240, center=true);
    square(1790, center=true);
    translate([0, -300, 0])
    square(1790, center=true);
    }
}

scale(ViewScale)
{
    base();
    translate([0, 0, 400])
    camera_mount();

}

