ViewScale = [0.0254, 0.0254, 0.0254];
include <housing.scad>

module screwMount()
{
    linear_extrude(200)
    difference() {
    circle(170, $fn=96);
    circle(70, $fn=96);
    }
    translate([0, 0, 200])
    linear_extrude(100)
    difference() {
    circle(170, $fn=96);
    circle(130, $fn=96);
    }
}

module housing_support()
{
    // motor body
    difference() {
    intersection() {
    circle((574+clearance)/2, $fn=96);
    square([494+clearance,650], center=true);
    }
    intersection() {
    circle((473+clearance)/2, $fn=96);
    square([394+clearance,550], center=true);
    }
    translate([-200, 0, 0])
    square([400,700], center=true);
    }
}

scale(ViewScale)
{
    supportheight = 100;
    translate([0, 0, supportheight])
    housing();
    translate([1000, 0, supportheight])
    housing();
    translate([500, 0, 0])
    screwMount();

    linear_extrude(supportheight)
    housing_support();
    translate([1000, 0, 0])
    rotate([0, 0, 180])
    linear_extrude(supportheight)
    housing_support();

    translate([294, 0, 0])
    linear_extrude(300)
    square([100, 150], center=true);

    translate([700, 0, 0])
    linear_extrude(300)
    square([100, 150], center=true);
}
