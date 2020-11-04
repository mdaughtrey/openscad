ViewScale = [0.0254, 0.0254, 0.0254];

module aspheric_mount()
{
    translate([0, 125, 995+264])
    rotate([90, 0, 0])
    linear_extrude(250) {
        difference() {
            circle(995, $fn=96);
            circle(795, $fn=96);
            translate([-1000, 0, 0])
            square([2000, 1100]);
        }
        translate([-1050, -100, 0])
        square([300, 200], center=true);

        translate([1050, -100, 0])
        square([300, 200], center=true);
    }

    linear_extrude(165)
    difference() {
        circle(500, $fn=96);
        circle(260, $fn=6);
    }
    translate([0, 0, 164])
    linear_extrude(51)
    difference() {
        circle(500, $fn=96);
        circle(130, $fn=96);
    }

    translate([0, 0, 214])
    linear_extrude(130)
    difference() {
        circle(300, $fn=96);
        circle(150, $fn=96);
    }
}

scale(ViewScale)
{
    aspheric_mount();
}
