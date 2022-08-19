module esp8266Carrier()
{
    insideW = scWidth + 240;
    insideH = scHeight + 240;
    if (false == noModels)
    {
        translate([0, 0, 161])
        model_esp9266_d1_min();
    }

    linear_extrude(50)
    difference()
    {
        square([esp8266PcbWidth+120, esp8266PcbHeight+120], center=true);
        translate([(esp8266PcbWidth+100)/2-25, -20, 0])
        square([95, esp8266PcbHeight/2], center=true);
    }
    
    // Support under antenna
    translate([-esp8266PcbWidth/2+50, 0, 49])
    linear_extrude(112)
    square([100, esp8266PcbHeight], center=true);

    // Support under USB Serial chip
    translate([esp8266PcbWidth/2-240/2-350, 0, 49])
    linear_extrude(50)
    square([240, 390], center=true);

    // Support under reset button
    translate([esp8266PcbWidth/2-192/2-50, esp8266PcbHeight/2-130/2, 49])
    linear_extrude(20)
    square([192, 130], center=true);

    // Walls0
    translate([0, 0, 49])
    linear_extrude(201)
    //linear_extrude(insideH-189)
    difference() 
    {
        square([esp8266PcbWidth+120, esp8266PcbHeight+120], center=true);
        square([esp8266PcbWidth, esp8266PcbHeight], center=true);
        translate([(esp8266PcbWidth+100)/2-25, -20, 0])
        square([95, esp8266PcbHeight/2], center=true);
        translate([-scHeight/2-25, esp8266PcbHeight/2+25, 0])
        square([scHeight, 100], center=true);
        translate([esp8266PcbWidth/2-192/2-50, esp8266PcbHeight/2, 0])
        square([192, 130], center=true);
        translate([esp8266PcbWidth/2-725, -esp8266PcbHeight/2-25, 0])
        square([1100, 100], center=true);
    }

    // Walls1
    translate([0, 0, 249])
    linear_extrude(471)
    //linear_extrude(insideH-279)
    difference() 
    {
        square([esp8266PcbWidth+120, esp8266PcbHeight+120], center=true);
        square([esp8266PcbWidth, esp8266PcbHeight], center=true);

        //translate([-192/2, esp8266PcbHeight/2+25, 0])
        //square([esp8266PcbHeight - 100, 100], center=true);
        translate([-scHeight/2-25, esp8266PcbHeight/2+25, 0])
        square([scHeight, 100], center=true);

        *translate([(esp8266PcbWidth+100)/2-25, -20, 0])
        square([95, esp8266PcbHeight/2], center=true);
        *translate([-(esp8266PcbWidth+100)/2+92/5, -20, 0])
        square([95, esp8266PcbHeight-100], center=true);
        *translate([esp8266PcbWidth/2-192/2-50, esp8266PcbHeight/2, 0])
        square([192, 130], center=true);
        translate([esp8266PcbWidth/2-725, -esp8266PcbHeight/2-25, 0])
        square([1100, 100], center=true);
    }
}
