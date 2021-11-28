include <model_phone.scad>
include <model_base.scad>

ViewScale = [0.0254, 0.0254, 0.0254];


module back0(w,h,r)
{
    hull()
    {
        translate([w/2-r, h/2-r, 0])
        circle(r, $fn=96);
        translate([-w/2+r, h/2-r, 0])
        circle(r, $fn=96);

        translate([w/2-r, -h/2+r, 0])
        circle(r, $fn=96);
        translate([-w/2+r, -h/2+r, 0])
        circle(r, $fn=96);
    }
}

module back()
{
    linear_extrude(100)
    difference()
    {
        back0(2500, 3000, 500);
//        square([2500, 3000], center=true);
        translate([0, 500, 0])
        circle(1550/2, $fn=96);
    }

}

module slider()
{
    // Bottom
    linear_extrude(100)
    difference()
    {
        back0(3000, 2500, 500);
        back0(1830, 1600, 500);
        translate([0, -600, 0])
        square([1830, 1900], center=true);
    }

    // Middle
    translate([0, 0, 90])
    linear_extrude(120)
    difference()
    {
        back0(2800, 2300, 500);
        back0(2530, 2100, 500);
        translate([0, -700, 0])
        square([2530, 1500], center=true);
    }

    // Bottom
    translate([0, 0, 209])
    linear_extrude(101)
    difference()
    {
        back0(3000, 2500, 500);
        back0(1830, 1600, 500);
        translate([0, -600, 0])
        square([1830, 1900], center=true);
    }

    // Lip
    translate([0, 1250-50, 309])
    linear_extrude(311)
    square([2000, 100], center=true);

    // Lip
    translate([0, 1150, 619])
    linear_extrude(101)
    square([2000, 200], center=true);

}

module base()
{
    linear_extrude(100)
    difference()
    {
        square([1155, 433], center=true);
        translate([753/2, 0, 0])
        circle(130/2, $fn=96);
        translate([-753/2, 0, 0])
        circle(130/2, $fn=96);
    }
    linear_extrude(400)
    {
        translate([1155/2+50-1, 0, 0])
        square([100, 433], center=true);

        translate([-1155/2-50+1, 0, 0])
        square([100, 433], center=true);
    }
    translate([0, 0, 499])
    linear_extrude(100)
    square([2800, 433], center=true);
}

module mount()
{
    back();
    translate([0, -1500, 433/2+99])
    rotate([-90, 0, 0])
    base();
}

module forViewing()
{
    translate([0, 0, 110])
    mount();
    color("lightblue")
    translate([0, 500, 650])
    rotate([180, 0, 0])
    model_phone();
    color("cornflowerblue")
    translate([0, 1000, 0])
    slider();
}

module forPrinting()
{

}

scale(ViewScale)
{
    forViewing();
}
