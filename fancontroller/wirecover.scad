ViewScale = [0.0254, 0.0254, 0.0254];

scale(ViewScale)
{
    // cover
    linear_extrude(50)
    difference() {
    square([575, 1300], center=true);
    translate([0, -400, 0])
    circle(150, $fn=96);
    translate([0, 0, 0])
    circle(150, $fn=96);
    translate([0, 400, 0])
    circle(150, $fn=96);
    }

    translate([0, 0, 50])
    linear_extrude(300)
    difference() {
        square([455, 1300], center=true);
        square([355, 1300], center=true);
    }
}
