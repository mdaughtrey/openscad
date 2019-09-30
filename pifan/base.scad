ViewScale = [0.0254, 0.0254, 0.0254];

include <../models/pizerow.scad>
include <../models/ssmicro.scad>
include <../models/hbridge.scad>
include <../models/psu4073.scad>
include <../models/speaker.scad>
include <../models/usbhub.scad>
include <./mountring90.scad>
include <./mount-pizerow.scad>

baseR=2000;
shaftR=500;
speakerH=1200;
//ledInsertH=
insertR=baseR-150;
ledOuterR=85/25.4*1000/2;
ledInnerR=72/25.4*1000/2;

module column()
{
    // outer body
    translate([0, 0, 0])
    linear_extrude(5500)
    union() 
    {
        difference()
        {
            circle(baseR, $fn=96);
            circle(baseR-100, $fn=96);
        }
        tabs();
    }
}

module electronics()
{
    translate([0,0,1190+600+790])
    linear_extrude(200)
    difference()
    {
        circle(baseR-120, $fn=96);
        for(ii=[0:90:360])
        {
            rotate([0, 0, 45+ii])
            translate([1300, 0, 0])
            circle(200, $fn=96);
        }
        tabcutouts();
    }

    // center shaft cutout
    translate([0, 0,1190+600+790+190])
    linear_extrude(500)
    difference()
    {
        circle(500, $fn=96);
        circle(400, $fn=96);
        translate([0, 0, 0])
        square([400, 1100], center=true);
    }
    // shaft cap spacer
    translate([0, 0,1190+600+790+190])
    linear_extrude(500)
    difference()
    {
        circle(600, $fn=96);
        circle(400, $fn=96);
        translate([0, 0, 0])
        square([400, 1200], center=true);
    }

    // center shaft
    translate([0, 0, 690+1190+600+790])
    linear_extrude(4000)
    {
        difference()
        {
            circle(shaftR, $fn=96);
            circle(shaftR-100, $fn=96);
        }
        shafttabs();
    }

    translate([0, 0, 3500])
    color("FireBrick")
    rotate([0, 0, -90])
    mountring90(270, 4);

    for (ii=[0,180])
    rotate([0, 0, ii])
    translate([100, -850, 4200])
    color("DarkOrange")
    rotate([0, 90, 90])
    mount_pizerow();

}


module insert()
{
    insertShaftR=shaftR+30;
    linear_extrude(200)
    circle(insertR, $fn=96);

    translate([0, 0, 190])
    linear_extrude(4000)
    difference()
    {
        circle(insertShaftR+100, $fn=96);
        circle(insertShaftR, $fn=96);
    }
}

module speaker()
{
    linear_extrude(200)
    difference()
    {
        circle(baseR-130, $fn=96);
        circle(1620/2+20, $fn=96);
        for(ii=[0:45:360])
        {
            rotate([0, 0, ii])
            translate([1400, 0, 0])
            circle(200, $fn=96);
        }
        tabcutouts();
    }

    translate([0, 0, 190])
    linear_extrude(1000)
    difference()
    {
        circle(baseR-130, $fn=96);
        circle(baseR-230, $fn=96);
        tabcutouts();
    }
    translate([0, 0, 190])
    linear_extrude(450)
    difference()
    {
        circle(2070/2+120, $fn=96);
        circle(2070/2+20, $fn=96);
    }

    *color("LawnGreen")
    translate([0, 0, 1172])
    rotate([0, 180, 0])
    model_speaker();


}

module ledInsert()
{
//    color("Green")
    linear_extrude(500)
    {
        intersection()
        {
            difference()
            {
                circle(baseR-130, $fn=96);
                circle(ledOuterR-10, $fn=96);
            }
            for (ii = [0:45:360])
            {
                rotate([0, 0, ii])
                square([200, baseR*2], center=true);
            }
        }
        difference() 
        {
            circle(baseR-120, $fn=96);
            circle(baseR-230, $fn=96);
            rotate([0,0,22])
            tabcutouts();
        }
    }
    linear_extrude(200)
    intersection()
    {
        difference() 
        {
            circle(ledOuterR+10, $fn=96);
            circle(ledInnerR-20, $fn=96);
        }
        for (ii = [0:45:360])
        {
            rotate([0, 0, ii])
            square([200, baseR*2], center=true);
        }
    }
    linear_extrude(600)
    difference() 
    {
    circle(ledInnerR-20, $fn=96);
    circle(ledInnerR-70, $fn=96);
    }

}

module baseWeight()
{
    rotate_extrude($fn=96)
    translate([baseR+70, 0, 0])
    {
        difference() 
        {
            difference() 
            {
                circle(2000, $fn=96);
                circle(1900, $fn=96);
            }
            translate([0, -1000, 0])
            square([4000, 2000], center=true);

            translate([-1000, 0, 0])
            square([2000, 4000], center=true);
        }
        translate([0, 1000, 0])
        square([100, 2000], center=true);

        translate([-100, 50, 0])
        square([300, 100], center=true);

        translate([100, 700, 0])
        square([300, 500], center=true);
    }
}


module ventcutouts()
{
    for (ii=[0:90:360])
    {
        rotate([0, 0, ii])
        translate([0, baseR-200, 0])
        rotate([90, 0, 0])
        translate([0, 0, -200])
        linear_extrude(400)
        {
            translate([-300, 0, 0])
            circle(100, $fn=96);
            translate([300, 0, 0])
            circle(100, $fn=96);
            square([600, 200], center=true);
        }
    }
}

module tabs()
{
    for(ii=[0:180:360])
    {
        rotate([0, 0, ii])
        translate([baseR-150, 0, 0])
        square([200, 300], center=true);
    }
}

module tabcutouts()
{
    for(ii=[0:180:360])
    {
        rotate([0, 0, ii])
        translate([baseR-150, 0, 0])
        square([200, 320], center=true);
    }
}

module shafttabs()
{
    for(ii=[0:180:360])
    {
        rotate([0, 0, ii])
        translate([shaftR-100, 0, 0])
        square([150, 150], center=true);
    }
}

module models()
{
    for (ii=[0,180])
    rotate([0, 0, ii])
    translate([550, -690, 4200])
    rotate([90, -90, 0])
    scale([39.3,39.3,39.3])
    pizerow();

//    translate([0, 1200, 4500])
//    rotate([0, -90, 180])
//    scale([39.3,39.3,39.3])
//    pizerow();

    rotate([0, 0, 90])
    translate([0, -1000, 3700])
    rotate([90, 0, 90])
    ssmicro();

//    translate([600, 0, 3700])
//    rotate([0, 90, 0])
//    hbridge();

    translate([600, 0, 5700])
    rotate([0, 90, 0])
    hbridge();

//    translate([-1000, 0, 5300])
//    rotate([0, 0, 90])
//    rotate([0, 90, 180])
//    psu();

    color("LawnGreen")
    translate([0, 0, 1370])
    rotate([0, 0, 0])
    model_speaker();

    translate([-1000, 0, 3700])
    rotate([90, -90, 0])
    usbhub();
}

scale(ViewScale)
{
    color("Cyan")
    translate([0, 0, 600])
    rotate([180,0,0])
    ledInsert();

    color("Peru")
    translate([0, 0, 1190+600])
    rotate([180,0,0])
    speaker();

    translate([0, 0, 100])
    %column();

    translate([0, 0, -750])
    electronics();
//    translate([0, 0, 500])
//    insert();
//    ventcutouts();

//    color("LawnGreen")
//    baseWeight();
//tabcutouts();

    translate([0, 0, -750])
    models();
}

