ViewScale = [0.0254, 0.0254, 0.0254];
include_sw_scad=1;
include <sw.scad>

//model = 0;
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
    proto = 1;
    dimZ = swMountZ + wallThick * 2 + 60;
    dimY = swMountY + wallThick * 2 + 60;
    dimX = swMountX + wallThick * 2 + 60;

    // Front
    ff = proto ? 0: 030;
    translate([0, 0, 180]) 
    rotate([rr, 0, 0]) {
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
            linear_extrude(proto ? 500 : dimY+1-wallThick*2)
            difference() {
                square([dimZ, dimZ], center=true);
                translate([wallThick/2, 0, 0])
                square([dimZ - wallThick, dimZ-wallThick*2], center=true);
            }
        }
    }

    if (!proto) {
        // Base
        translate([0, dimX/2, 0])
        linear_extrude(wallThick*2)
        difference() {
        square([dimX, dimX], center=true);
        square([dimX-wallThick*4, (dimX-wallThick*2)/2], center=true);
        }

        // Sides
        for (ii = [dimX/2, -dimX/2+wallThick*2]) {
            translate([ii, 60, 0])
            rotate([0, -90, 0])
            linear_extrude(wallThick * 2)
            polygon([[0, 0], [2771, 1600], [0, 3200]]);
        }
    }
}

module forViewing()
{
    translate([0, 0, 100])
    rotate([-30, 0, 0]) {

        if (model) {
            translate([-630, 1400, swMountY/2 + wallThick])
            rotate([90, 0, 0])
            swscad_forViewing();
        }
    }
        swMount();

}

module forPrinting()
{
    swMount();
}

//scale(ViewScale)
//{
//    forViewing();
////    forPrinting();
//}
