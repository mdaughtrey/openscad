ViewScale = [0.0254, 0.0254, 0.0254];

module base()
{
    linear_extrude(100)
    difference() {
    square([1850, 1070], center=true);
        translate([400, 0, 0])
        circle(80/2, $fn=96);
        translate([-400, 0, 0])
        circle(80/2, $fn=96);
    }

    translate([0, 0, 100])
    linear_extrude(50)
    difference() {
    square([1850, 1070], center=true);
        translate([400, 0, 0])
        circle(170/2, $fn=96);
        translate([-400, 0, 0])
        circle(170/2, $fn=96);
    }

    translate([0, 0, 150])
    linear_extrude(50)
    difference() {
        square([1850, 1070], center=true);
        square([1650, 870], center=true);
    }

    translate([0, 0, 200])
    linear_extrude(120)
    difference() {
        translate([-150, 0, 0])
        square([1550, 1070], center=true);
        square([1650, 870], center=true);
    }

    translate([0, 0, 320])
    linear_extrude(100)
    difference() {
        translate([-150, 0, 0])
        square([1550, 1070], center=true);
        translate([50, 0, 0])
        square([1550, 770], center=true);
    }



}

scale(ViewScale)
{
    base();
}