ViewScale = [0.0254, 0.0254, 0.0254];

module top()
{
    difference() {
    square([1340, 1980+40]);
    // pot cutout
    translate([265, 1980-600-40, 0])
    circle(320/2);

    // power connector cutout
    translate([690-45, 1980-420, 0])
    square([440, 470]);
    // big LED cutout
    translate([930+50, 620-40, 0])
    circle(250/2);
    // small LED cutout
    translate([930+50, 1100+50, 0])
    circle(170/2);

    // Hall Effect Sensor cutout
    translate([960, 780, 0])
    square([130, 220]);

    // Magnet wire cutouts
    translate([725, 250, 0])
    circle(120/2);
    translate([725+390, 250, 0])
    circle(120/2);
    }
}

module standoffs()
{
    translate([0, 0, -470])
    linear_extrude(470) {
    // thick standoffs
    translate([170, 300, 0])
    circle(240/2);
    translate([170, 1780+50-20, 0])
    circle(240/2);
    // small stands
    translate([1260-70, 100-100, 0])
    square([150, 150]);
    translate([1260-70, 1900-70, 0])
    square([150, 150]);
    }
    
    // boards holes
    translate([0, 0, -570])
    linear_extrude(100) {
    translate([170, 300, 0])
    circle(120/2);
    translate([170, 1780+50-20, 0])
    circle(120/2);
    }

    // LED hole collars
    translate([50, 0, -270])
    linear_extrude(300) {
    // big LED cutout
    translate([930, 620-40, 0])
    difference() {
    circle(350/2);
    circle(250/2);
    }
    // small LED cutout
    translate([930, 1100+50, 0])
    difference() {
    circle(270/2);
    circle(170/2);
    }
    }
}

module sides()
{
    // not cutout
//    translate([-50, -50, -470-200])
//    linear_extrude(520-30)
//    difference() {
//    square([1440, 2080]);
//    translate([50, 50, 0])
//    square([1340, 1980]);
//    }

    // cutout
    translate([-50, -50, -730])
    linear_extrude(780)
    difference() {
    square([1440, 2080]);
    translate([50, 50, 0])
    square([1340, 1980]);
    // power connector cutout
    translate([690-45+50, 1980-420, 0])
    square([440, 520]);

    // big LED cutout
    translate([740, 1980-420, 0])
    square([350, 620]);
    }
}

module lid()
{
    translate([-50, -50, 0]) {
        linear_extrude(100)
        square([1440, 2080]);

        translate([80, 80, 100]) {
        linear_extrude(100)
        difference() {
                square([1270, 1910]);
                translate([50, 50, 0])
                square([1170, 1810]);
            }
        }
        linear_extrude(350)
        translate([1440-390-690/2, 2080-100, 0])
        square([420, 100]);
    }
}

scale(ViewScale)
{
//    linear_extrude(50)
//    top();
//    standoffs();
//    sides();
//    translate([0, 0, -900])
    lid();
}
