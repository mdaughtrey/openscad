ViewScale = [0.0254, 0.0254, 0.0254];

PiHoles = [138, 2421, 138, 2067];
CamHoles = [157, 1338];

// function partial(list,start,end) = [for (i = [start:end]) list[i]];


// module rpi4holes()
// {
//     for(ii = [PiHoles[0],PiHoles[1]]) {
//         for(jj = [PiHoles[2],PiHoles[3]]) {
//             translate([ii, jj, 0])
//             difference() {
//                 circle(147, $fn=96);
//                 circle(35, $fn=96);
//             }
//         }
//     }
// }
// 
// module strut(pointa, pointb, router, rinner)
// {
//     linear_extrude(150)
//     difference() {
//         hull() {
//             translate([pointa[0], pointa[1], 0])
//             circle(router, $fn=96);
//             translate([pointb[0], pointb[1], 0])
//             circle(router, $fn=96);
//         }
//             translate([pointa[0], pointa[1], 0])
//             circle(rinner, $fn=96);
//             translate([pointb[0], pointb[1], 0])
//             circle(rinner, $fn=96);
//     }
// }

module hqcameramount()
{
    CamHole = 1181;
    tx = [[-1, -1], [-1, 1], [1, -1], [1, 1]];

    // Frame
    linear_extrude(150)
    difference() {
        circle(CamHole-100, $fn=96);
        circle(CamHole-400, $fn=96);
    }


    *difference() {
        hull() {
            for(ii = tx) {
                //rotate([0, 0, -45])
                translate([CamHole/2*ii[0], CamHole/2*ii[1], 0])
                circle(210, $fn=96);
            }
        }
        hull() {
            for(ii = tx) {
                //rotate([0, 0, -45])
                scale([0.8, 0.8, 0.8])
                translate([CamHole/2*ii[0], CamHole/2*ii[1], 0])
                circle(147, $fn=96);
            }
        }
    }
    // Corner circles
    linear_extrude(150)
    for(ii = [0:22.5:360]) {
        rotate([0, 0, ii])
        translate([CamHole/2, CamHole/2, 0])
        circle(150, $fn=96);
    }

    *linear_extrude(150)
    for(ii = tx) {
        //rotate([0, 0, -45])
        translate([CamHole/2*ii[0], CamHole/2*ii[1], 0])
        circle(150, $fn=96);
    }
}

module rpi4mount()
{
    PiHoles = [2283, 1929];
    tx = [[-1, -1], [-1, 1], [1, -1], [1, 1]];

    // Frame
    linear_extrude(150)
    difference() {
        hull() {
            for(ii = tx) {
                rotate([0, 0, -45])
                translate([PiHoles[0]/2*ii[0], PiHoles[1]/2*ii[1], 0])
                circle(147, $fn=96);
            }
        }
        hull() {
            for(ii = tx) {
                rotate([0, 0, -45])
                scale([0.8, 0.8, 0.8])
                translate([PiHoles[0]/2*ii[0], PiHoles[1]/2*ii[1], 0])
                circle(147, $fn=96);
            }
        }
    }

    // Screwed supports
    linear_extrude(400)
    for(ii = tx) {
        rotate([0, 0, -45])
        translate([PiHoles[0]/2*ii[0], PiHoles[1]/2*ii[1], 0])
        difference() {
            circle(147, $fn=96);
            circle(40, $fn=96);
        }
    }
}

module camholes()
{
    CamHole = 1181;
    tx = [[-1, -1], [-1, 1], [1, -1], [1, 1]];

    linear_extrude(250)
    for(ii = [0:22.5:360]) {
        rotate([0, 0, ii])
        translate([CamHole/2, CamHole/2, 0])
        circle(35, $fn=96);
    }

    // Frame
    *linear_extrude(250)
    for(ii = tx) {
        //rotate([0, 0, -45])
        translate([CamHole/2*ii[0], CamHole/2*ii[1], 0])
        circle(40, $fn=96);
    }
    
}

// module hqcameraholes()
// {
//     difference() {
//         circle(100, $fn=96);
//         circle(35, $fn=96);
//     }
// }

module spacers()
{
    linear_extrude(100)
    for(ii = [0,500]) {
        for(jj = [0,500]) {
            translate([ii, jj])
            difference()
            {
                circle(100, $fn=96);
                circle(50, $fn=96);
            }
        }
    }
}

module forviewing()
{
    //xtrans = 2421/2-1338/2;
    //ytrans = 2067/2-1338/2;
    // rotate([0, 0, 45])
    difference() {
        union() {
            rpi4mount();
            hqcameramount();
        }
        translate([0, 0, -5])
        camholes();
    }

    *strut([PiHoles[0], PiHoles[0]], [CamHoles[0] + xtrans, CamHoles[0] + ytrans], 100, 50);
    *strut([PiHoles[2], PiHoles[3]], [CamHoles[0] + xtrans, CamHoles[1] + ytrans], 100, 50);
    *strut([PiHoles[1], PiHoles[3]], [CamHoles[1] + xtrans, CamHoles[1] + ytrans], 100, 50);
    *strut([PiHoles[1], PiHoles[0]], [CamHoles[1] + xtrans, CamHoles[0] + ytrans], 100, 50);

    *translate([700, 700, 0])
    spacers();

}

scale(ViewScale)
{
    forviewing();
}
