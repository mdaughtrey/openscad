model_esp32cam_pcbx = function() 1577;
model_esp32cam_pcby = function() 1074;

modelcolor=1;

module roundedTemplate(w,h)
{
    xoffset=w/2;
    yoffset=h/2;
    r=80;
    translate([xoffset, yoffset, 0])
    hull() {
        translate([xoffset-r, yoffset-r, 0])
        circle(r, $fn=96);
        translate([-xoffset+r, yoffset-r, 0])
        circle(r, $fn=96);
        translate([-xoffset+r, -yoffset+r, 0])
        circle(r, $fn=96);
        translate([xoffset-r, -yoffset+r, 0])
        circle(r, $fn=96);
    }
}

module model_esp32cam()
{
    // Antenna on the left
    if (modelcolor) color("darkblue")
    translate([0, 0, 120])
    linear_extrude(60)
    difference() {
        roundedTemplate(model_esp32cam_pcbx(), model_esp32cam_pcby());
        for (ii=[0:7]) {
            for (jj=[70,model_esp32cam_pcby()-70]) {
                translate([687+ii*100, jj, 0])
                circle(30/2, $fn=48);
            }
        }
    }

    // Lower side- Shielded circuit
    if (modelcolor) color("silver")
    translate([280, 240, 0])
    linear_extrude(120)
    difference() {
        square([677, 616]);
        square([140, 220]);
    }

    // Lower side- Antenna connector
    translate([256, 230, 50]) {
        if (modelcolor) color("gold")
        linear_extrude(50)
        translate([50, 50, 0])
        circle(80/2, $fn=48);

        if (modelcolor) color("white")
        translate([0, 0, 50])
        linear_extrude(20)
        square([100, 100]);

    }
    // Lower side- Electrolytic Cap
    translate([1120, 770, 20])
    if (modelcolor) color("orange")
    linear_extrude(100)
    square([143, 100]);

    // Lower side - pushbutton
    translate([1370, 800, 60]) {
        translate([0, 0, 10])
        if (modelcolor) color("silver")
        linear_extrude(50)
        square([150, 120]);

        if (modelcolor) color("black")
        translate([75, 60, 0])
        linear_extrude(10)
        circle(70/2, $fn=48);
    }

    // Lower side - 3 pin IC
    translate([1290, 450, 60])
    if (modelcolor) color("black")
    linear_extrude(60)
    square([196, 250]);

    // Lower side - 8 pin IC
    translate([1270, 160, 70])
    if (modelcolor) color("black")
    linear_extrude(50)
    square([180, 180]);

    // Upper side - Camera connector
    if (modelcolor) color("beige")
    translate([485,190,180])
    linear_extrude(100)
    square([235, 650]);

    // Upper side - LED
    if (modelcolor) color("yellow")
    translate([350,10,180])
    linear_extrude(100)
    square([120, 120]);

    // Upper side - Micro SD holder
    if (modelcolor) color("silver")
    translate([980,250,180])
    linear_extrude(70)
    square([570, 580]);
}

