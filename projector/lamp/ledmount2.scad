ViewScale = [0.0254, 0.0254, 0.0254];

module diff1()
{
    LedD = 203;
    LipDepth = 50;
    LipDia = 230;

    cylLen = 300;
    translate([cylLen, 0, 0])
    rotate([0, -90, 0])
    {
    cylinder(r=LedD/2, cylLen, $fn=96);
    translate([0, 0, cylLen-1])
    cylinder(r=LipDia/2, 300, $fn=96);
    }
}

module diffModel()
{
    rot = 8;
    rot2 = 2;
    rotate([0, rot, rot])
    translate([-1000, 0, 0])
    rotate([0, rot2, rot2])
    diff1();
    rotate([0, -rot, rot])
    translate([-1000, 0, 0])
    rotate([0, -rot2, rot2])
    diff1();
    rotate([0, rot, -rot])
    translate([-1000, 0, 0])
    rotate([0, rot2, -rot2])
    diff1();
    rotate([0, -rot, -rot])
    translate([-1000, 0, 0])
    rotate([0, -rot2, -rot2])
    diff1();
}


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
    rotate([0, 90, 0])
    linear_extrude(100)
    difference() {
    square([400, 600], center = true);
    translate([0, 0, 0])
    square(180,center=true);
    }
}

scale(ViewScale)
{
    difference() {
    translate([-950, 0, 0])
    cube([150, 600, 600], center=true);
    diffModel();
    }
    translate([-975, 0, 500])
    mount();
}
