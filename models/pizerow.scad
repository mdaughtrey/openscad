ViewScale = [0.0254, 0.0254, 0.0254];

module sd()
{
    linear_extrude(1.32)
    square([11.96,11.35], center=true);
}

module usb()
{
    linear_extrude(2.67)
    square([7.71,5.8], center=true);
}

module hdmi()
{
    linear_extrude(3.16)
    square([11.19,7.57], center=true);
}

module camera()
{
    linear_extrude(1.28)
    square([4.3,16.96], center=true);
}

module cpu()
{
    linear_extrude(1.3)
    square([12,12], center=true);
}

module io()
{
    linear_extrude(10)
    square([51,5], center=true);
}

module pcb()
{
    linear_extrude(1.42)
    difference()
    {
        union()
        {
            xpos=(65/2)-3;
            ypos=(30/2)-3;
            translate([xpos, ypos,0])
            circle(3, $fn=96);
            translate([-xpos, ypos,0])
            circle(3, $fn=96);
            translate([xpos, -ypos,0])
            circle(3, $fn=96);
            translate([-xpos, -ypos,,0])
            circle(3, $fn=96);
            square([65,30-6], center=true);
            square([65-6,30], center=true);
        }
        xpos=(65/2)-3.5;
        ypos=(30/2)-3.5;
        translate([xpos, ypos, 0])
        circle(2.5/2, $fn=96);
        translate([-xpos, ypos, 0])
        circle(2.5/2, $fn=96);
        translate([xpos, -ypos, 0])
        circle(2.5/2, $fn=96);
        translate([-xpos, -ypos, 0])
        circle(2.5/2, $fn=96);
    }
}

module pizerow()
{
    color("cyan")
    pcb();
    translate([-((65/2)-(11.96/2)-1.25), 16.9-15, 1.42])
    color("CornflowerBlue")
    sd();

    translate([-((65/2)-(41.4)), -((30/2)+1.24-(5.8/2)), 1.42])
    color("CornflowerBlue")
    usb();

    translate([-((65/2)-(54)), -((30/2)+1.24-(5.8/2)), 1.42])
    color("CornflowerBlue")
    usb();

    translate([-((65/2)-12.4), -((30/2)+0.62-(7.57/2)), 1.42])
    color("CornflowerBlue")
    hdmi();

    translate([((65/2)-(4.3/2)), 0, 1.42])
    color("CornflowerBlue")
    camera();

    translate([-((65/2)-25.61), 0, 1.42])
    color("CornflowerBlue")
    cpu();

    translate([0, (30/2)-3.5, 1.42])
    color("CornflowerBlue")
    io();
}

//scale(ViewScale)
//{
//    pizerow();
//}
