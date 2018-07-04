ViewScale = [0.0254, 0.0254, 0.0254];


module screwMount()
{
    linear_extrude(200)
    difference() {
    circle(170, $fn=96);
    circle(70, $fn=96);
    }
    translate([0, 0, 200])
    linear_extrude(100)
    difference() {
    circle(170, $fn=96);
    circle(130, $fn=96);
    }
}

module earring()
{
    linear_extrude(150)
    difference() {
        circle(325, $fn=96);
        circle(175, $fn=96);
        translate([-150, 100, 0])
        square([220, 300]);
    }
}

module ear()
{
    translate([0, 50, 525])
    rotate([90, 0, 0])
    rotate([0, 0, 45])
    earring();
    linear_extrude(100)
    translate([-200, -100, 0])
    difference() {
        square([400,400]);
        translate([200, 400, 0])
        circle(130);
    }
    
    translate([0, 0, 100])
    linear_extrude(200)
    translate([-200, -100, 0])
    difference() {
        square([400,400]);
        translate([200, 400, 0])
        circle(250);
    }
}

module cableGuide()
{
    screwMount();
    translate([0, -300, 0])
    ear();
    rotate([0, 0, 180])
    translate([0, -300, 0])
    ear();
}

scale(ViewScale)
{
    cableGuide();
}
