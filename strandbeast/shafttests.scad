include <defs.scad>

scale(ViewScale)
{
    linear_extrude(500) {
    difference() {
    circle(ShaftTight*2, $fn=96);
    circle(ShaftTight+5, $fn=96); }

    translate([1000, 0, 0])
    difference() {
    circle(ShaftTight*2, $fn=96);
    circle(ShaftTight+10, $fn=96); }
    }
}
