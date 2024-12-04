include <../BOSL2-master/std.scad>

module model_esp8266_d1_min(anchor=CENTER,spin=0,orient=UP)
{
    pcbWidth = 1355;
    pcbHeight = 1010;
    module model_esp8266_d1_min_()
    {
        color("CornflowerBlue")
        // Main PCB
        linear_extrude(50)
        square([pcbWidth, pcbHeight], center=true);

        // ESP 8266 Carrier
        color("SteelBlue")
        translate([-pcbWidth/2+947/2, 0, 49])
        linear_extrude(36)
        square([947, 630], center=true);

        // ESP8266 Module
        color("SkyBlue")
        translate([-pcbWidth/2+590/2+290, 0, 84])
        linear_extrude(100)
        square([590, 470], center=true);

        // USB Connector under board
        color("SteelBlue")
        translate([pcbWidth/2-220/2, -30, -110])
        linear_extrude(111)
        square([220, 320], center=true);

        // Reset button under board
        color("SteelBlue")
        translate([pcbWidth/2-192/2-50, pcbHeight/2-130/2, -90])
        linear_extrude(91)
        square([192, 130], center=true);

        // USB Serial chip under board
        color("SteelBlue")
        translate([pcbWidth/2-240/2-350, pcbHeight/2-390/2-350, -60])
        linear_extrude(61)
        square([240, 390], center=true);
    }
    attachable(anchor,spin,orient,size=[pcbWidth, pcbHeight, 247])
    {
        model_esp8266_d1_min_();
        children();
    }
}

