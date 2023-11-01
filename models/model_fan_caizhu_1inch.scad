include <../libs/MCAD/2Dshapes.scad>

module model_fan_caizhu_1inch()
{
    linear_extrude(410) {
        difference() {
            roundedSquare(pos=[1000,1000],r=100);
            for (ii=[-1,1]) { for (jj=[-1,1]) {
                translate([400*ii, 400*jj, 0])
                circle(125/2, $fn=96);
            }}
            circle(940/2, $fn=96);
        }
        circle(630/2, $fn=96);
        for (ii=[60,-60,180]) {
            rotate([0, 0, ii])
            translate([-40, 620/2-10, 0])
            square([80, 20+(940-630)/2]);
        }
    }
}

