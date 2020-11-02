ViewScale = [0.0254, 0.0254, 0.0254];

ROD_LENGTH = 6000;
ROD_DIA = 5/16*1000;
ROD_CENTERS = ((1+21/32) + (5/16)) * 1000;
ROD_TO_APERTURE= 2500;

// rod 5/16 dia
// gap 1 21/32
// length 6
// 2.5 up to center
// GAPS
// camera to lens 2520
// lens to film 3930
//
// LENS

module model_projector()
{
    rotate([0, -90, 0])
    translate([0, -ROD_CENTERS/2, -ROD_LENGTH/2])
    linear_extrude(ROD_LENGTH) {
        circle(ROD_DIA/2, $fn=96);
        translate([0, ROD_CENTERS, 0])
        circle(ROD_DIA/2, $fn=96);
    }

    translate([-ROD_LENGTH/2-1000, 0, ROD_TO_APERTURE+ROD_DIA/2])
    rotate([0, -90, 0])
    linear_extrude(200)
    circle(1000, $fn=96);

}

module rodclamp()
{
    linear_extrude(500)
    difference() {
        union() {
            circle(ROD_DIA+100, $fn=96);
            translate([ROD_DIA+100, 0, 0])
            square([ROD_DIA*2+200, ROD_DIA*2+200], center=true);
        }
        circle(ROD_DIA/2+10, $fn=96);
        translate([ROD_DIA+100, 0, 0])
        square([ROD_DIA*2+200, ROD_DIA+20], center=true);
    }
}

scale(ViewScale)
{
    color("cyan")
    model_projector();
    rodclamp();
}
