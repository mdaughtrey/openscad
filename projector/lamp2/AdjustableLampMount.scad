include <tabcoupling.scad>
include <model_fan.scad>
ViewScale = [0.0254, 0.0254, 0.0254];

module model_vexstrip(holes)
{
    holes = holes - 1;
    translate([0, 0, -30])
    linear_extrude(60)
    difference() 
    {
        square([500 * (holes + 1), 500], center = true);
        for (ii = [-500*holes/2:500:500*holes/2])
        {
            translate([ii, 0, 0])
            square([180, 180], center = true);
        }
    }
}



module vexarm(length, h0, h1, hollow)
{
    // vex mount
    difference()
    {
        hull()
        {
            translate([0, -length/2, 0])
            circle(400/2, $fn=96);
            translate([0, length/2, 0])
            circle(400/2, $fn=96);
        }

        if (hollow)
        {
            hull()
            {
                translate([0, -length/2, 0])
                circle(180/2, $fn=96);
                translate([0, length/2, 0])
                circle(180/2, $fn=96);
            }
        }


        if (h0)
        {
            translate([0, -length/2, 0])
            circle(180/2, $fn=96);
        }
        if (h1)
        {
            translate([0, length/2, 0])
            circle(180/2, $fn=96);
        }
    }
}

module vexmount(length)
{
    // vex mount
    vexarm(1000, 1, 1);

    // upper arm
    translate([707/2, 707/2+500, 0])
    rotate([0, 0, -45])
    vexarm(1000, 1 ,0);

    translate([1307, 500+707, 0])
    rotate([0, 0, -90])
    vexarm(1200, hollow = 1);

    // lower arm
    translate([707/2, -707/2-500, 0])
    rotate([0, 0, 45])
    vexarm(1000, 0 ,1);

    translate([1307, -500-707, 0])
    rotate([0, 0, -90])
    vexarm(1200, hollow = 1);

}

module bodymount()
{
    difference()
    {
        vexarm(2800, hollow = 1);
        circle(1820/2, $fn=96);
    }
    difference()
    {
        circle(1830/2, $fn=96);
        circle(1480/2, $fn=96);
        for (ii = [0:120:360])
        {
            rotate([0, 0, ii])
            intersection() {
                difference() {
                    circle(1680/2, $fn=96);
                    circle(1480/2, $fn=96);
                }
//                rotate([0, 0, 45]) 
                translate([0, 700, 0])
                square([180, 300], center=true);
            }
        }
    }
}

module fan_mount()
{
//     linear_extrude(100)
//     {
//         difference()
//         {
//             hull()
//             fourcircles(1570, 250);
//             fourcircles(1400, 140);
//             circle(700, $fn=96);
//         }
//         difference()
//         {
//             vexarm(2800, hollow = 1);
//             circle(1500/2, $fn=96);
//         }
//     }

    linear_extrude(100)
    {
        difference()
        {
            hull()
            {
                translate([1270/2, 1270/2, 0])
                circle(340/2, $fn=96);
                translate([-1270/2, 1270/2, 0])
                circle(340/2, $fn=96);
            }
            translate([0, -100, 0])
            circle(1570/2, $fn=96);
            for (ii = [1270/2,-1270/2])
            {
                translate([ii, 1270/2, 0])
//                difference()
//                {
//                    circle(340/2, $fn=96);
                    circle(140/2, $fn=96);
//                }
            }
        }
        difference()
        {
            translate([0, 700, 0])
            vexarm(1400, hollow = 1);
            circle(1500/2, $fn=96);
        }
    }
}

module standoff()
{
    linear_extrude(1200)
    difference()
    {
        circle(400/2, $fn=96);
        circle(180/2, $fn=96);
    }
}

module forViewing()
{
    // Models
    translate([800, 140, 0])
    rotate([90, 0, 0])
    tabcoupling();

    translate([-800, 0, 0])
    rotate([90, 0, 0])
    rotate([0, 0, 90])
    model_vexstrip(10);

    // Part 1
    color("blue")
    translate([-800, -200, 0])
    rotate([90, 0, 0])
    linear_extrude(200)
    vexmount();

    // Part 2
    color("green")
    translate([800, -400, 0])
    rotate([90, 0, 0])
    linear_extrude(200)
    bodymount();

    // Fan
    translate([800, 600, 0])
    rotate([-90, 0, 0])
    {
        color("red")
        model_fan();
        translate([0, 0, -100])
        color("cyan")
        fan_mount();

        color("brown")
        translate([0, 1570/2+400, -800])
        standoff();
    }
}

module forPrinting()
{
//    linear_extrude(200)
//    {
//        vexmount();
        translate([2500, 0, 0])
        bodymount();
//    }
    standoff();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
