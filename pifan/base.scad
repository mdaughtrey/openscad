ViewScale = [0.0254, 0.0254, 0.0254];

include <../models/pizerow.scad>
include <../models/ssmicro.scad>
include <../models/hbridge.scad>
include <../models/psu4073.scad>
include <../models/speaker.scad>
include <../models/usbhub.scad>
include <../models/tda2030a.scad>
include <../models/audioinjector.scad>
include <../models/model_webfpga.scad>
include <../models/model-levelshifter.scad>
include <../models/model_geared2.scad>
include <../models/model-ws2812-24.scad>
include <./mountring90.scad>
include <./mount-pizerow.scad>
include <./mount-ssmicro.scad>
include <./mount-audioinjector.scad>
include <./mount-usbhub.scad>
include <./mount-tda2030a.scad>
include <./mount-hbridge.scad>
include <./mount-webfpga.scad>
include <./mount-levelshifter.scad>
include <./powermount.scad>
include <./motorhousing.scad>
include <./gears/internal_gear.scad>

baseR=2025;
shaftR=500;
speakerH=1200;
//ledInsertH=
insertR=baseR-150;
ledOuterR=85/25.4*1000/2;
ledInnerR=72/25.4*1000/2;

module column()
{
    // outer body
    difference()
    {
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
        // cutout square
        translate([baseR+50, 0, 2550])
        rotate([0, -90, 0])
        linear_extrude(300)
        square([900,750], center=true);
    }
    translate([baseR, 0, 2400])
    powermount();
}

module shortcolumn()
{
    // lower rim
    linear_extrude(50)
    difference()
    {
        circle(baseR, $fn=96);
        circle(baseR-200, $fn=96);
    }

    // outer body
    translate([0, 0, 0])
    linear_extrude(1000)
    union() 
    {
        difference()
        {
            circle(baseR, $fn=96);
            circle(baseR-100, $fn=96);
        }
        tabs();
    }

    translate([0, 0, 999])
    linear_extrude(1000)
    union() 
    {
        difference()
        {
            circle(baseR, $fn=96);
            circle(baseR-100, $fn=96);
            square([baseR*2-400, baseR*2], center=true);
        }
        tabs();
    }
}

module powerdist()
{
    // Insert
    linear_extrude(100)
    difference() {
        difference() {
            circle(baseR-640, $fn=96);
            circle(620, $fn=96);
            rotate([0, 0, 45])
            square([(baseR-120)*2-50, 430], center=true);
            rotate([0, 0, -45])
            square([(baseR-120)*2-50, 430], center=true);
        }

        difference() {
            circle(baseR-740, $fn=96);
            circle(720, $fn=96);
            rotate([0, 0, 45])
            square([(baseR-120)*2-50, 630], center=true);
            rotate([0, 0, -45])
            square([(baseR-120)*2-50, 630], center=true);
        }
        rotate([0, 0, 45])
        translate([0, baseR/2, 0])
        square([baseR * 2, baseR], center=true);
        rotate([0, 0, -45])
        translate([0, baseR/2, 0])
        square([baseR * 2, baseR], center=true);
    }
    // overlap
    translate([0, 0, 99])
    linear_extrude(100)
    difference() {
        difference() {
            circle(baseR-440, $fn=96);
            circle(620, $fn=96);
            rotate([0, 0, 45])
            square([(baseR-120)*2-50, 330], center=true);
            rotate([0, 0, -45])
            square([(baseR-120)*2-50, 330], center=true);
        }

        difference() {
            circle(baseR-740, $fn=96);
            circle(720, $fn=96);
            rotate([0, 0, 45])
            square([(baseR-120)*2-50, 630], center=true);
            rotate([0, 0, -45])
            square([(baseR-120)*2-50, 630], center=true);
        }
        rotate([0, 0, 45])
        translate([0, baseR/2, 0])
        square([baseR * 2, baseR], center=true);
        rotate([0, 0, -45])
        translate([0, baseR/2, 0])
        square([baseR * 2, baseR], center=true);
    }

    translate([0, -1200, 300])
    rotate([90, 0, 90])
    translate([0, 0, -750])
    linear_extrude(1500) {
        translate([-350, 0, 0])
        difference() {
            square([150, 275], center=true);
            translate([50, 25, 0])
            square([50, 75], center=true);
        }
        translate([350, 0, 0])
        rotate([0, 180, 0])
        difference() {
            square([150, 275], center=true);
            translate([50, 25, 0])
            square([50, 75], center=true);
        }
    }
}

module electronics()
{
    // shaft base
    *translate([0,0,1190+600+790])
    linear_extrude(200)
    union() {
        difference()
        {
            circle(baseR-120, $fn=96);
            circle(baseR-620, $fn=96);
            tabcutouts();
        }
    circle(600, $fn=96);
    rotate([0, 0, 45])
    square([(baseR-120)*2-50, 400], center=true);
    rotate([0, 0, -45])
    square([(baseR-120)*2-50, 400], center=true);
    }

    translate([0, 0, 2800])
    color("Green")
    powerdist();

//    // center shaft cutout
//    translate([0, 0,1190+600+790+190])
//    linear_extrude(500)
//    difference()
//    {
//        circle(500, $fn=96);
//        circle(400, $fn=96);
//        translate([0, 0, 0])
//        square([400, 1100], center=true);
//    }
//    // shaft cap spacer
//    translate([0, 0,1190+600+790+190])
//    linear_extrude(500)
//    difference()
//    {
//        circle(600, $fn=96);
//        circle(400, $fn=96);
//        translate([0, 0, 0])
//        square([400, 1200], center=true);
//    }
//
//    // center shaft
//    translate([0, 0, 3270])
//    linear_extrude(3300)
//    {
//        difference()
//        {
//            circle(shaftR, $fn=96);
//            circle(shaftR-100, $fn=96);
//        }
//        shafttabs();
//    }
//
//    for (ii=[3300,5000])
//    translate([0, 0, ii])
//    color("FireBrick")
//    rotate([0, 0, -90])
//    mountring90(270, 4, 1);
//
//    translate([100, -850, 4200])
//    color("DarkOrange")
//    rotate([0, 90, 90])
//    mount_pizerow();
//
//    rotate([0, 0, 180])
//    translate([100, -1200, 4400])
//    color("DarkOrange")
//    rotate([0, 90, 90])
//    mount_audioinjector();
//
//    *color("DarkOrange")
//    translate([710, 110, 3400])
//    rotate([0, 0, 90])
//    mount_ssmicro();
//
//    *color("DarkOrange")
//    translate([-945, -200, 3550])
//    rotate([180, -90, 0])
//    mount_usbhub();
//
//    color("DarkOrange")
//    translate([-750, -640, 5250])
//    rotate([180, 90, 0])
//    mount_tda2030a();
//
//    color("DarkOrange")
//    translate([-750, -620, 3600])
//    rotate([0, 90, 180])
//    mount_hbridge();
//
//    color("DarkOrange")
//    translate([760, 620, 4500])
//    rotate([0, -90, 180])
//    mount_webfpga();
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
//    innter  2960
//    outer -=3540
//    color("Green")
    linear_extrude(500)
    {
        *intersection()
        {
            difference()
            {
                circle(baseR-130, $fn=96);
                circle(baseR-230, $fn=96);
                //circle(3560/2, $fn=96);
                //circle(ledOuterR-10, $fn=96);
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
            circle(baseR-200, $fn=96);
            rotate([0,0,22])
            tabcutouts();
        }
    }
    linear_extrude(200)
    intersection()
    {
        difference() 
        {
            //circle(ledOuterR+10, $fn=96);
            circle(baseR-190, $fn=96);
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
    circle(ledInnerR+30, $fn=96);
    circle(ledInnerR-40, $fn=96);
    }

    *color("DarkOrange")
    translate([-1300, 0, 100])
    rotate([0, -90, 180])
    mount_levelshifter();

    *translate([0, 0, 300])
    model_ws2812_24();
}

//module ledInsert()
//{
//    innter  2960
//    outer -=3540
////    color("Green")
//    linear_extrude(500)
//    {
//        intersection()
//        {
//            difference()
//            {
//                circle(baseR-130, $fn=96);
//                circle(ledOuterR-10, $fn=96);
//            }
//            for (ii = [0:45:360])
//            {
//                rotate([0, 0, ii])
//                square([200, baseR*2], center=true);
//            }
//        }
//        difference() 
//        {
//            circle(baseR-120, $fn=96);
//            circle(baseR-230, $fn=96);
//            rotate([0,0,22])
//            tabcutouts();
//        }
//    }
//    linear_extrude(200)
//    intersection()
//    {
//        difference() 
//        {
//            circle(ledOuterR+10, $fn=96);
//            circle(ledInnerR-20, $fn=96);
//        }
//        for (ii = [0:45:360])
//        {
//            rotate([0, 0, ii])
//            square([200, baseR*2], center=true);
//        }
//    }
//    linear_extrude(600)
//    difference() 
//    {
//    circle(ledInnerR-20, $fn=96);
//    circle(ledInnerR-70, $fn=96);
//    }
//
//}

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
        translate([baseR-100, 0, 0])
        square([150, 300], center=true);
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

module pizerow_audio()
{
    scale([39.3,39.3,39.3])
    pizerow();
    translate([0, 0, 356])
    audioinjector();
}

module lower_bearing()
{
    bbr=233/2;
    outerR=baseR-120;

    difference() {
    linear_extrude(bbr+50) {
        difference() {
            circle(outerR, $fn=96);
            circle(shaftR, $fn=96);
            tabcutouts();
            for(ii=[0:90:360]) {
                rotate([0, 0, ii+45])
                translate([900, 0, 0])
                square([523+20, 600+20], center=true);
            }
        }
        difference() {
            union(){
                square([250, shaftR*2+50], center=true);
                square([shaftR*2+50, 250], center=true);
                circle(300, $fn=96);
            }
            circle(100, $fn=96);
        }
    }

    // ring
    translate([0, 0, bbr+70])
    rotate_extrude($fn=192)
    translate([outerR*5/6, 0, 0])
    circle(bbr, $fn=96);
   }


   // motorhousing
   rotate([0, 0, -45])
   translate([900, 0, -850])
   motor_housing();

   // support collar
   translate([0, 0, -1000]) {
       linear_extrude(700)
       difference() {
           circle(shaftR+70, $fn=96);
           circle(shaftR+20, $fn=96);
       }

       translate([0, 0, 699])
       linear_extrude(300)
       difference() {
           circle(shaftR+70, $fn=96);
           circle(shaftR+20, $fn=96);
           square([600, 1200], center=true);
           square([1200, 600], center=true);
       }
   }

   // motor model
   color("Green")
   rotate([0, 0, -45])
   translate([900, 0, -900])
   model_geared2();
}

module upper_bearing()
{
    bbr=233/2;
    outerR=baseR-120;

    linear_extrude(100) {
        difference() {
            circle(outerR, $fn=96);
            circle(outerR-600, $fn=96);
        }
       difference() {
//           circle(shaftR+70, $fn=96);
//           circle(shaftR+20, $fn=96);
        union() {
           square([600, outerR*2-50], center=true);
           square([outerR*2-50, 600], center=true);
        }
        circle(100, $fn=96);
       }
    }
    translate([0, 0, 99]) {
        linear_extrude(300)
        difference() {
            circle(300, $fn=96);
            circle(100, $fn=96);
        }
        difference() {
        //linear_extrude(bbr+50) {
        linear_extrude(300) {
            difference() {
                circle(outerR, $fn=96);
                circle(outerR-500, $fn=96);
            }
        }

        // ring
        //translate([0, 0, bbr+70])
        translate([0, 0, 300+20])
        rotate_extrude($fn=192)
        translate([outerR*5/6, 0, 0])
        circle(bbr, $fn=96);
       }
       big_gear();
        }
//   translate([0, 0, -135])
}

module models()
{
    translate([550, -690, 4200])
    rotate([90, -90, 0])
    scale([39.3,39.3,39.3])
    pizerow();

    rotate([0, 0, 180])
    translate([550, -690, 4400])
    rotate([90, -90, 0])
    pizerow_audio();

    *rotate([0, 0, 90])
    translate([110, -770, 4200])
    rotate([90, 0, 180])
    ssmicro();

    translate([-850, -620, 3600])
    rotate([0, 90, -180])
    hbridge();

    color("LawnGreen")
    translate([0, 0, 1370])
    rotate([0, 0, 0])
    model_speaker();

    *translate([-650, -670, 3550])
    rotate([0, -90, 0])
    usbhub();

    translate([-860, -640, 5250])
    rotate([0, -90, 0])
    tda2030a();

    translate([775, 620, 4500])
    rotate([0, -90, 180])
    model_webfpga();

    *translate([-1200, 0, 1200])
    rotate([0, 90, 0])
    model_levelshifter();


}

scale(ViewScale)
{
//    color("Orange")
    translate([0, 0, 600])
    rotate([180,0,0])
    ledInsert();

    color("Peru")
    translate([0, 0, 1190+600])
    rotate([180,0,0])
    speaker();

    translate([0, 0, 100])
    column();
    shortcolumn();

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

    translate([0, 0, 5820])
    lower_bearing();

    !translate([0, 0, 6440])
    rotate([0, 180, 0])
    upper_bearing();
}

