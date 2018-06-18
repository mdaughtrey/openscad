ViewScale = [0.0254, 0.0254, 0.0254];

module onehole()
{
    intersection() {
    circle(160, $fn=96);
    square([500, 270], center=true);
    }
}

module fourholes()
{
    onehole();
    translate([0, 550, 0])
    onehole();
    translate([0, 1100, 0])
    onehole();
    translate([0, 1100+550, 0])
    onehole();
}


module panel()
{
    difference() {
    square([750, 1400+500+550]);
    translate([375, 150+250, 0])
    fourholes();
    }
}

module walls()
{
    difference() {
        square([750, 1400+500+550], center=true);
        square([650, 1400+400+550], center=true);
    }
}

module connectors()
{
    linear_extrude(100)
    panel();
    translate([375, 950+275, 100])
    linear_extrude(1000)
    walls();
    linear_extrude(200)
    translate([750, 0, 0])
    square([200, 2450]);

}

scale(ViewScale)
{
    connectors();
}
