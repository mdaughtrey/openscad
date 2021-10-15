use <../../libraries/OpenSCAD bottle threads/thread_profile.scad>
//use <../../libraries/revolve2.scad>

ViewScale = [0.0254, 0.0254, 0.0254];


module inner()
{
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

module outer()
{
    color("lightblue")
    translate([0, 0, -50])
    {
        straight_thread(
            section_profile = [[0,0], [-100,0], [-145, 45], [-145, 55],  [-100, 100], [0,100]],
            higbee_arc = 20,
            r = 1460/2,
            turns = 2,
            pitch = 300,
            //pitch = 101,
            fn=96);

        translate([0, 0, 100])
        straight_thread(
            section_profile = [[0,0], [-100,0], [-145, 45], [-145, 55],  [-100, 100], [0,100]],
            higbee_arc = 20,
            r = 1460/2,
            turns = 2,
            pitch = 300,
            //pitch = 101,
            fn=96);
    }
    color("lightgreen")
    translate([0, 0, -100])
    linear_extrude(900)
    difference()
    {
        circle(1510/2-1, $fn=96);
        circle(1459/2, $fn=96);
    }
}

scale(ViewScale)
{
    inner();
    outer();
}
