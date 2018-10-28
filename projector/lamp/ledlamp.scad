ViewScale = [0.0254, 0.0254, 0.0254];

module oneLED()
{
    LedD = 203;
    LedLen = 110;
    LipDepth = 50;
    LipDia = 230;

    translate([0, 1000, 0])
    rotate([-90, 0, 0]){
    linear_extrude(LedLen)
    difference() {
    square(280, center=true);
    circle(LedD/2, center=true);
    }
    translate([0, 0, 110])
    linear_extrude(LipDepth)
    difference() {
    square(320, center=true);
    circle(LipDia/2, center=true);
    }}
}

module mount()
{
    rotate([-90, 0, 0])
    linear_extrude(100)
    difference() {
    square([500, 350], center = true);
    translate([0, 50, 0])
    square(180,center=true);
    }
}

scale(ViewScale)
{
    rot = 7;
    rotate([rot, 0, rot]) oneLED();
    rotate([-rot, 0, rot]) oneLED();
    rotate([rot, 0, -rot]) oneLED();
    rotate([-rot, 0, -rot]) oneLED();
    translate([0, 950, 430])
    mount();
}
