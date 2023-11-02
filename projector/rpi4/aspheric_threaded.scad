use <../../libraries/OpenSCAD bottle threads/thread_profile.scad>;
ViewScale = [0.0254, 0.0254, 0.0254];

$fn = 120;
nut_turns  = 3.5;
nut_height = 12.5;

function inner_thread_major()   = 2780; 
function inner_thread_pitch()   = 270;
function inner_thread_height()  = 115;
function inner_thread_profile() = [
    [0,0],
    [-inner_thread_height(),32],
    [-inner_thread_height(),112],
    [0,142]
];

module inner()
{
    linear_extrude(4000)
    difference() {
        circle(1609/2, $fn=96);
        circle(1534/2, $fn=96);
    }
    straight_thread(
        section_profile = [[0,0],[100, 100], [0, 200]],
        higbee_arc = 20,
        r = 1608/2,
        turns = 16,
        pitch = 201,
        fn=96);
}

module outer()
{
    // section_profile = [[0,0],[-115, 0], [-115, 140], [0, 140]],
    union() {
    color("cornflowerblue")
    linear_extrude(1000)
    difference() {
         circle(1873/2, $fn=96);
         circle(1823/2, $fn=96);
     }
    color("cyan")
    straight_thread(
        section_profile = [[0,0], [-100, 100], [0, 200]],
        higbee_arc = 20,
        r = 1834/2,
        turns = 4,
        pitch = 201,
        fn=$fn);
    }
}


module forViewing()
{
    inner();
    //%rotate([0, 0, -180])
    //outer();
}

module forPrinting()
{
    //inner();
    //translate([2000, 0, 0])
    outer();
}

scale(ViewScale)
{
    forViewing();
    //forPrinting();
}
