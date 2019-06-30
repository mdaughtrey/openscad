ViewScale = [0.0254, 0.0254, 0.0254];
cablegap = 250;

module upperarm ()
{
    linear_extrude(200){
    difference() {
    circle(250, $fn=96);
    translate([-300, -300, 0])
    square([600, 300]);
    }
    translate([0, 0, 0])
    square([500, 250]);
    }
}

module upperarms()
{
    upperarm();
    translate([0, cablegap+500, 0])
    mirror([0, 1, 0])
    upperarm();
}

module support()
{
    square([250, cablegap]);
}

module supports()
{
    linear_extrude(350) {
    support();
    translate([0, cablegap+250, 0])
    support();
    }
}


module halfrounded()
{
    linear_extrude(200)
    hull() {
    translate([100, 500+cablegap-100, 0])
    circle(100, $fn=96);
    translate([100, 100, 0])
    circle(100, $fn=96);
    translate([100, 0, 0])
    square([900, 500+cablegap]);
    }
}

module base()
{
    halfrounded();

    translate([1000, 0, -1000])
    rotate([0, -90, 0])
    halfrounded();
}

scale(ViewScale)
{
    translate([-500, 0, 550])
    upperarms();
    translate([-250, 0, 200])
    supports();
    translate([-1000, 0, 0])
    base();
}
