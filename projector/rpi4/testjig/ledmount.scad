ViewScale = [0.0254, 0.0254, 0.0254];

module aspheric_mount()
{
    translate([0, 250, 995 + 264 + 200])
    rotate([90, 0, 0])
    linear_extrude(500) {
        difference() {
            circle(1404/2, $fn=96);
            circle(1104/2+10, $fn=96);
            translate([-1000, 0, 0])
            square([2000, 1100]);
        }
        translate([-800, -100, 0])
        square([300, 200], center=true);

        translate([800, -100, 0])
        square([300, 200], center=true);
    }
    linear_extrude(140)
    difference() {
        square([1126, 1136], center=true);
        translate([0, 500, 0])
        square([736, 700], center=true);
        translate([0, -500, 0])
        square([736, 700], center=true);
    }

    linear_extrude(900)
    translate([0, 0, 150])
    difference() {
        square([600, 150], center=true);
        square([300, 150], center=true);
    }

    translate([0, 0, 264 + 995 + 200])
    square([100, 100], center=true);

//    linear_extrude(165)
//    difference() {
//        circle(500, $fn=96);
//        circle(260, $fn=6);
//    }
//    translate([0, 0, 164])
//    linear_extrude(51)
//    difference() {
//        circle(500, $fn=96);
//        circle(130, $fn=96);
//    }
//
//    translate([0, 0, 214])
//    linear_extrude(430)
//    difference() {
//        circle(300, $fn=96);
//        circle(150, $fn=96);
//    }
}

scale(ViewScale)
{
    aspheric_mount();
}

