ViewScale = [0.0254, 0.0254, 0.0254];

module cutoutCircle()
{
    difference () {
        circle(115, $fn=96);
        circle(95, $fn=96);
        square([30, 300], center=true);
    }
}

module columns()
{
//    linear_extrude(450) 
//    circle(65, $fn=96);

    linear_extrude(30) 
    cutoutCircle();

    translate([0, 0, 30])
    linear_extrude(390) 
    difference () {
        circle(115, $fn=96);
        circle(95, $fn=96);
    }

    translate([0, 0, 420])
    linear_extrude(30) 
    cutoutCircle();

    linear_extrude(450)
    difference() {
        circle(135, $fn=96);
        circle(110, $fn=96);
        square([30, 300], center=true);
    }
}

scale(ViewScale)
{
    columns();
}
