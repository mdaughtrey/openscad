ViewScale = [0.0254, 0.0254, 0.0254];

module case()
{
    linear_extrude(350)
    intersection() {
        difference() {
        circle(460/2, $fn=96);
        circle(360/2, $fn=96);
        }
        union() {
        rotate([0, 0, 45]) translate([200, 0, 0]) square([300, 100], center=true);
        rotate([0, 0, 135]) translate([200, 0, 0]) square([300, 100], center=true);
        rotate([0, 0, -90]) translate([200, 0, 0]) square([300, 100], center=true);
        }
    }

    linear_extrude(200)
    circle(370/2, $fn=96);
    translate([0, 0, 200])
    linear_extrude(25)
    difference() {
    circle(370/2, $fn=96);
    circle(180/2, $fn=96);
    }
}

scale(ViewScale)
{
    case();
}
