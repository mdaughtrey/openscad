// nice (and horribly long) variable names for Thingiverse Customizer

// Height of the coupler, half for the motor shaft and half for the rod
couplerHeight = 960;
// External diameter of the coupler
couplerExternalDiameter = 690;
// Diameter of the motor shaft
motorShaftDiameter = 235;
// Diameter of the rod
threadedRodDiameter = 150;
// Diameter of the screw thread
screwDiameter = 113;
screwHeadDiameter = 213;
screwThreadLength = 500;
// Width across flats of the nut (wrench size)
nutWidth = 214;
nutThickness = 95;
// Gap between the two halves
halvesDistance = 20;

/* [Hidden] */
// end of Customizer variables
// Portion of the shaft inside the coupler
shaftLen = couplerHeight/2;
// Portion of the rod inside the coupler
rodLen = couplerHeight/2;
shaftScrewsDistance = motorShaftDiameter+screwDiameter+1;
rodScrewsDistance = threadedRodDiameter+screwDiameter+1;

//$fa = 0.02;
//$fs = 0.25;
$fn=96;
little = 0.01; // just a little number
big = 10000; // just a big number

module coupler()
{
    difference()
    {
        // main body
        cylinder(d=couplerExternalDiameter, h=shaftLen + rodLen);
        // shaft
        translate([0,0,-little])
            cylinder(d=motorShaftDiameter, h=shaftLen+2*little);
        // rod
        translate([0,0,shaftLen])
            cylinder(d=threadedRodDiameter, h=rodLen+little);
        // screws
        translate([0,shaftScrewsDistance/2,shaftLen/2])
            rotate([90,0,90])
                screw();
        translate([0,-shaftScrewsDistance/2,shaftLen/2])
            rotate([90,0,270])
                screw();
        translate([0,rodScrewsDistance/2,shaftLen+rodLen/2])
            rotate([90,0,90])
                screw();
        translate([0,-rodScrewsDistance/2,shaftLen+rodLen/2])
            rotate([90,0,270])
                screw();
        // cut between the two halves
        cube([halvesDistance,big,big], center=true);
    }
    
}

module screw()
{
    // thread
    cylinder(d=screwDiameter, h=big, center=true);
    // head
    translate([0,0,(screwThreadLength-nutThickness)/2])
        cylinder(d=screwHeadDiameter, h=big);
    // nut
    translate([0,0,-(screwThreadLength-nutThickness)/2])
        rotate([180,0,30])
            cylinder(d=nutWidth*2*tan(30), h=big, $fn=6);
}

ViewScale = [0.0254, 0.0254, 0.0254];
scale(ViewScale)
{
    coupler();
}
