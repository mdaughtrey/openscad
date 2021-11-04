ViewScale = [0.0254, 0.0254, 0.0254];

include <model_shoot.scad>
include <model_charger.scad>
include <model_lipo.scad>
include <model_slideswitch.scad>

module surround()
{
//    color("black")
    linear_extrude(63)
    difference()
    {
        square([2030, 3990], center=true);
        square([1980, 3950], center=true);
    }
    translate([0, 0, 62])
    linear_extrude(50)
    difference()
    {
        square([2030, 3990], center=true);
        square([1930, 3920], center=true);
    }

    // Crossbar
    translate([0, 3460/2-280, 60])
    linear_extrude(52)
    square([2030, 30], center = true);

    // Crossbar
    translate([0, 3460/2-20, 60])
    linear_extrude(52)
    square([2030, 30], center = true);

    // End bit
//    color("red")
    translate([0, 3460/2+115, 111])
    linear_extrude(100, scale=0.95)
    square([2030, 300], center = true);

}

module body0()
{
    ty = 3460;
    tx = 2030;
    translate([0, -3430/2+ty/2-280, 112])
    difference()
    {
        linear_extrude(200, scale=0.9)
        square([tx, ty], center=true);

        translate([0, 0, -50])
        linear_extrude(200, scale=0.9)
        square([tx, ty], center=true);
    }
}

module test2()
{
    tx = 400;
    ty = 2030;
    color("black")
    translate([3990/2-tx/2, 0, 62])
    difference()
    {
        linear_extrude(200, scale=0.9)
        square([tx, ty], center=true);

        translate([0, 0, -50])
        linear_extrude(200, scale=0.9)
        square([tx, ty], center=true);
    }
}

//module chipsurround14()
//{
//    translate([0, -395, 200])
//    linear_extrude(110)
//    difference()
//    {
//        translate([0, -5, 0])
//}

module body0()
{
    ty = 3460;
    tx = 2030;
    translate([0, -3430/2+ty/2-280, 112])
    difference()
    {
        linear_extrude(200, scale=0.9)
        square([tx, ty], center=true);

        translate([0, 0, -50])
        linear_extrude(200, scale=0.9)
        square([tx, ty], center=true);
    }
}

module test2()
{
    tx = 400;
    ty = 2030;
    color("black")
    translate([3990/2-tx/2, 0, 62])
    difference()
    {
        linear_extrude(200, scale=0.9)
        square([tx, ty], center=true);

        translate([0, 0, -50])
        linear_extrude(200, scale=0.9)
        square([tx, ty], center=true);
    }
}

module chipsurround14()
{
    translate([0, -395, 200])
    linear_extrude(110)
    difference()
    {
        translate([0, -5, 0])
        square([1700, 500], center=true);

        translate([-435, 0, 0])
        square([790, 410], center=true);
        translate([435, 0, 0])
        square([790, 410], center=true);
    }
}

module chipsurround14_cutout()
{
    //color("red")
    translate([0, -395, 200])
    linear_extrude(200)
    {
        translate([-435, 0, 0])
        square([790, 410], center=true);
        translate([435, 0, 0])
        square([790, 410], center=true);
    }
}

module chipsurround16()
{
    translate([0, 835, 63])
    linear_extrude(250)
    difference()
    {
        translate([0, -5, 0])
        square([1750, 500], center=true);

        translate([-435, 0, 0])
        square([820, 410], center=true);
        translate([435, 0, 0])
        square([820, 410], center=true);
    }
}

module chipsurround16_cutout()
{
    //color("red")
    translate([0, 835, 100])
    linear_extrude(300)
    {
        translate([-435, 0, 0])
        square([820, 410], center=true);
        translate([435, 0, 0])
        square([820, 410], center=true);
    }
}

module chargersurround()
{
    innerh = model_charger_pcb()[0];
    innerw = model_charger_pcb()[1];

    translate([520, -1430, 65])
    linear_extrude(230)
    difference()
    {
        square([innerw + 60, innerh - 50], center = true);
        translate([0, -45, 0])
        square([innerw + 10, innerh - 75], center = true);
        // USB cutout
        *translate([0, -innerh/2, 0])
        square([300, 100], center = true);

        // Terminal cutouts
        translate([300, innerh/2-50, 0])
        square([200, 100], center = true);
        translate([-300, innerh/2-50, 0])
        square([200, 100], center = true);
    }

    // Board holddowns
    translate([520, -1430, 110])
    linear_extrude(185)
    difference() 
    {
    square([innerw + 20, innerh - 700], center = true);
    square([innerw - 100, innerh - 600], center = true);
    }


}

module liposurround()
{
    translate([-320, 200, 100])
    linear_extrude(200)
    square([30, 500], center = true);
}

module button_cutout()
{
    translate([centerof(d22(0), d22(2)), centerof(d22(1), d22(3)) + 20 - 24, 200])
    linear_extrude(150)
    {
        circle(260/2, $fn=96);
//        square([40, 260], center = true);
//        square([260, 40], center = true);
    }
}

module pot_cutout()
{
    translate([centerof(443, 344) - 1970/2, centerof(319, 394) - 3840/2, 200])
    linear_extrude(200)
    circle(50, $fn=96);
}

module potsurround()
{
    translate([centerof(443, 344) - 1970/2, centerof(319, 394) - 3840/2, 170])
    linear_extrude(100)
    difference()
    {
        circle(100, $fn=96);
        circle(50, $fn=96);
    }
}

module slideswitchsurround()
{
    translate([500, -740, 100])
    linear_extrude(150)
    difference()
    {
        square([555, 189], center = true);
        square([505, 139], center = true);
        translate([0, -70, 0])
        square([400, 100], center = true);
    }
}


module case()
{
    surround();
    difference()
    {
        body0();
        translate([0, 25-4, 0])
        chipsurround14_cutout();
        translate([0, -40, 0])
        chipsurround16_cutout();
        translate([520, -2000, 60])
        linear_extrude(220)
        square([500, 200], center = true);
        button_cutout();
        pot_cutout();
        translate([500, -740, 100])
        model_slideswitch();
    }
    // Button actuator
    *color("darkred")
    translate([centerof(d22(0), d22(2)), centerof(d22(1), d22(3)), 0])
    {
        translate([0, 0, 84])
        linear_extrude(201)
        difference()
        {
            square([300, 300], center=true);
            square([260, 260], center=true);
        }

        translate([0, 0, 265])
        linear_extrude(20)
        square([300, 300], center=true);

        translate([0, 0, 284])
        linear_extrude(50)
        {
            circle(135/2, $fn=96);
            square([30, 250], center = true);
            square([250, 30], center = true);
        }


    }
    
    translate([0, 25-4, 0])
    chipsurround14();
    translate([0, -40, 0])
    chipsurround16();
    chargersurround();
    liposurround();
    *potsurround();
    slideswitchsurround();
}

module forViewing()
{
    model_shoot();
    *translate([520, -1515, 65])
    rotate([0, 0, -90])
    model_charger("steelblue");

    *translate([-600, 210, 65])
    rotate([0, 0, 90])
    model_lipo("silver");

    case();

    *translate([500, -740, 100])
    model_slideswitch();
// model_shoot_pcb()[0]
//model_shoot_pcbY = function(y,yofs) -(model_shoot_pcb()[1]/2)+(y/2)+yofs;
}

module forPrinting()
{
    case();
}

scale(ViewScale)
{
    //forViewing();
    forPrinting();
}
