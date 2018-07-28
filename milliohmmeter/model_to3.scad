ViewScale = [0.0254, 0.0254, 0.0254];

module to3()
{
    // base
    linear_extrude(65)
    difference() {
    hull() { 
        circle(1000/2, $fn=96);
        translate([1190/2, 0, 0]) 
        circle(160/2+95, $fn=96);
        translate([-1190/2, 0, 0]) 
        circle(160/2+95, $fn=96);
        }
        translate([1190/2, 0, 0]) 
        circle(160/2, $fn=96);
        translate([-1190/2, 0, 0]) 
        circle(160/2, $fn=96);
    }

    // can
    translate([0, 0, 65])
    linear_extrude(260)
    circle(767/2, $fn=96);

    // pins
    translate([-75, 220, -350])
    linear_extrude(350)
    circle(40/2, $fn=96);

    translate([-75, -220, -350])
    linear_extrude(350)
    circle(40/2, $fn=96);
}

module to3_cutout()
{
    // mounting holes
    translate([0, 0, -150])
    linear_extrude(200) {
    translate([1190/2, 0, 0]) 
    circle(160/2, $fn=96);
    translate([-1190/2, 0, 0]) 
    circle(160/2, $fn=96);
    }

    // pins
    translate([-75, 220, -200])
    linear_extrude(300)
    circle(100/2, $fn=96);

    translate([-75, -220, -200])
    linear_extrude(300)
    circle(100/2, $fn=96);
}

//scale(ViewScale)
//{
//    to3();
//    #to3_cutout();
//}

