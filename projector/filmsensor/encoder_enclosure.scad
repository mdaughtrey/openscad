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
    linear_extrude(200)
    difference()
    {
        hull()
        {
            circle(370/2, $fn=96);
            translate([-370/2, 0, 0])
            square([370, 370], center = true);
        }
        circle(170/2, $fn=96);
    }
}

module outerthread()
{
    color("lightblue")
    translate([0, 0, 0])
    {
        straight_thread(
            section_profile = [[0,0], [-100,0], [-145, 45], [-145, 55],  [-100, 100], [0,100]],
            higbee_arc = 20,
            r = 1470/2,
            turns = 5.5,
            pitch = 300,
            //pitch = 101,
            fn=96);

        translate([0, 0, 100])
        straight_thread(
            section_profile = [[0,0], [-100,0], [-145, 45], [-145, 55],  [-100, 100], [0,100]],
            higbee_arc = 20,
            r = 1470/2,
            turns = 5.5,
            pitch = 300,
            //pitch = 101,
            fn=96);
    }
    color("lightgreen")
//    translate([0, 0, -80])
    linear_extrude(1900)
    {
        difference()
        {
            circle(1471/2, $fn=96);
            circle(1369/2, $fn=96);
            //circle(1469/2, $fn=96);
        }
        translate([0, 150, 0])
        intersection()
        {
         difference()
         {
             square([1470, 1870], center=true);
             square([1370, 1765], center=true);
         }
         translate([0, 1569/2, 0])
         square([2000, 2000], center=true);
        }
    }
//     linear_extrude(1100)
//     {
//         difference() 
//         {
//              circle(1305/2, $fn=96);
//              circle(1265/2, $fn=96);
//         }
//         *translate([0, 250, 0])
//         difference()
//         {
//             square([1365, 1865], center=true);
//             square([1265, 1765], center=true);
//         }
//     }
//    translate([0, 0, 100])
//    straight_thread(
//         section_profile = [[0, 0], [-45, 45], [0, 90], [0, 210], [-45, 255], [0, 300]],
//         higbee_arc = 20,
//         r = 1268/2,
//         turns = 2,
//         pitch = 300,
//         fn=96);

   // mounts
   translate([1000, 1365/2+400, 370/2])
   rotate([90, 0, 0])
   vexmount();

   translate([-1000, 1365/2+200, 370/2])
   rotate([90, 0, 180])
   vexmount();

   translate([1000, 1365/2+400, 370/2+1500])
   rotate([90, 0, 0])
   vexmount();

   translate([-1000, 1365/2+200, 370/2+1500])
   rotate([90, 0, 180])
   vexmount();
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
            turns = 12,
            pitch = 300,
            //pitch = 101,
            fn=96);

       linear_extrude(3209)
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
    linear_extrude(3410)
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

    translate([0, 0, 3645])
    bearing_support();

    translate([0, 0, 1700])
 //   rotate([180, 0, 0])
    bearing_support();

    translate([0, 0, 450])
    {
        innerthread();
//        outerthread();
//        vexmount();
    }

}

module encoder_enclosure()
{
//     vexmount();
    outerthread();
}

