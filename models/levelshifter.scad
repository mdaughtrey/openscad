module model_LevelShifter()
{
    color("CornflowerBlue")
    linear_extrude(65)
    difference()
    {
       square([600, 480], center=true);
       for (ii = [0:100:500])
       {
           for (jj = [-200,200])
           {
               translate([ii-600/2+50, jj, 0])
               circle(50/2, $fn=96);
           }
       }
    }
    color("gray")
    translate([0, 0, 64])
    linear_extrude(40)
    square([520, 75], center=true);
}
