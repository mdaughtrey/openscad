ViewScale = [0.0254, 0.0254, 0.0254];


module slot()
{
    difference() {
    square([130, 300]);
    translate([0, 160, 0])
    square([80, 100]);
    }
}

module bandMount()
{
    difference() {
    square([130, 200]);
    translate([0, 100, 0])
    square([50, 100]);
    }
}

module screwMount()
{
    linear_extrude(200)
    difference() {
    circle(170, $fn=96);
    circle(70, $fn=96);
    }
    translate([0, 0, 200])
    linear_extrude(100)
    difference() {
    circle(170, $fn=96);
    circle(130, $fn=96);
    }
}

module boardHolder()
{
    rotate([90, 0, 90])
    linear_extrude(2000)
    slot();
    translate([1000, 130+150-15, 0])
    screwMount();
    translate([1000-250, 130, 300+200])
    rotate([90, 180, 90])
    linear_extrude(500)
    bandMount();
}

scale(ViewScale)
{
    boardHolder();
}
