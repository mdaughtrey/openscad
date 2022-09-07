ViewScale = [0.0254, 0.0254, 0.0254];

module upper()
{
//    module template(r) {
//        rotate([0, 0, r])
//        rotate_extrude(angle = 15, convexity=2, $fn=96)
linear_extrude(200)
        translate([13500-250, 0, 0]) {
            difference() {
                square([900, 500]);
                translate([350, 150]) 
                circle(250/2, $fn=96);
                translate([225, -100, 0])
                square([250, 250]);
            }
            // Spine
            translate([474, -475, 0])
            square([426, 476]);
            // Chin
            translate([-2100, -975, 0])
            square([3000, 500]);
        }
//    }
//    template(15); 
//    template(-30);

}

module forViewing()
{
    upper();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
