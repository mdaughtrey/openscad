ViewScale = [0.0254, 0.0254, 0.0254];
include <inner.dat>
include <outer.dat>

models=0;

module model_disk()
{
    innershift = [for(ii=[len(inner)-1:-1:0]) [inner[ii].x,inner[ii].y+50]];
    rotate_extrude(angle=360, convexity=2, $fn=96) {
        polygon(points=concat(inner, innershift));
        translate([6858, 700, 0])
        circle(100/2, $fn=96);
    }
}

module spring()
{
    module onec() { difference() { circle(150/2, $fn=96); circle(50/2, $fn=96); translate([0, -25, 0]) square([80, 50]); }}
    translate([0, 0, 0]) square([250, 50]);
    translate([250, 75, 0]) rotate([0, 0, 180]) onec();
    translate([0, 100, 0]) square([250, 50]);
    translate([0, 175, 0]) onec();
    translate([0, 200, 0]) square([250, 50]);
    *translate([0, 249, 0]) square([50, 25]);
    *translate([100, 179, 0]) square([50, 25]);
    *translate([200, 249, 0]) square([50, 25]);
}

module contact()
{
    rotate(-7.5)
    rotate_extrude(angle=15, convexity=2, $fn=96) 
    intersection() {
        polygon(points=outer);
        translate([6150, 150, 0])
        square([500, 500]);
    }
//    innershift = [for(ii=[len(inner)-1:-1:0]) [inner[ii].x,inner[ii].y+50]];
//    rotate_extrude(angle=360, convexity=2, $fn=96) {
//        polygon(points=concat(inner, innershift));
//        translate([6858, 700, 0])
//        circle(100/2, $fn=96);
//    }
}

module forViewing()
{
    if (models) {
        color("grey")
        model_disk();
    }
    translate([160, 0, 0])
    contact();
    translate([550, 0, 200])
    linear_extrude(200)
    springpart();
}

module springpart()
{
    translate([-50, -1000, 0])
    rotate([0, 0, 10])
    intersection() {
        translate([6200, -500, 0])
        square([500, 1000]);
        difference() {
            circle(6500, $fn=96);
            circle(6450, $fn=96);
        }
    }
    *translate([6470, -100, 0])
    rotate([0, 0, 90])
    spring();
}

module forPrinting()
{
    linear_extrude(200)
    springpart();
}

scale(ViewScale)
{
//    model_disk();
    forViewing();
//    forPrinting();
}
