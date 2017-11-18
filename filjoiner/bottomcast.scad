ViewScale = [0.0254, 0.0254, 0.0254];
lidWidth = 850;
heaterR = 120+5;
heaterD = heaterR * 2;
sensorD = 195+10;
sensorR = sensorD/2;
filR = 35+5;
filD = filR * 2;
fillAW = 250;
fillBW = 250;
baseHeight = 50;
wallThick = 100;

filamentTx = 0;
fillATx = -(fillAW/2 + filR);
heaterTx = -(filR + fillAW + heaterR);
fillBTx = filR + (fillBW/2);
sensorTx = filR + fillBW + sensorR;
wallATx =  -(filR + fillAW + heaterD + wallThick/2);
wallBTx = filR + fillBW + sensorD + wallThick/2;

module lid()
{

    // filament
    linear_extrude(baseHeight + heaterR - filR)
    square([lidWidth, filD], center=true); 

    // fillA between filament and heater
    linear_extrude(baseHeight + heaterR) translate([0, fillATx, 0])
    square([lidWidth, fillAW], center=true);

    // heater
    linear_extrude(baseHeight)
    translate([0, heaterTx, 0]) square([lidWidth, heaterD], center=true);

    // fillB between filament and temp sensor
    linear_extrude(baseHeight + heaterR)
    translate([0, fillBTx, 0])
    square([lidWidth, fillBW], center=true);

    // temp sensor
    linear_extrude(baseHeight + heaterR - sensorR)
    translate([0, sensorTx, 0])
    square([lidWidth, sensorD], center=true);

    // wall A
    linear_extrude(baseHeight + heaterR)
    translate([0, wallATx, 0])
    square([lidWidth, wallThick], center = true);

    // wall B
    linear_extrude(baseHeight + heaterR)
    translate([0, wallBTx, 0])
    square([lidWidth, wallThick], center = true);

    translate([0, 0, -100])
    linear_extrude(100)
    square([lidWidth + 200, wallBTx+(-wallATx)+400], center=true);
}

module wall1()
{
    // wall 1
    translate([lidWidth/2+10, 0, 250]) rotate([0, 90, 0])
    linear_extrude(90)
    difference() {
    square([500, wallBTx+(-wallATx)+400], center=true);
    union() {
        translate([100, heaterTx, 0])
        circle(heaterR*2/3, $fn=96);
        translate([80, 0, 0])
        circle(filR, $fn-96);
        translate([90, sensorTx, 0])
        circle(sensorR/3*2, $fn-96);
    } }
}

module wall2()
{
    // wall 1
    translate([-(lidWidth/2+100), 0, 250]) rotate([0, 90, 0])
    linear_extrude(90)
    difference() {
    square([500, wallBTx+(-wallATx)+400], center=true);
    union() {
//        translate([100, heaterTx, 0])
//        circle(heaterR*2/3, $fn=96);
        translate([80, 0, 0])
        circle(filR, $fn-96);
//        translate([90, sensorTx, 0])
//        circle(sensorR/3*2, $fn-96);
    } }
}

module case()
{
    wall1();
    wall2();
    translate([0, -(wallBTx+(-wallATx)+260)/2, 0])
    linear_extrude(500)
    square([lidWidth+20, 90], center=true);
    translate([0, (wallBTx+(-wallATx)+160)/2, 0])
    linear_extrude(500)
    square([lidWidth+20, 90], center=true);
}

scale(ViewScale)
{
    lid();
    translate([1500, 0, 0])
    case();
}
