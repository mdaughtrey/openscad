ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>

$fn=64;

pcb_x = 3900;
pcb_y = 3900;
pcb_z = 65;

pcb_holes = [
    [130, -280, 0], // 0
    [3750, -280, 0], // 1
    [320, -528, 0], // 2
    [3570, -528, 0], // 3
    [1520, -730, 0], // 4
    [1520, -1830, 0], // 5
    [570, -2420, 0], // 6
    [3520, -2420, 0], // 7
    [130, -3600, 0], // 8
    [3750, -3600, 0], // 9
];

rods = [
    [0,1,2,8],
    [1,3,9],
    [2,4],
    [3,4],
    [4,5],
    [5,6,7],
    [6,8],
    [7,9],
];

model_color = 1;

// module modname(anchor=CENTER,spin=0,orient=UP)
// {
//     module modname_()
//     {
//     }
//     attachable(anchor,spin,orient,size=)
//     {
//         modname_();
//         children();
//     }
// }

module spacer1(anchor=CENTER,spin=0,orient=UP)
{
    module rod(p1, p2)
    {
        v = p2 - p1;
        length = norm(v);
        translate(p1) rotate(a=v, v=[0,0,1])
        cuboid([length, 100, pcb_z], anchor=LEFT);
    }
        
    module spacer1_()
    {
        rmtag="rfadc4";
        diff(rmtag)
        {
            for (hole_tx = pcb_holes)
            {
                translate(hole_tx) cyl(d=240, h=pcb_z);
                tag(rmtag) translate(hole_tx) cyl(d=120, h=pcb_z+2);
            }
            for (path = rods)
            {
                for (ii = [0: len(path)-2])
                {
                    p1 = pcb_holes[path[ii]];
                    p2 = pcb_holes[path[ii+1]];
                    rod(p1, p2);
                }
            }
        }

            
    }
    attachable(anchor,spin,orient,size=[pcb_x, pcb_y, pcb_z+2])
    {
        spacer1_();
        children();
    }
}

module spacer(anchor=CENTER,spin=0,orient=UP)
{
    module spacer_()
    {
        rmtag="r41vrq";
        diff(rmtag)
        {
            for (hole_tx = pcb_holes)
            {
                translate(hole_tx) cyl(d=240, h=pcb_z);
                tag(rmtag) translate(hole_tx) cyl(d=120, h=pcb_z+2);
            }
            for (rod = rods)
            {
                origin = rod[0];
                r0_offset = -pcb_holes[origin];
                for (r = [1:len(rod)-1])
                {
                    o0 = pcb_holes[origin][0];
                    r0 = pcb_holes[rod[r]][0];
                    xlength = (r0 - o0);
                    xsign = (r0 - o0) >= 0 ? 1: -1;
                    // ylength = abs(pcb_holes[origin][1] - pcb_holes[rod[r]][1]);
                    o1 = pcb_holes[origin][1];
                    r1 = pcb_holes[rod[r]][1];
                    ylength = (r1 - o1);
                    ysign = (r1 - o1) >= 0 ? 1: -1;
                    length = sqrt(pow(xlength, 2) + pow(ylength, 2));
                    
                    angle = xlength == 0 ? -90 : ylength == 0 ? 0 : atan2(ylength, xlength);
                    translate(pcb_holes[origin])
                    zrot(angle) cuboid([length, 100, pcb_z], anchor=LEFT);
                }
            }
        }

    }
    attachable(anchor,spin,orient,size=[pcb_x, pcb_y, pcb_z])
    {
        spacer_();
        children();
    }
}

module model_pcb(anchor=CENTER,spin=0,orient=UP)
{
    module model_pcb_()
    {
        rmtag="rcr313qqe";
        diff(rmtag)
        {
            cuboid([pcb_x, pcb_y, pcb_z])
            tag(rmtag)
            {
                // Cutouts
                position(RIGHT+BACK+TOP) up(1) right(1) fwd(550) cuboid([233+2,400, pcb_z+2], anchor=TOP+RIGHT+BACK)
                position(FRONT) fwd(775) right(1) cuboid([233+2,500, pcb_z+2], anchor=BACK);

                // Mounting Holes
                for (hole_tx = pcb_holes)
                {
                    position(TOP+LEFT+BACK) translate(hole_tx) up(1) cyl(d=120, h=pcb_z+2, anchor=TOP);
                }

                // PCB Holes
                position(TOP+FRONT) up(1) back(100) left(50) 
                xcopies(100, n=40)
                {
                   cyl(d=40, h=pcb_z+2, anchor=TOP); 
                }

                position(TOP+BACK) up(1) fwd(100) left(50) 
                xcopies(100, n=40)
                {
                   cyl(d=40, h=pcb_z+2, anchor=TOP); 
                }
            }
        }
    }
    attachable(anchor,spin,orient,size=[pcb_x, pcb_y, pcb_z])
    {
        model_pcb_();
        children();
    }
}


module forViewing()
{
//    if (model_color)
//        color("green")
//    model_pcb();
    spacer();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
