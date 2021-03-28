use <../../libraries/OpenSCAD bottle threads/thread_profile.scad>;
//ViewScale = [0.0254, 0.0254, 0.0254];

module outer()
{
    // 1873-1290 = 583
    // section_profile = [[0,0],[-115, 0], [-115, 140], [0, 140]],
    union() {
    linear_extrude(1000)
    difference() {
         circle(1290/2, $fn=96);
         circle(1240/2, $fn=96);
     }
    straight_thread(
        section_profile = [[0,0], [-50, 50], [0, 100]],
        higbee_arc = 20,
        r = 1243/2,
        turns = 8.5,
        pitch = 101,
        fn=96);
    }
}

module inner()
{
    union() {
    linear_extrude(2200)
    difference() {
         circle(1140/2, $fn=96);
         circle(1040/2, $fn=96);
     }
    rotate([0, 0, 180])
    straight_thread(
        section_profile = [[0,0], [50, 50], [0, 100]],
        higbee_arc = 20,
        r = 1138/2,
        turns = 20.5,
        pitch = 101,
        fn=96);
    }

    // lens mount cone
    translate([0, 0, 2270])
    linear_extrude(center=true, height=140, scale=1.416)
    difference() {
         circle(1140/2, $fn=96);
         circle(1040/2, $fn=96);
    }

    translate([0, 0, 2340])
    linear_extrude(150)
    difference() {
         circle(1615/2, $fn=96);
         circle(1515/2, $fn=96);
     }
}

module aspheric_mount()
{
    sqdim = (2+5/16)*1000;
    linear_extrude(407) {
        difference() {
            square([sqdim + 250, sqdim + 250], center=true);
            square([sqdim, sqdim], center=true);
            *for(jj = [0:90:360]) {
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
                    translate([0, -550, 0])
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
            circle(1280/2, $fn=96);
        }
    }
    outer();
}

//module forPrinting()
//{
//    inner();
////    aspheric_mount();
//}
//
//module forViewing()
//{
//    aspheric_mount();
//    *color("cyan")
//    inner();
//}
//
//
//scale(ViewScale)
//{
//    forViewing();
//    //forPrinting();
//}
