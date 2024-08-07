//couplermodel = 1;
couplermodel = 0;
include <model_coupler_bolt.scad>
//module model_coupler_bolt()
//module model_coupler_nut()
//module model_coupler_lockwasher()

module coupler(upperlength, lowerlength, lowerradius, upperradius, outer_radius)
{
    // Height of the coupler, half for the motor shaft and half for the rod
    height = upperlength + lowerlength;
    // External diameter of the coupler
    couplerExternalDiameter = outer_radius*2;
    // Diameter of the motor shaft
//    lowerradius = 235;
    // Diameter of the rod
    threadedRodDiameter = 150;
    // Diameter of the screw thread
    screwDiameter = 120;
    screwHeadDiameter = 226;
    screwThreadLength = 240;
    // Width across flats of the nut (wrench size)
    nutWidth = 235;
    nutThickness = 95;
    // Gap between the two halves
    halvesDistance = 20;

    /* [Hidden] */
    // end of Customizer variables
    // Portion of the shaft inside the coupler
    //lowerlength = height/2;
//    lowerlength = 550;
    // Portion of the rod inside the coupler
    //upperlength = height/2;
 //   upperlength = height - lowerlength;
    shaftScrewsDistance = lowerradius+screwDiameter+1;
    rodScrewsDistance = threadedRodDiameter+screwDiameter+1;

    //$fa = 0.02;
    //$fs = 0.25;
    $fn=96;
    little = 0.01; // just a little number
    big = 10000; // just a big number

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
    difference()
    {
        // main body
        cylinder(d=couplerExternalDiameter, h=height);
        // shaft
        translate([0,0,-little])
            cylinder(d=lowerradius, h=lowerlength+2*little);
        // rod
        translate([0,0,lowerlength])
            cylinder(d=threadedRodDiameter, h=upperlength+little);
        // screws
        translate([0,shaftScrewsDistance/2,lowerlength/2])
            rotate([90,0,90])
                screw();
        translate([0,-shaftScrewsDistance/2,lowerlength/2])
            rotate([90,0,270])
                screw();
        *translate([0,rodScrewsDistance/2,lowerlength+little])
            rotate([90,0,90])
                screw();
        *translate([0,-rodScrewsDistance/2,height])
            rotate([90,0,270])
                screw();
        // cut between the two halves
        cube([halvesDistance,big,big], center=true);
    }
    
}


module couplequarter(shafth, outerradius, shaftr,  boltheadh, boltheadr, boltshaftr, nuth, nutr)
{
    difference() {
        linear_extrude(shafth)
        difference() {
            circle(outerradius, $fn=96);
            circle(shaftr, $fn=96);
            translate([0, -outerradius+20, 0])
            square([outerradius*2, outerradius*2], center=true);

        }

        translate([outerradius/1.5, outerradius+100, shafth/2])
        rotate([90, 0, 0]) {
            translate([-30, 0, -30]) 
            linear_extrude(outerradius)
            circle(boltheadr, $fn=96);
            translate([-30, 0, outerradius-1-30]) {
            linear_extrude(300)
            circle(boltshaftr, $fn=96);
            }
        }

        translate([-outerradius/1.5, 400, shafth/2])
        rotate([90, 0, 0]) {
            translate([30, 0, -30]) 
            linear_extrude(outerradius)
            circle(nutr, $fn=6);
            translate([30, 0, outerradius-1-30]) {
            linear_extrude(200)
            circle(boltshaftr, $fn=96);
            }
        }
    }
    if (couplermodel)
    {
        translate([outerradius/1.5, outerradius/1.5, shafth/2])
        rotate([90, 0, 0]) {
        translate([-30, 0, -30])
        color("green")
        model_coupler_bolt();
        *color("seagreen")
        translate([0, 0, 350])
        model_coupler_lockwasher();
        color("palegreen")
        translate([-30, 0, 350])
        model_coupler_nut();
        }
    }
}

module couplehalf(outerradius, lowershafth, lowershaftr, uppershafth, uppershaftr, boltheadh, boltheadr, boltshaftwr, boltshaftnr, nutr, nuth)
{
    couplequarter(shafth=lowershafth, outerradius=outerradius, shaftr=lowershaftr,  boltheadh=boltheadh,
        boltheadr=boltheadr, boltshaftr=boltshaftwr, nuth=nuth, nutr=nutr);

    translate([0, 0, lowershafth-1])
    couplequarter(shafth=uppershafth, outerradius=outerradius, shaftr=uppershaftr,  boltheadh=boltheadh,
        boltheadr=boltheadr, boltshaftr=boltshaftwr, nuth=nuth, nutr=nutr);
}


//ViewScale = [0.0254, 0.0254, 0.0254];
//scale(ViewScale)
//{
//    coupler();
//}
