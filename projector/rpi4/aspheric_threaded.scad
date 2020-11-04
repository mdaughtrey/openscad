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
    linear_extrude(3000)
    difference() {
        circle(1560/2, $fn=96);
        circle(1530/2, $fn=96);
    }
    straight_thread(
        section_profile = [[0,0],[0, 142], [115, 122], [115, 22]],
        higbee_arc = 20,
        r = 1560/2,
        turns = 9,
        pitch = 300,
        fn=96);
}

module outer()
{
    linear_extrude(2100)
     difference() {
         circle(1860/2, $fn=96);
         circle(1830/2, $fn=96);
     }
    straight_thread(
        section_profile = [[0,0],[-115, 32], [-115, 112], [0, 142]],
        higbee_arc = 20,
        r = 1830/2,
        turns = 6,
        pitch = 300,
        fn=96);
}


module forViewing()
{
    inner();
    color("cyan")
    rotate([0, 0, -180])
    outer();
}

scale(ViewScale)
{
    forViewing();
}
