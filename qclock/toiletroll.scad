ViewScale = [0.0254, 0.0254, 0.0254];

module roll()
{
    linear_extrude(500)
    difference() {
        circle(500, $fn=96);
        square([130, 130], center=true);
    }
    translate([0, 0, 499])
    linear_extrude(51)
    circle(500, $fn=96);

    translate([0, 0, 549])
    linear_extrude(400)
    difference() {
        circle(500, $fn=96);
        circle(150, $fn=96);
    }
}

module twist()
{
    linear_extrude(height=1000, slices=100, twist=90)
    square([50, 949]);
}

module trail()
{
    translate([1250, -385, 50])
    rotate([0, 90, 0])
    linear_extrude(1000)
    square([50, 949]);
}

module toiletroll()
{
//    color("White")
    {
        roll();
        translate([1250, -385, 0])
        rotate([0, -90, 0])
        twist();
        trail();
    }
}


scale(ViewScale)
{
    toiletroll();
}
