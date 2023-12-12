ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>


module case()
{
}

module forViewing()
{
    case();
}

module forPrinting()
{
    $fn=96;
   diff()
   {
        hull() xcopies(500,2) cyl(d=380,h=1000);
        tag("remove") xcopies(500,2) cyl(d=180,h=1000);
    }

    right(1000)
    tube(od=380,id=180,h=1000);

}

scale(ViewScale)
{
    forPrinting();
}
