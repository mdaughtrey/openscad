ViewScale = [0.0254, 0.0254, 0.0254];

module powermount()
{
    baseR=2000;
    difference() {
        union() {
            linear_extrude(50)
            difference() {
                square([850, 850], center=true);
                intersection() 
                {
                    square([500, 430], center=true);
                    circle(470/2, $fn=96);
                }
            }
            translate([0, 0, 49])
            linear_extrude(750)
            difference() {
                square([850, 850], center=true);
                square([750, 750], center=true);
            }
        }
        translate([-baseR/2, 0, baseR+750])
        rotate([0, 90, 0])
        linear_extrude(baseR)
        circle(baseR, $fn=96);
    }

}

//scale(ViewScale)
//{
//    powermount();
//}
