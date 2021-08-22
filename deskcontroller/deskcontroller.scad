ViewScale = [0.0254, 0.0254, 0.0254];

include <../models/apds9960.scad>
include <../models/vl53l0x.scad>
include <../models/pushbutton.scad>
include <../models/esp8266_d1_min.scad>
include <../models/pushterminal.scad>
include <../models/veroboard.scad>

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

module forViewing()
{
    translate([-900, 0, scHeight/2+120])
    rotate([0, 90, 0])
    rotate([0, 0, 90])
    {
        scEnclosure();
//        sensorCarrier();
    }
    translate([499, 0, 0])
    lidarEnclosure();

    translate([1550, 350, 0])
    //translate([2000, 0, 0])
    rotate([0, 0, 90])
    esp8266Carrier();
    terminals();
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
