ViewScale = [0.0254, 0.0254, 0.0254];

module airhole()
{
    translate([0, 450, 0])
    rotate([90, 0, 0])
    linear_extrude(900)
    translate([-(317-80)/2, 0, 0])
    hull() union() { circle(40, $fn=96); translate([317-80, 0, 0]) circle(40, $fn=96); }
}

module body()
{
    linear_extrude(676)
    difference() {
    circle(837/2, $fn=96);
//    circle(787/2, $fn=96);
    }
}

module usb()
{
    rotate([0, 0, 90])
    translate([0, -300, 60])
    rotate([90, 0, 0])
    linear_extrude(200)
    square([350, 120], center=true);
}

module button()
{
    rotate([0, 0, -90])
    translate([0, -300, 100])
    rotate([90, 0, 0])
    linear_extrude(200)
    square([340, 200], center=true);
}

//scale(ViewScale)
module model_hotend()
{
    difference() {
    body();
    translate([0, 0, 676-140])
    airhole();
    translate([0, 0, 120])
    usb();
    translate([0, 0, 120])
    button();
    }
}
