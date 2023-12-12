ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

module pcb_replacement()
{
    // 4 x 5 5/8
    pcbw = 4000;
    pcbh = 5360;

    // Frame 
        for(jj = [400,3600]) {
            for(ii = [1520:1000:4800]) {
                translate([jj+170/2, ii+170/2, 0])
                circle(170/2, $fn=96);
            }
        }
        #translate([1250, 4940, 0])
        circle(170/2, $fn=96);
        #translate([2750, 4940, 0])
        circle(170/2, $fn=96);
        // Bottom two holes
        #translate([pcbw/2-891, 960, 0])
        circle(170/2, $fn=96);
        #translate([pcbw/2+891, 960, 0])
        circle(170/2, $fn=96);
}

module footmount()
{
    $fn=96;
    diff()
    cuboid([3900,4400,200],rounding=175,edges="Z") {
        tag("remove") down(1) attach(BOT,norot=1) {
            back(1990) left(750) cyl(d=175,h=204,anchor=BOT);
            back(1990) right(750) cyl(d=175,h=204,anchor=BOT);

            fwd(1990) left(891) cyl(d=175,h=204,anchor=BOT);
            fwd(1990) right(891) cyl(d=175,h=204,anchor=BOT);

            right(3500/2) ycopies(500,8) cyl(d=175,h=204,anchor=BOT);
            left(3500/2) ycopies(500,8) cyl(d=175,h=204,anchor=BOT);
            cuboid([3000,3600,204],rounding=175,edges="Z",anchor=BOT);
        }
    }
}

module forViewing()
{
//    recolor("Purple") left(2000) fwd(6000/2-50)
//    pcb_replacement();
    recolor("cornflowerblue")
   // up(250) 
    footmount();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
