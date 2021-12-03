ViewScale = [0.0254, 0.0254, 0.0254];

module model_bolt()
{
    // head
    linear_extrude(160)
    circle(268/2, $fn=96);

    // Body
    translate([0, 0, 159])
    linear_extrude(1210)
    circle(162/2, $fn=96);
}

module model_rod()
{
    linear_extrude(130)
    square([130, 1000], center=true);
}

module rrect(w,h,r)
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

module boltswivel()
{
    // base
    linear_extrude(50)
    difference()
    {
        square([500, 500], center=true);
        circle(283/2, $fn=96);
    }

    translate([0, 0, 49])
    linear_extrude(152)
    difference()
    {
        square([500, 500], center=true);
        square([130, 520], center=true);
        circle(283/2, $fn=96);
    }

    // head
    translate([0, 0, 200])
    linear_extrude(170)
    difference()
    {
        square([500, 500], center=true);
        circle(283/2, $fn=96);
    }

    // body
    translate([0, 0, 369])
    linear_extrude(51)
    difference()
    {
        square([500, 500], center=true);
        circle(182/2, $fn=96);
    }


}

module vexmount_side()
{
    difference()
    {
        hull()
        {
            circle(370/2, $fn=96);
            translate([0, 370/2, 0])
            square([370, 170], center=true);
        }
        circle(170/2, $fn=96);
    }
}

module vexmount()
{
    for (ii = [-400,300])
    {
        translate([0, ii, 370/2+170])
        rotate([-90, 0, 0])
        linear_extrude(100)
        vexmount_side();
    }
    linear_extrude(100)
    {
        difference()
        {
            rrect(1400, 900, 100);
            for (ii = [-500,500])
            {
                for (jj = [-250,250])
                {
                    translate([ii, jj, 00])
                    circle(180/2, $fn=96);
                }
            }
        }
    }
}

module forViewing()
{
    translate([0, 0, 200])
    {
        color("lightblue")
        translate([0, 0, 160])
        model_bolt();
        boltswivel();
        color("lightblue")
        translate([0, 0, 50])
        model_rod();
    }
    vexmount();
}

module forPrinting()
{
    boltswivel();
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}


