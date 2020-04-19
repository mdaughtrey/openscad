ViewScale = [0.0254, 0.0254, 0.0254];

module inserts()
{
    offset=-20;
//    translate([0, 660, 0])
//    square([1200+offset,180+offset], center=true);
//    translate([0, 1070, 0])
//    square([3800+offset,140+offset], center=true);
//    translate([0, 1740, 0])
//    square([3800+offset,100+offset], center=true);
//    translate([600, 2460, 0])
//    square([2700+offset,100+offset], center=true);
//    translate([-1200, 2460, 0])
//    rotate([0, 0, 45])
    union() {
        square([700+offset,100+offset], center=true);
        square([100+offset,700+offset], center=true);
    }
}


PLATELIFT2=70;
scale(ViewScale)
linear_extrude(PLATELIFT2) 
inserts();
