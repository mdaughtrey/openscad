ViewScale = [0.0254, 0.0254, 0.0254];

module model_wfpga_components()
{
    linear_extrude(100) {
        translate([0, (935/2)-110-50, 0])
        square([2000, 100], center=true);
        translate([0, (-935/2)+110+50, 0])
        square([2000, 100], center=true);
    }

    translate([0, 0, -164])
    linear_extrude(100) {
        translate([0, (935/2)-110-50, 0])
        square([2000, 100], center=true);
        translate([0, (-935/2)+110+50, 0])
        square([2000, 100], center=true);
    }

    // Crystal + LED
    linear_extrude(40) 
    translate([-1100+50+145, 935/2-260-130, 0])
    square([100, 260], center=true);

    // pushbutton
    linear_extrude(80) 
    translate([-1100+125+150, (-935/2)+230+75, 0])
    square([250, 150], center=true);

    // fpga
    linear_extrude(80) 
    translate([-1100+620, 0, 0])
    rotate([0, 0, 45])
    square([280, 280], center=true);

    // flash
    linear_extrude(90) 
    translate([0, (-935/2)+105+320, 0])
    square([280, 210], center=true);

    // usb chip
    linear_extrude(90) 
    translate([1100-280-110, (935/2)-128-260, 0])
    square([220, 255], center=true);

    // reset
    linear_extrude(120) 
    translate([1100-120-270,(-935/2)+75+240,0])
    square([240, 150], center=true);

    // usb
    linear_extrude(120) 
    translate([1100-110+50,(935/2)-150-280,0])
    square([220, 300], center=true);

}

module model_webfpga()
{
    color("Cyan")
    linear_extrude(65)
    square([2200, 935], center=true);

    translate([0, 0, 64])
    color("CornflowerBlue")
    model_wfpga_components();

}

//scale(ViewScale)
//{
//    model_webfpga();
//}
