ViewScale = [0.0254, 0.0254, 0.0254];

module model_nut()
{
    linear_extrude(170)
    difference()
    {
        circle(377/2, $fn=6);
        circle(140/2, $fn=96);
    }

    translate([0, 0, 169])
    linear_extrude(60)
    difference()
    {
        circle(320/2, $fn=96);
        circle(140/2, $fn=96);
    }
}

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

module adj_rrect(w,h,r)
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

module adj_boltswivel()
{
    // base
    linear_extrude(50)
//    difference()
//    {
        square([500, 500], center=true);
//        circle(283/2, $fn=96);
//    }

    translate([0, 0, 49])
    linear_extrude(152)
    difference()
    {
        square([500, 500], center=true);
        square([130, 520], center=true);
//        circle(283/2, $fn=96);
    }

    // body
    translate([0, 0, 200])
    linear_extrude(830)
    circle(500/2, $fn=96);

    // bolt head insert
    translate([0, 0, 1029])
    linear_extrude(171)
    difference()
    {
        circle(500/2, $fn=96);
//        square([500, 500], center=true);
        circle(283/2, $fn=96);
        translate([0, 250, 0])
        square([283, 500], center=true);
    }

    // bolt head capture
    translate([0, 0, 1199])
    linear_extrude(171)
    difference()
    {
        circle(500/2, $fn=96);
        //square([500, 500], center=true);
        circle(283/2, $fn=96);
        translate([0, 250, 0])
        square([180, 500], center=true);
    }

    // body
    translate([0, 0, 1369])
    linear_extrude(51)
    difference()
    {
        circle(500/2, $fn=96);
        //square([500, 500], center=true);
        circle(182/2, $fn=96);
        translate([0, 250, 0])
        square([180, 500], center=true);
    }


}

module adj_vexmount_side()
{
    difference()
    {
        hull()
        {
            circle(370/2, $fn=96);
            translate([0, 370/2, 0])
            square([370, 170], center=true);
        }
        circle(190/2, $fn=96);
    }
}

module adj_vexmount()
{
    for (ii = [-400,300])
    {
        translate([0, ii, 370/2+170])
        rotate([-90, 0, 0])
        linear_extrude(100)
        adj_vexmount_side();
    }
    linear_extrude(100)
    {
        difference()
        {
            adj_rrect(1400, 900, 100);
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

module adjuster_forViewing()
{
    translate([0, 0, 220])
    {
        rotate([0, -45, 0])
        {
            color("lightblue")
            translate([0, 0, 1160])
            model_bolt();
            adj_boltswivel();
            color("lightblue")
            translate([0, 0, 70])
            model_rod();
*            color("lightblue")
            translate([0, 0, 1000])
            model_nut();
        }
    }
    adj_vexmount();
}

//module forPrinting()
//{
//    adj_boltswivel();
//}
//
module model_adjuster()
{
    adjuster_forViewing();
}

//scale(ViewScale)
//{
//    forViewing();
////    forPrinting();
//}


