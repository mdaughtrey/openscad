ViewScale = [0.0254, 0.0254, 0.0254];
include <model_pot.scad>
include <model_banana.scad>
include <model_terminal.scad>
include <model_switch.scad>
include <model_to3.scad>

caseThickness=100;

module models()
{
    // banana plug
    translate([-700, 0, 500]) {
    rotate([-90, 0, 0])
    bananaPlug();
    translate([1400, 0, 0])
    rotate([-90, 0, 0])
    bananaPlug();
    }

    // LM217
    translate([100, -600, 1000])
    to3();

    // switch
    translate([-1400, -620, 1000-388-caseThickness])
    rotate([0, 0, 90])
    switch();

    // terminal
    translate([1000, -1500, 1000-caseThickness])
    rotate([0, 0, 0])
    terminals();

    // pot
    translate([-500, -1500, 1000-caseThickness])
    rotate([0, 0, 0])
    pot();
}

module case()
{
    
}

scale(ViewScale)
{
    color("cornflowerblue")
    models();
    case();
}
