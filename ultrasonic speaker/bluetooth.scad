ViewScale = [0.0254, 0.0254, 0.0254];

module layer0()
{
    difference() {
        square([1560, 1380], center=true);
        translate([0, 50, 0])
        square([1360, 1280], center=true);
    }
    *translate([0, 0, 0])
    square([1460, 100], center=true);
}

module layer1()
{
    difference() {
        square([1560, 1380], center=true);
        translate([0, 50, 0])
        square([1460, 1380], center=true);
    }
}

module layer2()
{
    difference() {
        square([1560, 1380], center=true);
        translate([0, 50, 0])
        square([1360, 1280], center=true);
    }
}

module mount()
{
    linear_extrude(100)
    difference() {
        circle(320/2, $fn=96);
        circle(130/2, $fn=96);
    }
    translate([0, 0, 100])
    linear_extrude(100)
    difference() {
        circle(320/2, $fn=96);
        circle(220/2, $fn=96);
    }
}

scale(ViewScale)
{
    translate([900, 0, 0])
    mount();
    translate([-900, 0, 0])
    mount();
    linear_extrude(100)
    layer0();
    translate([0, 0, 100])
    linear_extrude(60)
    layer1();
    translate([0, 0, 160])
    linear_extrude(50)
    layer2();
}
