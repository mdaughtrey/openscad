ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

$fn=64;

pcb_x = 3900;
pcb_y = 3900;
pcb_z = 65;

tubes = [
    [263, -130, 0], // 0
    [1600, -500, 0], // 1
    [200, -400, 0], // 2
    [1640, -850, 0], // 3
];

nodes = [
//    [1000, -1000, 0],
];

edges = [
    [0,1,2],
    [1,3]
];

model_color = 1;

function angle_length(
   origin, target, nodes) =
let(
    xlength = (nodes[target][0] - origin[0]),
    ylength = (nodes[target][1] - origin[1]),
    length = sqrt(pow(xlength, 2) + pow(ylength, 2)),
    angle = xlength == 0 ? -90 : ylength == 0 ? 0 : atan2(ylength, xlength),
    result = struct_set([], ["angle", angle,"length", length])
)
result;



module spacer(anchor=CENTER,spin=0,orient=UP, space=140, upper_space=0, lower_space=0)
{
    module spacer_()
    {
        rmtag="r41vrq";
        diff(rmtag)
        {
            for (hole_tx = tubes)
            {
                up(upper_space/2)
                down(lower_space/2)
                {
                    translate(hole_tx) cyl(d=240, h=space+upper_space+lower_space);
                    tag(rmtag) translate(hole_tx) cyl(d=120, h=space+upper_space+lower_space+2);
                }
            }
            for (node_tx = nodes)
            {
                translate(node_tx) cyl(d=100, h=space);
            }
            for (rod = edges)
            {
                ltubes = len(tubes);
                rod_origin = rod[0] > (ltubes-1) ? nodes[rod[0]-ltubes] : tubes[rod[0]];
                for (r = [1:len(rod)-1])
                {
                    al = angle_length(
                        rod_origin,
                        rod[r] > (ltubes-1) ? rod[r]-ltubes : rod[r],
                        rod[r] > (ltubes-1) ? nodes : tubes);

                    echo(al);
                    echo("angle ",struct_val(al,"angle"));
                     
                    translate(rod_origin)
                    zrot(struct_val(al,"angle")) cuboid([struct_val(al,"length"), 100, space], anchor=LEFT);
                }
            }
        }

    }
    attachable(anchor,spin,orient,size=[pcb_x, pcb_y, space])
    {
        spacer_();
        children();
    }
}

module forViewing()
{
    spacer(upper_space=100,lower_space=0);
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
