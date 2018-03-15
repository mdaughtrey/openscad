ViewScale = [0.0254, 0.0254, 0.0254];

scale(ViewScale)
{
    linear_extrude(100)
    difference() {
        circle(345, $fn=96);
        circle(240, $fn=96);
    }

    translate([0, 0, 100])
    linear_extrude(80)
    difference() {
        circle(280, $fn=96);
        circle(240, $fn=96);
    }

    translate([0, 0, 180])
    linear_extrude(80)
    intersection() {
        square([800, 1000], true);
        difference() {
            circle(440, $fn=96);
            circle(240, $fn=96);
        }
    }




//    translate([0,-0,100]) linear_extrude(100) circle(345, $fn=96);
//
//
//    translate([0, 1000, 0])
//    linear_extrude(130)
//    difference()
//    {
//        circle(266, $fn=96);
//        circle(125, $fn=96);
//    }

}
