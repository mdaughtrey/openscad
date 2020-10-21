ViewScale = [0.0254, 0.0254, 0.0254];

PiHoles = [138, 2421, 138, 2067];
CamHoles = [157, 1338];

function partial(list,start,end) = [for (i = [start:end]) list[i]];


module rpi4holes()
{
    for(ii = [PiHoles[0],PiHoles[1]]) {
        for(jj = [PiHoles[2],PiHoles[3]]) {
            translate([ii, jj, 0])
            difference() {
                circle(147, $fn=96);
                circle(25, $fn=96);
            }
        }
    }
}

module strut(pointa, pointb, router, rinner)
{
    linear_extrude(150)
    difference() {
        hull() {
            translate([pointa[0], pointa[1], 0])
            circle(router, $fn=96);
            translate([pointb[0], pointb[1], 0])
            circle(router, $fn=96);
        }
            translate([pointa[0], pointa[1], 0])
            circle(rinner, $fn=96);
            translate([pointb[0], pointb[1], 0])
            circle(rinner, $fn=96);
    }
}

module rpi4mount()
{
    linear_extrude(500)
    rpi4holes();
    strut([PiHoles[0], PiHoles[0]], [PiHoles[1], PiHoles[0]], 100, 50);
    strut([PiHoles[1], PiHoles[0]], [PiHoles[1], PiHoles[3]], 100, 50);
    strut([PiHoles[1], PiHoles[3]], [PiHoles[2], PiHoles[3]], 100, 50);
    strut([PiHoles[2], PiHoles[3]], [PiHoles[0], PiHoles[0]], 100, 50);
}

module hqcameraholes()
{
    for(ii = partial(CamHoles, 0, 1)){
        for(jj = partial(CamHoles, 0, 1)) {
            translate([ii, jj, 0])
            difference() {
                circle(100, $fn=96);
                circle(25, $fn=96);
            }
        }
    }
}

module hqcameramount()
{
    linear_extrude(200)
    hqcameraholes();
    strut([CamHoles[0], CamHoles[0]], [CamHoles[0], CamHoles[1]], 100, 50);
    strut([CamHoles[0], CamHoles[0]], [CamHoles[1], CamHoles[0]], 100, 50);
    strut([CamHoles[1], CamHoles[0]], [CamHoles[1], CamHoles[1]], 100, 50);
    strut([CamHoles[1], CamHoles[1]], [CamHoles[0], CamHoles[1]], 100, 50);
}

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
    xtrans = 2421/2-1338/2;
    ytrans = 2067/2-1338/2;
    rpi4mount();
    translate([xtrans, ytrans, 0])
    hqcameramount();

    strut([PiHoles[0], PiHoles[0]], [CamHoles[0] + xtrans, CamHoles[0] + ytrans], 100, 50);
    strut([PiHoles[2], PiHoles[3]], [CamHoles[0] + xtrans, CamHoles[1] + ytrans], 100, 50);
    strut([PiHoles[1], PiHoles[3]], [CamHoles[1] + xtrans, CamHoles[1] + ytrans], 100, 50);
    strut([PiHoles[1], PiHoles[0]], [CamHoles[1] + xtrans, CamHoles[0] + ytrans], 100, 50);

    *translate([700, 700, 0])
    spacers();

}

scale(ViewScale)
{
    forviewing();
}
