module adps9660()
{
    // sensor
    translate([220, 32, 62+40])
    linear_extrude(60)
    square([95, 160]);

    // main board
    translate([0, 0, 40])
    linear_extrude(62)
    difference() {
    square([520, 528]);

    // big holes
    translate([125/2+32,125/2+40, 0])
    circle(125/2, $fn=96);
    translate([520-125/2-32,125/2+40, 0])
    circle(125/2, $fn=96);

    // little holes
    for (ii = [0:10:40])
        translate([38+ii*10+20, 520-52, 0])
        circle(40, $fn=96);
    }
    linear_extrude(40)
    difference() {
    square([520, 400]);
    square([200, 200]);
    translate([520-200, 0, 0])
    square([200, 200]);
    }
}
