ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
include <../../models/nodes_and_edges.scad>

// $fn=64;
// 
// pcb_x = 3900;
// pcb_y = 3900;
// pcb_z = 65;
// 
//1021 apart 85 dia
//1021 + 85 = 1106
board_holes = [
// Camera board holes
    [0, 0, 0], // 0
    [1106, 0, 0], // 1
    [0, 1106, 0], // 2
    [1106, 1106, 0], // 3
];

board_edges = [
    [0,1],
    [2,0,3],
    [3,1]
];

// Camera mount holes
mount_holes = [
    [0, 0, 0], // 0
    [1130, 0, 0], // 1
    [0, 630, 0], // 2
    [1130, 630, 0], // 3
];

mount_edges = [
    [0,1],
    [2,0,3],
    [3,1]
];

nodes = [];
edges = [];
// 
// nodes = [
//     [1000, -1000, 0],
// ];
// 
// edges = [
//     [0,1,2,8],
//     [1,3,9],
//     [2,4,10],
//     [3,4],
//     [4,5,10],
//     [5,6,7],
//     [6,8],
//     [7,9],
// ];

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
// 
// 
// module case()
// {
// }

//jmodule forViewing()
//j{
//j    case();
//j}
//j
//jmodule forPrinting()
//j{
//j}

scale(ViewScale)
{
//module spacer( anchor=CENTER, spin=0, orient=UP, space=140, upper_space=0, lower_space=0, hole_od=240, hole_id=120, holes, nodes, edges)
    spacer(holes=mount_holes, nodes=nodes, edges=mount_edges, hole_id=70, hole_od=240, space=100, upper_space=100, lower_space=100)
    position(TOP+FRONT) fwd(180) up(100)
    spacer(holes=board_holes, nodes=nodes, edges=board_edges, hole_id=130, space=100, upper_space=100, lower_space=100, anchor=BOT);
}
