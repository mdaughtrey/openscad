use <../../libraries/OpenSCAD bottle threads/thread_profile.scad>
include <../../libraries/myutils.scad>
include <model_encoder.scad>


module inner()
{
    union() {
    linear_extrude(1000)
    difference() {
         circle(1140/2, $fn=96);
         circle(1090/2, $fn=96);
     }
    rotate([0, 0, 180])
    straight_thread(
//        section_profile = [[0,0], [50, 50], [0, 100]],
        section_profile = [[0,0], [45, 45], [45, 55],  [0, 100]],
        higbee_arc = 20,
        r = 1138/2,
        turns = 8.5,
        pitch = 101,
        fn=96);
    }
}

module vexmount()
{
    union() {
//        translate([0, 0, 50])
        //linear_extrude(900)
        linear_extrude(1100)
        difference() 
        {
             //circle(1310/2, $fn=96);
             //circle(1260/2, $fn=96);
             circle(1308/2, $fn=96);
             circle(1265/2, $fn=96);
        }

//        linear_extrude(900)
//        difference()
//        {
//            square(1360, center=true);
//            square(1260, center=true);
//        }

        // color("green")
//        translate([0, 0, 50])
        translate([0, 0, 100])
       straight_thread(
            section_profile = [[0, 0], [-45, 45], [0, 90], [0, 210], [-45, 255], [0, 300]],
            higbee_arc = 20,
            r = 1268/2,
            turns = 2,
            pitch = 300,
            fn=96);
    }
}

module outer()
{
    union() {
    linear_extrude(1000)
    difference() {
         circle(1290/2, $fn=96);
         circle(1240/2, $fn=96);
     }
    straight_thread(
        //section_profile = [[0,0], [-50, 50], [0, 100]],
        section_profile = [[0,0], [-45, 45], [-45, 55],  [0, 100]],
        higbee_arc = 20,
        r = 1243/2,
        turns = 8.5,
        pitch = 101,
        fn=96);
    }
}

// scale(ViewScale)
// {
//     inner();
//     outer();
// }

module innerthread()
{
 //   color("green")
    intersection()
    {
       straight_thread(
            section_profile = [[0,0], [100,0], [145, 45], [145, 55],  [100, 100], [0,100]],
            higbee_arc = 20,
            r = 950/2,
            turns = 7,
            pitch = 300,
            //pitch = 101,
            fn=96);

       linear_extrude(2209)
       for (ii = [60:120:360])
       {
            rotate([0, 0, ii])
            translate([650, 0, 0])
            square([300, 200], center=true);
       }
    }
}

module bearing_support()
{
    zerh(0, 121, 820/2, 433/2);
    zerh(120, 34, 820/2, 502/2);
//    zerh(36, 121, 433/2, 157/2);

//    zerh(0, 37, 492/2, 157/2);
//    zerh(36, 121, 433/2, 157/2);
}

module encoder_enclosure0()
{
    // Encoder enclosure
    zerh(0, 341, 1640/2, 1540/2);
    translate([0, 0, 340])
    linear_extrude(51)
    difference()
    {
        circle(1640/2, $fn=96);
        for (ii = [0:120:360])
        {
            rotate([0, 0, ii])
            translate([546, 0, 0])
            circle(120/2, $fn=96);
        }
        circle(805/2, $fn=96);
        //circle(1640/2, $fn=96);
    }
    zerh(390, 150, 905/2, 805/2);

    // Support shafts
//    color("green")
    translate([0, 0, 389])
    linear_extrude(2209)
    difference()
    {
        intersection()
        {
            circle(1050/2, $fn=96);
            for (ii = [60:120:360])
            {
                rotate([0, 0, ii])
                translate([450, 0, 0])
                square([200, 200], center=true);
            }
        }
        circle(805/2, $fn=96);
    }

    translate([0, 0, 2445])
    bearing_support();

    translate([0, 0, 1555])
    rotate([180, 0, 0])
    bearing_support();

    translate([0, 0, 450])
    {
        innerthread();
        vexmount();
    }

}

module encoder_enclosure()
{
        vexmount();
}

