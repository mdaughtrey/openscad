include <defs.scad>

extR = ShaftR + ((JointR - ShaftHole)/2);
extL = 400;
extW = StrutWidth;

module joint()
{
    linear_extrude(LayerUnit)
    difference()
    {
        circle(JointR, $fn=96);
        circle(ShaftHole, $fn=96);
    }
}

module ext(eW, eL, eO)
{  
    intersection() {
    translate([extR, -eW/2, 0]) square([eL, eW], 1);
    difference() {
        circle(JointR + eL, $fn=96);
        circle(JointR + eO, $fn=96);
    }}
}

joint();

linear_extrude(LayerUnit) ext(extW, extL, 0);
translate([0, 0, LayerUnit])
linear_extrude(SpacedLayer)
ext(extW, extL, 30);
