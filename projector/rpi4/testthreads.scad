use <../../libraries/OpenSCAD bottle threads/thread_profile.scad>;
ViewScale = [0.0254, 0.0254, 0.0254];

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

scale(ViewScale)
{
    inner();
    //outer();
}
