use <../../libraries/OpenSCAD bottle threads/thread_profile.scad>;
ViewScale = [0.0254, 0.0254, 0.0254];

module outer()
{
    // section_profile = [[0,0],[-115, 0], [-115, 140], [0, 140]],
    union() {
//    color("cornflowerblue")
    linear_extrude(2000)
    difference() {
         circle(1873/2, $fn=96);
         circle(1823/2, $fn=96);
     }
//    color("cyan")
    straight_thread(
        section_profile = [[0,0], [-100, 100], [0, 200]],
        higbee_arc = 20,
        r = 1834/2,
        turns = 8.5,
        pitch = 201,
        fn=96);
    }
}

module aspheric_mount()
{
    sqdim = (2+5/16)*1000;
    linear_extrude(407) {
        difference() {
            square([sqdim + 1000, sqdim + 1000], center=true);
            square([sqdim, sqdim], center=true);
            for(jj = [0:90:360]) {
                rotate([0, 0, jj])
                for(ii = [-(sqdim/2+250):473:(sqdim/2)+500]) {
                    translate([sqdim/2+250, ii, 0])
                    circle(140, $fn=96);
                }
            }
        }
        for(ii = [-750, 750]) {
            translate([ii, sqdim/2+(13/16*1000), 0]) 
            difference() {
                hull() {
                    translate([0, -200, 0])
                    square([340, 340], center=true);
                    circle(170, $fn=96);
                }
                circle(80, $fn=96);
            }
        }
        // outer mount
        difference() {
            union() {
                square([sqdim, 400], center=true);
                rotate([0, 0, 90])
                square([sqdim, 400], center=true);
            }
            circle(1870/2, $fn=96);
        }
    }
    outer();
}

module forViewing()
{
    aspheric_mount();
}

module forViewing()
{
    aspheric_mount();
}


scale(ViewScale)
{
    forViewing();
    //forPrinting();
}
