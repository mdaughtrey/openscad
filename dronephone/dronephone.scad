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
        back0(3700, 3000, 500);
//        square([2500, 3000], center=true);
        translate([-610, 550, 0])
        circle(1650/2, $fn=96);
    }

}

module slider()
{
    // Bottom
    linear_extrude(100)
    difference()
    {
        back0(4200, 2500, 500);
        back0(3030, 1600, 500);
        translate([0, -600, 0])
        square([3030, 1900], center=true);
    }

    // Middle
    translate([0, 0, 90])
    linear_extrude(140)
    difference()
    {
        back0(4000, 2300, 500);
        back0(3740, 2100, 500);
        translate([0, -700, 0])
        square([3740, 1500], center=true);
    }

    // Bottom
    translate([0, 0, 229])
    linear_extrude(101)
    difference()
    {
        back0(4200, 2500, 500);
        back0(3030, 1600, 500);
        translate([0, -600, 0])
        square([3030, 1900], center=true);
    }

    // Lip
    translate([0, 1250-50, 309])
    linear_extrude(501)
    square([2000, 100], center=true);

    // Lip
    translate([0, 1150-100, 809])
    linear_extrude(101)
    square([2000, 400], center=true);

}

module base()
{
    linear_extrude(100)
    difference()
    {
        square([1155, 433], center=true);
        translate([753/2, 0, 0])
        circle(80/2, $fn=96);
        translate([-753/2, 0, 0])
        circle(80/2, $fn=96);
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
    square([4200, 433], center=true);
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
    *color("lightblue")
    translate([0, 550, 770])
    rotate([0, -180, 0])
    model_phone();
    color("cornflowerblue")
    translate([0, 1000, 0])
    slider();
}

module forPrinting()
{
    //translate([-2500, 0, 0])
    //mount();
    //translate([2500, 0, 0])
    slider();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
