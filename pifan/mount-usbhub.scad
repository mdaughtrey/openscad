ViewScale = [0.0254, 0.0254, 0.0254];

include <../models/usbhub.scad>

module mount_usbhub()
{
    for(jj=[0, 150])
    {
        translate([0, 0, jj])
        linear_extrude(100)
        for(ii = [1,-1])
        {
            translate([ii*710/2, 89/2+90, 0])
            difference() {
                union() {
                    circle(189/2, $fn=96);
                    translate([0, -100, 0])
                    square([189,200], center=true);
                }

                circle(89/2, $fn=96);
            }
            translate([0, -125, 0])
            square([710+189, 150], center=true);
        }
    }
    translate([0, -125, 99])
    linear_extrude(55)
    square([710+189, 150], center=true);

    translate([0, -300, 100])
    linear_extrude(270)
    square([500, 270], center=true);
}

//scale(ViewScale)
//{
//    translate([0, 943/2, 0])
//    rotate([0, 0, 180])
//    usbhub();
//    translate([0, 0, 40])
//    mount_usbhub();
//}
