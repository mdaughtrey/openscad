ViewScale = [0.0254, 0.0254, 0.0254];

dsunhole = 6.4/25.4*1000;
cutoff = dsunhole/sqrt(2);

//module gearMotorInsert()
//{
//    difference() {
//        circle(200, $fn=96);
//        intersection() {
//            circle(70, $fn=96);
//            translate([20, 0, 0])
//            square([140, 200], center=true);
//        }
//    }
//}

module stepperInsert()
{
    difference() {
        circle(200, $fn=96);
        intersection() {
            circle(205/2, $fn=96);
            square([135, 400], center=true);
        }
    }
}
module gearsetShaft()
{
    difference() {
    circle(dsunhole/2-10, $fn=96);
    translate([cutoff+10, 0, 0])
    square(dsunhole, dsunhole, center = true);
    rotate([0, 0, 180])
    translate([cutoff+10, 0, 0])
    square(dsunhole, dsunhole, center = true);
    }

}

scale(ViewScale)
{
    linear_extrude(500)
    gearsetShaft();

    translate([0, 0, 500])
    linear_extrude(100)
    circle(200, $fn=96);


    translate([0, 0, 600])
    linear_extrude(200)
    stepperInsert();
}
