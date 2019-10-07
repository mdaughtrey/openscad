ViewScale = [0.0254, 0.0254, 0.0254];

module powermount()
{
    baseR=2000;
    difference() {
        translate([300, 0, -200])
        rotate([0, -45, 0])
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
            linear_extrude(850)
            difference() {
                square([850, 850], center=true);
                square([750, 750], center=true);
            }
        }
        translate([-baseR, 0, -baseR/2])
        //rotate([0, 45, 0])
        linear_extrude(baseR)
        circle(baseR, $fn=96);
    }

}

//scale(ViewScale)
//{
//    powermount();
//}
