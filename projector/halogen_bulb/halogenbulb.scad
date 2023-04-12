ViewScale = [0.0254, 0.0254, 0.0254];

include <model_halogen_bulb.scad>
include <xpe2test.scad>
include <../../models/model_fan_caizhu_1inch.scad>
include <../../libraries/parabolic_reflector.scad>

$fn=96;

module project()
{
    pX=1000;
    pY=pX;
    focus=1000;
    translate([0, -850, 0])
    rotate([-90, 0, 0]) {
        mount();
        translate([0, 0, 850+focus])
        rotate([180, 0, 0])
        translate([-pX/2, -pY/2, 0])
        parabola( 
            focus_point = [pX/2,pY/2,focus],
            base_area   = [pX, pY],
            thickness   = 200
        );
    }
    t0=-1040;
    xa=153;
    xb=200;
    xc=150;

    translate([0, 0, t0])
    linear_extrude(xa)
    difference() {
        circle(970/2);
        circle(560/2);
    }

    translate([0, 0, t0+xa-1])
    linear_extrude(xb)
    difference() {
        circle(870/2);
        circle(660/2);
    }

    translate([0, 0, t0+xa+xb-3])
    linear_extrude(xc)
    difference() {
        circle(1060/2);
        circle(760/2);
        translate([0, -300, 0])
        square([1100, 600],center=true);
    }

    *translate([0, 0, 440])
    linear_extrude(xc)
    difference() {
        circle(1060/2);
        circle(860/2);
    }
}

module forViewing()
{
    translate([0, 0, 1160+870])
    project();

    color("cornflowerblue") {
    translate([0, 0, 1000])
    rotate([0, 0, -45])
    model_halogen_holder();
    translate([-70, 0, 1160])
    model_halogen_bulb();
    model_fan_caizhu_1inch();
    }
}

module forPrinting()
{
    project();
}

scale(ViewScale)
{
//    forPrinting();
    forViewing();
}
