ViewScale = [0.0254, 0.0254, 0.0254];

module model_handle()
{
    bigcircle=22040;
    thickness=474;
    //linear_extrude(630)
    linear_extrude(20)
    intersection() {
    circle(3400, $fn=96);
    difference() {
        union() {
            translate([0, -bigcircle+770, 0])
            difference() {
                circle(bigcircle, $fn=96);
                circle(bigcircle-thickness, $fn=96);
            }
            translate([-3142,30,0])
            circle(500/2, $fn=96);
            hull() {
                circle(500/2, $fn=96);
                translate([0, 500, 0])
                circle(500/2, $fn=96);
            }
        }
        circle(114/2, $fn=96);
        translate([-3142,30,0])
        circle(114/2, $fn=96);
    }
    }
}

module template()
{
}

module forViewing()
{
    model_handle();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
