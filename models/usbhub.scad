ViewScale = [0.0254, 0.0254, 0.0254];

module usbhub()
{
    translate([0, 0, 145])
    {
        color("Cyan")
        linear_extrude(40)
        difference()
        {
            square([1062, 943], center=true);
            translate([-710/2, 943/2-89/2-90, 0])
            circle(89/2, $fn=96);
            translate([710/2, 943/2-89/2-90, 0])
            circle(89/2, $fn=96);
        }

        color("CornflowerBlue")
        translate([0, 0, 39])
        linear_extrude(63)
        square([400, 222], center=true);
    }

    color("CornflowerBlue")
    linear_extrude(146)
    translate([-1062/2+89+173/2, -943/2+390/2+173, 0])
    square([173, 390], center=true);

    color("Salmon")
    translate([0, -943/2+150/2,185])
    linear_extrude(20)
    square([1062, 150], center=true);

    color("Salmon")
    translate([0, 943/2-150/2-60,185])
    linear_extrude(20)
    square([410, 150], center=true);
}

scale(ViewScale)
{
    usbhub();
}
