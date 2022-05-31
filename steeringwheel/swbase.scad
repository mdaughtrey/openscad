ViewScale = [0.0254, 0.0254, 0.0254];
include_sw_scad=1;
include <sw.scad>

model = 1;
swMountX = 5220;
swMountY = 3200;
swMountZ = 200;
wallThick = 100;

module model_mainMount()
{
    linear_extrude(swMountZ)
    square([swMountX, swMountY], center=true);
}

module swMount()
{
    dimZ = swMountZ + wallThick * 2 + 30;
    dimY = swMountY + wallThick * 2 + 30;
    dimX = swMountX + wallThick * 2 + 30;

    // Base
    linear_extrude(wallThick)
    square([dimX, dimZ], center=true);
    translate([0, 0, wallThick-1])
    linear_extrude(wallThick + 1) {
        difference() {
            square([dimX, dimZ], center=true);
            square([dimX - wallThick * 2, dimZ - wallThick * 2], center=true);
        }
    }
    // Sides
    for (ii = [0, 180]) {
        rotate([0, 0, ii])
        translate([-dimX/2+dimZ/2, 0, wallThick * 2-1])
        linear_extrude(dimY+1-wallThick*2)
        difference() {
            square([dimZ, dimZ], center=true);
            translate([wallThick/2, 0, 0])
            square([dimZ - wallThick, dimZ-wallThick*2], center=true);
        }
    }
}

module forViewing()
{
    translate([0, 0, 100])
    rotate([-30, 0, 0]) {
        swMount();

        if (model) {
            translate([-600, 1400, swMountY/2 + wallThick])
            rotate([90, 0, 0])
            swscad_forViewing();
        }
    }

}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
