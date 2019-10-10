ViewScale = [0.0254, 0.0254, 0.0254];

module model_flip()
{
    color("Cyan")
    linear_extrude(60)
    square([2000, 730], center=true);

    color("CornflowerBlue")
    {
        // headers
        translate([0, 730/2-50-20, 59])
        linear_extrude(400)
        square([2000, 100], center=true);

        // headers
        translate([0, -730/2+50+20, 59])
        linear_extrude(400)
        square([2000, 100], center=true);

        // usb
        translate([1000-220/2+40, 0, 59])
        linear_extrude(110)
        square([220, 300], center=true);

        // reset
        translate([-1000+70-20, 0, 59])
        linear_extrude(110)
        square([140, 140], center=true);
    }
}

//scale(ViewScale)
//{
//    model_flip();
//}
