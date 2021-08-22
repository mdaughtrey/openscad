module Arduino()
{
    color("CornflowerBlue")
    {
    // pcb + midboard
    linear_extrude(200)
    square([788, 755], center=true);

    // usb 
    translate([0, -755/2-422/2, 0])
    linear_extrude(83)
    square([482, 422], center=true);

    // solder joints on to of midboard
    translate([0, 422-120, 200])
    linear_extrude(75)
    square([606, 120], center=true);

    // solder joints on side of midboard
    translate([-(755-120)/2, 60, 200])
    linear_extrude(75)
    square([120, 606], center=true);

    // solder joints on the other side of midboard
    translate([(755-120)/2, 60, 200])
    linear_extrude(75)
    square([120, 606], center=true);

    // solder joints under midboard
    translate([0, 422-120, -75])
    linear_extrude(75)
    square([606, 120], center=true);

    // left lower header base
    translate([-(568+100)/2, -(600-422)/2+20, -100])
    linear_extrude(100)
    square([100, 600], center=true);

    // right lower header base
    translate([(568+100)/2, -(600-422)/2+20, -100])
    linear_extrude(100)
    square([100, 600], center=true);

    // left lower headers
    translate([-(568+100)/2, -(600-422)/2+20, -320])
    linear_extrude(220)
    square([28, 524], center=true);

    // right lower header base
    translate([(568+100)/2, -(600-422)/2+20, -320])
    linear_extrude(220)
    square([28, 524], center=true);
    }
}

module ADPSSensorBoard()
{
    color("OrangeRed")
    {
    // APDS9660 sensor
    translate([0, 521/2-161, 65])
    linear_extrude(56)
    square([95, 161], center=true);
    }
    color("CornflowerBlue")
    {
    // APDS9660 carrier
    translate([0, -(755-521)/2+35, 0])
    linear_extrude(65)
    square([532, 521], center=true);
    }
}

//ViewScale = [0.0254, 0.0254, 0.0254];
//scale(ViewScale)
//{
//    ADPSSensorBoard();
////    Arduino();
//}
