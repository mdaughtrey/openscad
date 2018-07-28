ViewScale = [0.0254, 0.0254, 0.0254];

module bananaPlug()
{
    rotate([180, 0, 0])
    translate([0, 0, -900]) {
        linear_extrude(900)
        circle(430/2, $fn=96);

        translate([0, 0, 900])
        linear_extrude(470)
        circle(295/2, $fn=96);

        translate([0, 0, 900+470])
        linear_extrude(350)
        circle(245/2, $fn=96);
    }
}

module bananaPlug_cutout()
{
    rotate([180, 0, 0])
    translate([0, 0, -200])
    linear_extrude(400)
    intersection() {
    circle(310/2, $fn=96);
    square([270, 400], center=true);
    }
}

//scale(ViewScale)
//{
//    bananaPlug();
//    bananaPlug_cutout();
//}

