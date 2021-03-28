use <../../libraries/OpenSCAD bottle threads/thread_profile.scad>;
ViewScale = [0.0254, 0.0254, 0.0254];

module outer()
{
    // 1873-1290 = 583
    // section_profile = [[0,0],[-115, 0], [-115, 140], [0, 140]],
    union() {
    linear_extrude(1000)
    difference() {
         circle(1310/2, $fn=96);
         circle(1260/2, $fn=96);
     }
    straight_thread(
        section_profile = [[0,0], [-50, 50], [0, 100]],
        higbee_arc = 20,
        r = 1263/2,
        turns = 8.5,
        pitch = 101,
        fn=96);
    }
}

module inner()
{
    union() {
    linear_extrude(1200)
    difference() {
         circle(1120/2, $fn=96);
         circle(1020/2, $fn=96);
     }
    rotate([0, 0, 180])
    straight_thread(
        section_profile = [[0,0], [50, 50], [0, 100]],
        higbee_arc = 20,
        r = 1118/2,
        turns = 10.5,
        pitch = 101,
        fn=96);
    }

    // lens mount cone
    translate([0, 0, 1270])
    linear_extrude(center=true, height=140, scale=1.416)
    difference() {
         circle(1140/2, $fn=96);
         circle(1040/2, $fn=96);
    }

    translate([0, 0, 1340])
    linear_extrude(150)
    difference() {
         circle(1615/2, $fn=96);
         circle(1515/2, $fn=96);
     }
}

module aspheric_mount2()
{
    sqdim = (2+5/16)*1000;
    linear_extrude(407) {
        difference() {
            square([sqdim + 250, sqdim + 250], center=true);
            square([sqdim, sqdim], center=true);
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
        *difference() {
            union() {
                square([sqdim, 400], center=true);
                rotate([0, 0, 90])
                square([sqdim, 400], center=true);
            }
            circle(1280/2, $fn=96);
        }
    }
    // spars
    translate([0, 0, 1200])
    linear_extrude(200)
    difference() {
        union() {
            square([sqdim + 250, 400], center=true);
            rotate([0, 0, 90])
            square([sqdim + 250, 400], center=true);
        }
        circle(1280/2, $fn=96);
    }

    // risers
    for(ii = [0:90:360]) {
        rotate([0, 0, ii])
        translate([0, sqdim/2+125/2, 407])
        linear_extrude(1000)
        square([400, 250/2], center=true);
    }
    
    translate([0, 0, 1000])
    outer();
}

module forPrinting()
{
    inner();
//    aspheric_mount();
}

module forViewing()
{
    *aspheric_mount2();
    color("cyan")
    inner();
}


scale(ViewScale)
{
    forViewing();
    //forPrinting();
}
