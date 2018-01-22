ViewScale = [0.0254, 0.0254, 0.0254];

module switchCap()
{
    translate([0, 0, 50])
    linear_extrude(400)
    circle(110, $fn=96);

    linear_extrude(50)
    circle(150, $fn=96);
}

module fanCap()
{
    linear_extrude(200)
    difference() {
    circle(895, $fn=96);
    circle(875, $fn=96);
    translate([0, 895, 0])
    square([600, 200], center=true);
    translate([0, -895, 0])
    square([600, 200], center=true);

    translate([895, 0, 0])
    square([200, 600], center=true);
    translate([-895, 0, 0])
    square([200, 600], center=true);
    }

    translate([0, 0, 200])
    linear_extrude(50)
//    difference() {
    circle(895, $fn=96);
//    circle(795, $fn=96);
//    }
}

module wireCap()
{
    linear_extrude(50)
    difference() {
    translate([0, 75, 0])
    square([490, 2772], center=true);
    translate([905-490/2, -(905+2622/2)+830, 0])
    circle(905, $fn=96);
    translate([-300, 2730/2+100, 0])
    rotate([0, 0, 45])
    square(800, center=true);
    translate([667, 2772/2-100, 0])
    circle(547, $fn=96);
    }

    translate([0, 0, -100])
    linear_extrude(100)
    difference() {
    union() {
    translate([-(490-50)/2, -(2622-1922)/2, 0])
    square([50, 1922], center=true);
    translate([(490-50)/2, -(2622-1972)/2, 0])
    square([50, 1972], center=true);
    }
    translate([905-490/2, -(905+2622/2)+830, 0])
    circle(905, $fn=96);
    }
}



scale(ViewScale)
{
    //switchCap();
    //fanCap();
    wireCap();
}
