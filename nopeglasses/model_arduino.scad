module arduino()
{
    translate([0, 0, 82+36])
    linear_extrude(60)
    square([794, 760]);

    translate([0, 0, 36])
    linear_extrude(82){
    square([794, 760]);
    translate([156, 760, 0])
    square([486, 430]);
    }
    linear_extrude(36)
    translate([270, 270, 0])
    square([310, 310]);
}

