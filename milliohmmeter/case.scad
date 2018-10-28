ViewScale = [0.0254, 0.0254, 0.0254];
include <model_pot.scad>
include <model_banana.scad>
include <model_terminal.scad>
include <model_switch.scad>
include <model_to3.scad>

caseThickness=100;
extHeight=1000;
intHeight=extHeight-caseThickness;

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
    translate([1000, -1300, 1000-388-caseThickness])
    rotate([0, 0, 0])
    switch();

    // terminal
    translate([1000, -1730, 1000-caseThickness])
    rotate([0, 0, 0])
    terminals();

    // pot
    translate([-500, -1730, 1000-caseThickness])
    rotate([0, 0, 0])
    pot();

    // board
    translate([0, -1675, 1000-caseThickness-300])
    rotate([90, 0, 0])
    linear_extrude(60)
    square([3800-caseThickness*2-50, 1000-caseThickness*2-200], center=true);
}

module roundedTemplate()
{
    xoffset=3800/2-100;
    yoffset=2000/2-100;
    //square([3800, 2000], center=true);
    hull() {
        translate([xoffset, yoffset, 0])
        circle(100, $fn=96);
        translate([-xoffset, yoffset, 0])
        circle(100, $fn=96);
        translate([-xoffset, -yoffset, 0])
        circle(100, $fn=96);
        translate([xoffset, -yoffset, 0])
        circle(100, $fn=96);
    }
}

module screwMount(ex, dia) 
{
    //linear_extrude(intHeight-caseThickness)
    linear_extrude(ex)
    difference() {
        circle(150, $fn=96);
        circle(dia/2, $fn=96);
    }
}

module screwMounts()
{
    translate([0, 0, caseThickness]) {
    translate([3800/2-250, -250, 0])
    screwMount(intHeight-caseThickness, 50);
    translate([-(3800/2-250), -250, 0])
    screwMount(intHeight-caseThickness, 50);
    translate([3800/2-250, -1500, 0])
    screwMount(intHeight-caseThickness, 50);
    translate([-(3800/2-250), -1500, 0])
    screwMount(intHeight-caseThickness, 50);
    }
}

module lidScrewMounts()
{
    translate([0, 0, caseThickness]) {
    translate([3800/2-250, -250, 0])
    screwMount(caseThickness-20, 100);
    translate([-(3800/2-250), -250, 0])
    screwMount(caseThickness-20, 100);
    translate([3800/2-250, -1500, 0])
    screwMount(caseThickness-20, 100);
    translate([-(3800/2-250), -1500, 0])
    screwMount(caseThickness-20, 100);
    }
}

module case()
{
    // top
    translate([0, -1000, intHeight])
    linear_extrude(caseThickness)
    roundedTemplate();
//    square([3800, 2000], center=true);

    // walls
    translate([0, -1000, 0])
    linear_extrude(intHeight)
    intersection() {
    roundedTemplate();
    difference() {
    square([3800, 2000], center=true);
    square([3800-caseThickness*2, 2000-caseThickness*2], center=true);
    }}
    boardMount();
    screwMounts();
}

module caseCutouts()
{
    // banana plug
    translate([-700, 0, 500]) {
    rotate([-90, 0, 0])
    bananaPlug_cutout();
    translate([1400, 0, 0])
    rotate([-90, 0, 0])
    bananaPlug_cutout();
    }

    // LM217
    translate([100, -600, 1000])
    to3_cutout();

    // switch
    translate([1000, -1300, 1000-388-caseThickness])
    //translate([-1400, -620, 1000-388-caseThickness])
    rotate([0, 0, 90])
    switch_cutout();

    // terminal
    translate([1000, -1730, 1000-caseThickness])
    rotate([0, 0, 0])
    terminals_cutout();
    translate([1000, -2000, 1000-caseThickness])
    rotate([0, 0, 0])
    terminals_cutout();

    // pot
    translate([-500, -1730, 1000-caseThickness])
    rotate([0, 0, 0])
    pot_cutout();
}

module boardMountPoint()
{
    rotate([0, 0, 90])
    linear_extrude(intHeight-200)
    difference() {
    square([190, 150], center=true);
    translate([0, 0, 0])
    square([90, 160], center=true);
    }
}

module boardMount()
{
    translate([3800/2-caseThickness-190/2, -1710-20/2+15, 200])
    boardMountPoint();
    translate([-(3800/2-caseThickness-190/2), -1710-20/2+15, 200])
    boardMountPoint();
}

module lid()
{
    linear_extrude(caseThickness) 
    difference() {
        roundedTemplate();
        translate([3800/2-250, 750, 0])
        circle(90, $fn=96);
        translate([-(3800/2-250), 750, 0])
        circle(90, $fn=96);
        translate([3800/2-250, -500, 0])
        circle(90, $fn=96);
        translate([-(3800/2-250), -500, 0])
        circle(90, $fn=96);
    }
    translate([0, 1000, 0])
    lidScrewMounts();
}

scale(ViewScale)
{
//    color("cornflowerblue")
//    models();
//    difference() {
//    case();
//    caseCutouts();
//    }
//    translate([0, -1000, -1000])
    lid();
}
