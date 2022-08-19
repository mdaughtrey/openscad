ViewScale = [0.0254, 0.0254, 0.0254];

include <../models/apds9960.scad>
//include <../models/vl53l0x.scad>
include <../models/pushbutton.scad>
include <../models/esp8266_d1_min.scad>
//include <../models/pushterminal.scad>
//include <../models/veroboard.scad>
//include <../models/levelshifter.scad>

noModels = true;
esp8266PcbWidth = 1355;
esp8266PcbHeight = 1010;

include <sensorcarrier.scad>
include <scenclosure.scad>
include <lidarenclosure.scad>
include <esp8266Carrier.scad>

module terminals()
{
    if (false == noModels)
    {
        translate([2300, -320, 50])
        rotate([90, 0, 90])
        {
            for (ii = [610, 1210])
            {
                translate([ii, 250, 650/2])
                rotate([0, -90, 0])
                model_PushTerminal([[0,1, false],[1,4, true]]);
            }
            model_Veroboard(13, 6);
        }
     }
     translate([2510, 290, 0])
     {
         // Lower plate
         translate([0, 60, 0])
         linear_extrude(50)
         square([800, esp8266PcbWidth+120], center=true);

         // Support under terminals
         translate([400-250, 0, 49])
         linear_extrude(29)
         square([500, 1000], center=true);

         // Walls
         translate([0, 60, 49])
         linear_extrude(670)
         {
             difference()
             {
                square([800, esp8266PcbWidth+120], center=true);
                square([800, esp8266PcbWidth], center=true);
             }
             translate([130, -esp8266PcbWidth/2+50, 0])
             square([540, 100], center=true);

             translate([-300, -esp8266PcbWidth/2+50, 200])
             square([140, 100], center=true);

             translate([130, esp8266PcbWidth/2-50, 0])
             square([540, 150], center=true);

             #translate([-300, esp8266PcbWidth/2-49, 200])
             square([140, 100], center=true);
         }


     }
}

module terminals2()
{
    if (false == noModels)
    {
        for (ii = [-300,300])
        {
            translate([275, ii, 50])
            model_PushTerminal([[0,1, false],[1,4, true]]);
        }
        translate([-50, -650, 60])
        rotate([0, 90, 0])
        rotate([0, 0, 90])
        model_Veroboard(13, 6);
        translate([-600, 0, 50])
        rotate([0, 0, 90])
        model_LevelShifter();
     }
     linear_extrude(50)
     translate([-250, 0, 0])
     square([1500, esp8266PcbWidth+120], center=true);

     // Support around level shifter
     translate([0, 0, 49])
     translate([-600, 0, 0])
//     color("green")
     linear_extrude(60)
     difference()
     {
        square([600, 730], center=true);
        square([490, 620], center=true);
     }
     // Walls
//     color("red")
     translate([-400, 0, 49])
     linear_extrude(670)
     {
         difference()
         {
            square([1200, esp8266PcbWidth+120], center=true);
            square([1200, esp8266PcbWidth], center=true);
         }
         // Veroboard supports
         translate([320, -esp8266PcbWidth/2+50, 0])
         square([50, 100], center=true);
         translate([430, -esp8266PcbWidth/2+50, 0])
         square([50, 100], center=true);

         // Connector side support
         translate([575, -esp8266PcbWidth/2+60, 0])
         square([50, 160], center=true);


         *translate([-300, -esp8266PcbWidth/2+50, 200])
         square([140, 100], center=true);

         // Veroboard supports
         translate([320, esp8266PcbWidth/2-50, 0])
         square([50, 150], center=true);
         translate([430, esp8266PcbWidth/2-50, 0])
         square([50, 150], center=true);
         // Connector side support
         translate([575, esp8266PcbWidth/2-70, 0])
         square([50, 180], center=true);

         // In between the connectors
         translate([480, -10, 0])
         square([150, 150], center=true);

         // Behind the connectors
         translate([270, -10, 0])
         square([150, 150], center=true);
     }
}

module forViewing()
{
//    translate([-900, 0, scHeight/2+120])
//    rotate([0, 90, 0])
//    rotate([0, 0, 90])
//    {
        scEnclosure();
        sensorCarrier();
//    }
//    translate([499, 0, 0])
//    lidarEnclosure();
//
//    translate([1550, 350, 0])
    //translate([2000, 0, 0])
    rotate([0, 0, 90])
    esp8266Carrier();
//    terminals2();
}

module forPrinting()
{
    //sensorCarrier();
    scEnclosure();
}

scale(ViewScale)
{
    forViewing();
    //forPrinting();
}
