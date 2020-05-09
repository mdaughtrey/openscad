ViewScale = [0.0254, 0.0254, 0.0254];


module nodule()
{
    linear_extrude(200)
    circle(100, $fn=96);
    translate([0, 0, 199])
    linear_extrude(100)
    circle(200, $fn=96);
}

module center()
{
    nodestep = 45;
    difference() {
        intersection() {
            union() {
                sphere(1000, $fn=96);
                for (jj = [-90:nodestep: 90]) {
                    rotate([jj, 0, 0])
                    for (ii = [-90:nodestep: 90]) {
                        rotate([0, ii, 0])
                        translate([0, 0, 999])
                        nodule();
                    }
                }
            }
            linear_extrude(2100)
            square([3500, 3500], center=true);
        }
        translate([0, 0, -10])
        linear_extrude(600)
        square([180, 180], center=true);
    }
}

module shaft()
{
    rotate([0, 90, 0])
    translate([0, 0, 1199])

    linear_extrude(1500)
    intersection() {
        circle(100, $fn=96);
        translate([-50, 0, 0])
        square([110, 500], center=true);
    }

}

module batwing()
{
    translate([400, -1300, 0])
    intersection() {
        translate([100, 1300, 0])
        square([1000, 400], center=true);
        difference() {
            circle(1500, $fn=96);
            translate([-200, 800, 0])
            rotate([0, 0, 5])
            union() {
                translate([0, 100, 0])
                circle(400, $fn=96);
                translate([500, 200, 0])
                circle(300, $fn=96);
                translate([850, 300, 0])
                circle(200, $fn=96);
            }
        }
    }
}

module batwings()
{
    linear_extrude(100)
    rotate([0, 0, -90])
    translate([0, 2600, 0]) {
        batwing();
        rotate([0, 180, 0])
        batwing();
   }
}

module hand()
{
    center();
    shaft();
    batwings();
}

scale(ViewScale)
{
    color("Crimson")
    hand();
}
