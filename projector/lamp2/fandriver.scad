ViewScale = [0.0254, 0.0254, 0.0254];

module vexmount1()
{
    difference() {
        hull() {
            circle(380/2);
            translate([820, 0, 0])
            square([380, 380], center=true);
        }
        circle(200/2);
    }
}


module vexmount()
{
    linear_extrude(150) {
        vexmount1();
        translate([1500, 0, 0])
        rotate([0, 180, 0])
        vexmount1();
    }
}

module mount()
{
    // bottom bit
    linear_extrude(50)
    difference() {
        square([1260, 510], center=true);
        translate([-50, 0, 0])
        square([560, 350], center=true);
        translate([-530, 0, 0])
        square([100, 410], center=true);
        translate([550, 0, 0])
        square([460, 310], center=true);
    }
    // middle bit
    translate([0, 0, 50])
    linear_extrude(80)
    difference() {
        square([1260, 510], center=true);
        translate([50, 0, 0])
        square([1260, 430], center=true);
    }
    // top bit
    translate([-200, 0, 130])
    linear_extrude(50)
    difference() {
        square([860, 510], center=true);
        translate([300, 0, 0])
        square([960, 350], center=true);
        translate([-330, 0, 0])
        square([100, 410], center=true);
    }
}

scale(ViewScale)
{
    mount();
    translate([0, 500, 0])
    mount();
    translate([-750, -470, 380/2])
    rotate([90, 0, 90])
    vexmount();
}
