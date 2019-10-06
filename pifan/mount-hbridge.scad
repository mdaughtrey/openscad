ViewScale = [0.0254, 0.0254, 0.0254];

include <../models/hbridge.scad>

module mount_hbridge()
{
//        square([1167,918], center=true);
//    translate([-1167/2+320+330, 0, 0])
//    {
//        for(ii=[-260,260]) {
//            for(jj=[350,-350]) {
//                translate([ii, jj, 0])
//                difference() {
//                    circle(110, $fn=96);
//                    circle(60, $fn=96);
//                }
//            }
//        }
//    }
    for(ii=[-260+66.5, 260+66.5])
    {
        translate([ii, 0, 0])
        linear_extrude(100)
        difference() {
            square([180, 918], center=true);
            translate([0, 350, 0])
            circle(60, $fn=96);
            translate([0, -350, 0])
            circle(60, $fn=96);
        }
    }

    translate([66.5, -918/2-400/2, -170])
    linear_extrude(270)
    square([700, 400],center=true);
}

//scale(ViewScale)
//{
//    translate([0, 0, 500])
//    hbridge();
//    mount_hbridge();
//}
