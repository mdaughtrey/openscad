use <../libraries/OpenSCAD bottle threads/thread_profile.scad>
//include <../../libraries/myutils.scad>
//include <model_encoder.scad>


module innerScrew()
{
    th = 100-10;
    tw = 100-10;
    union() {
    *linear_extrude(1000)
    difference() {
         circle(1140/2, $fn=96);
         circle(1090/2, $fn=96);
     }
    rotate([0, 0, 180])
    straight_thread(
//        section_profile = [[0,0], [50, 50], [0, 100]],
        //section_profile = [[0,0], [45, 45], [45, 55],  [0, 100]],
        section_profile = [[0,0], [th, 0], [th, tw],  [0, tw]],
        higbee_arc = 20,
        r = 500/2,
        turns = 4.25,
        pitch = tw*2,
        fn=96);
    }
}
