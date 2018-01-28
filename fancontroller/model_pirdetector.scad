module model_pirdetector()
{
    color("CornflowerBlue")
    {
    // Cover base
    translate([0, 0, 350+65])
    linear_extrude(140)
    square(910, center=true);

    // Cover
    translate([0, 0, 550+65-140])
    rotate_extrude()
    intersection() {
    circle(450, $fn=96);
    square(500);
    }

    // PCB
    translate([0, 0, 350])
    linear_extrude(65)
    difference() {
    square([953, 1280], center=true);
    translate([0, (1280-80)/2-35, 0])
    circle(40, $fn=96);
    translate([0, -(1280-80)/2+35, 0])
    circle(40, $fn=96);
    }

    // Cap
    translate([(953-164)/2, (1280-164)/2, 0])
    linear_extrude(350)
    circle(164/2, center=true);

    // Cap
    translate([(953-164)/2, -(1280-164)/2, 0])
    linear_extrude(350)
    circle(164/2, center=true);

    // Cap
    translate([-(953-164)/2, (1280-164)/2, 0])
    linear_extrude(350)
    circle(164/2, center=true);

    // Inset Cap
    translate([-(953-164)/2, -(1280-164)/2+220, 0])
    linear_extrude(350)
    circle(164/2, center=true);

    // I/O Header
    translate([(953-100)/2, 0, 0])
    linear_extrude(350)
    square([100, 300], center=true);

    // Jumper Header
    translate([-(953-300)/2+20, -(1280-100)/2+20, 0])
    linear_extrude(350)
    square([300, 100], center=true);

    // Pots
    translate([-(953-180)/2, -(1280-580)/2+440, 0])
    linear_extrude(350)
    square([180, 580], center=true);

    // Chips
    translate([0, 0, 290])
    linear_extrude(60)
    difference() {
    square([953-300, 1280-300], center=true);
    translate([0, (1280-75)/2-35, 0])
    circle(150, $fn=96);
    translate([0, -(1280-75)/2+35, 0])
    circle(150, $fn=96);
    }
    }
}

