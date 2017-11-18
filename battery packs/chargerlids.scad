ViewScale = [0.0254, 0.0254, 0.0254];

module lid1()
{
    linear_extrude(40) square([880, 1010], center=true);

    // long sides
    translate([-460, 0, 0]) linear_extrude(360) square([50, 1100], center=true);
    translate([460, 0, 0]) linear_extrude(360) square([50, 1100], center=true);

    translate([330, -535, 0]) linear_extrude(360) square([310, 60], center=true);
    translate([-330, -535, 0]) linear_extrude(360) square([310, 60], center=true);

    translate([330, 535, 0]) linear_extrude(360) square([310, 60], center=true);
    translate([-330, 535, 0]) linear_extrude(360) square([310, 60], center=true);

//    translate([0, 525, 0]) linear_extrude(360) square([960, 60], center=true);

}

module lid2()
{
    linear_extrude(40) square([870, 1010], center=true);

    // long sides
    translate([-460, 0, 0]) linear_extrude(300) square([50, 1100], center=true);
    translate([460, 0, 0]) linear_extrude(300) square([50, 1100], center=true);

    translate([330, -535, 0]) linear_extrude(300) square([310, 60], center=true);
    translate([-330, -535, 0]) linear_extrude(300) square([310, 60], center=true);

    translate([330, 535, 0]) linear_extrude(300) square([310, 60], center=true);
    translate([-330, 535, 0]) linear_extrude(300) square([310, 60], center=true);
}

module lid3()
{
    linear_extrude(40) square([900, 1010], center=true);

    // long sides
    translate([-470, 0, 0]) linear_extrude(270) square([50, 1100], center=true);
    translate([470, 0, 0]) linear_extrude(270) square([50, 1100], center=true);

    translate([340, -535, 0]) linear_extrude(270) square([310, 60], center=true);
    translate([-340, -535, 0]) linear_extrude(270) square([310, 60], center=true);

    translate([340, 535, 0]) linear_extrude(270) square([310, 60], center=true);
    translate([-340, 535, 0]) linear_extrude(270) square([310, 60], center=true);
}

scale(ViewScale)
{
    lid3();
//    translate([0, 1000, 0]) lid2();
//    translate([1000, 0, 0]) lid3();
}
