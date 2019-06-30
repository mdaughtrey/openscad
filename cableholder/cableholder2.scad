ViewScale = [0.0254, 0.0254, 0.0254];
cablegap = 250;

module arm ()
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

module arms()
{
    arm();
    translate([0, cablegap+500, 0])
    mirror([0, 1, 0])
    arm();
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

module halfrounded1()
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

module halfrounded2()
{
    linear_extrude(200)
    hull() {
    translate([100, 500+cablegap-100, 0])
    circle(100, $fn=96);
    translate([100, 100, 0])
    circle(100, $fn=96);
    translate([100, 0, 0])
    square([400, 500+cablegap]);
    }
}

module base()
{
    translate([1000, 0, -500])
    rotate([0, -90, 0])
    halfrounded2();

    translate([1750, 0, 200])
    rotate([0, -180, 0])
    halfrounded1();
}

module unit(count)
{
    for(ii = [0: 1: count-1]) {
        translate([0, ii*750, 0]) {
            translate([-500, 0, 550])
            arms();
            translate([-250, 0, 200])
            supports();
            translate([-1000, 0, 0])
            base();
            translate([-500, 0, 0])
            arms();
        }
    }
}

scale(ViewScale)
{
    unit(5);
}


