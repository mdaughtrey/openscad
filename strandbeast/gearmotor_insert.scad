ViewScale = [0.0254, 0.0254, 0.0254];

scale(ViewScale)
{
    linear_extrude(200)
    difference() {
        union() {
        square([200, 800], center=true);
        translate([0, 280, 0])
        circle(200, $fn=96);
        }
        translate([-10, 280, 0])
        intersection() {
            circle(70, $fn=96);
            translate([20, 0, 0])
            square([140, 200], center=true);
        }
    }
}
