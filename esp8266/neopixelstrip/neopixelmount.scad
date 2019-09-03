ViewScale = [0.0254, 0.0254, 0.0254];

module template()
{
    difference() {
        square([100, 320], center=true);
        translate([-31, -80, 0])
        square([40, 70], center=true);
    }
    translate([-224, 135, 0])
    square([350, 50], center=true);

    translate([-375, 0, 0])
    square([50, 320], center=true);

    translate([-326, 33, 0])
    square([50, 155], center=true);

}

scale(ViewScale)
//module neopixelmount()
{
    linear_extrude(1150)
    template();
}
