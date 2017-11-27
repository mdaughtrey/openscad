ViewScale = [0.0254, 0.0254, 0.0254];

MountD = 1020;
MountR = MountD/2;
//LedD = 793;
LedD = 916;
LedR = LedD/2;
LensD = 680;
LensR = LensD/2;

module ledMount(ext)
{
    linear_extrude(100)
    difference() {
        circle(MountR, $fn=96);
        circle(LedR, $fn=6);
    }
    translate([0, 0, 100])
    difference()
    {
    linear_extrude(250+ext)
    difference() {
        circle(MountR, $fn=96);
        circle(LedR-130, $fn=96);
        translate([MountR, 0, 0]) square(220, center=true);
        translate([-MountR, 0, 0]) square(220, center=true);
    }
    translate([0, 0, -1])
    linear_extrude(100)
    square([150, LedD], center=true);
    }

    translate([0, 0, 100])
    linear_extrude(250+ext)
    translate([212, MountR, 0]) 
    {
    translate([-105, 100, 0])
    square([100, 400], center=true);
    translate([105, 50, 0])
    square([100, 500], center=true);
    translate([-100, 60, 0])
    square([500, 200], center=true);
    }
}

module lensMount()
{
    linear_extrude(50)
    difference() {
        circle(MountR, $fn=96);
        circle(LensR, $fn=96);
    }
    translate([0, 0, 50])
    linear_extrude(40)
    {
    difference() {
        circle(MountR, $fn=96);
        circle(LensR-20, $fn=96);
    }
    }
    // tab
    translate([0, 0, -240])
    linear_extrude(240)
    translate([MountR-40, 0, 0])
    square([100, 210], center=true);

    // tab
    translate([0, 0, -240])
    linear_extrude(240)
    translate([-MountR+40, 0, 0])
    square([100, 210], center=true);
}

scale(ViewScale)
{
//    translate([0, 0, 340+500])
//    rotate([180, 0, 0])
//    ledMount(500);

    translate([1200, 0, 340+1000])
    rotate([180, 0, 0])
    ledMount(1000);

//    translate([0, 1500, 90])
//    rotate([180, 0, 0])
//    lensMount();
}

