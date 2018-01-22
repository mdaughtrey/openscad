ViewScale = [0.0254, 0.0254, 0.0254];

module modelUSB()
{
    color("CornflowerBlue", 1.0)
    union() {
    // pcb + wires
    linear_extrude(110)
    square([720, 1110], center=true);

    // USB connector
    translate([0, 0, 110])
    linear_extrude(180)
    translate([0, 741/2+1110/2-128])
    square([476, 741], center=true);

    // header pins
    translate([0, 0, 110])
    linear_extrude(230)
    translate([0, -1110/2+65])
    square([600, 130], center=true);

    // connectors
    translate([0, 0, 110+130])
    linear_extrude(105)
    translate([0, -1110/2-175])
    square([600, 350], center=true);
    }
}

module modelESP8266()
{
    color("CornflowerBlue", 1,0)
    union() {
    // pcb
    linear_extrude(130)
    square([1005, 1520], center=true);

    // long header row
    translate([1005/2-50-60, 0, 130])
    linear_extrude(600)
    square([100, 1005], center=true);

    // long header row
    translate([-1005/2+50+60, 0, 130])
    linear_extrude(600)
    square([100, 1005], center=true);

    // short header row
    translate([0, 1520/2-50-40, 130])
    linear_extrude(600)
    square([630, 100], center=true);

    // wifi module
    translate([0, -(1520-930)/2, 130])
    linear_extrude(40)
    square([630, 930], center=true);
    }
}

module modelButtons()
{
    color("CornflowerBlue", 1.0)
    union() {
    // pcb
    translate([0, 0, 0])
    linear_extrude(110)
    square([1120, 810], center=true);

    // short header row
    translate([-310-100+170, -310-50+200, 110])
    linear_extrude(600)
    square([310, 100], center=true);

    // buttons
    translate([0, -520/2+810/2, 110])
    linear_extrude(470)
    square([980, 520], center=true);
    }
}

module models()
{
    translate([0, 0, 100]) {
    translate([0, -330, 360])
    rotate([0, -90, 180])
    modelUSB();
    translate([1000, -140, 0])
    modelESP8266();
    translate([1700, 60, 810/2])
    rotate([90, 0, 90])
    modelButtons();}

}

scale(ViewScale)
{
    //models();
    translate([1180, -125, 0])
    linear_extrude(100)
    square([2560, 1750], center=true);

    translate([1180, -125, 100])
    {
    linear_extrude(600)
    difference() {
        square([2560, 1750], center=true);
        square([2360, 1550], center=true);
        // USB connector cutout
        translate([-980, -800, 0])
        square([210, 200], center=true);
        // USB headers cutout
        translate([-890, 800, 0])
        square([140, 200], center=true);
        // Button headers cutout
        translate([1220, -50, 0])
        square([120, 400], center=true);
    }}

    // Between USB and ESP
    translate([420, -125, 100])
    linear_extrude(600)
    square([100, 1550], center=true);

    // Between ESP and buttons
    translate([1590, -125, 100])
    linear_extrude(600)
    square([140, 1550], center=true);

    // Button SE corner
    translate([2105, -520, 100])
    linear_extrude(600)
    square([550, 150], center=true);

    // Button NE corner
    translate([2090, 600, 100])
    linear_extrude(600)
    square([550, 100], center=true);



}
