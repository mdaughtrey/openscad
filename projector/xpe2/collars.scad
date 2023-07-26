module tabbed_accept_collar(anchor=CENTER,h=300)
{
    $fn=96;
    diff()
    tube(od=1600,id=1490,h=h,anchor=anchor) {
    tag("remove") zrot_copies(n=3) up(1) left(120)  position(RIGHT+TOP) cube([200,200,152],anchor=LEFT+TOP);
    tag("remove") zrot_copies(n=3) back(100) left(120) down(1) position(RIGHT+BOT) cube([200,400,151],anchor=LEFT+BOT);
    }
}

//module tabbed_collar(id=1360,h=300,anchor=CENTER,spin,orient)
module tabbed_collar(anchor=CENTER,spin=0,orient=UP,id=1360,h=300)
{
    attachable(anchor,spin,orient) {
        $fn=96;
        //tube(od=1460,id=id,h=h,anchor=anchor)
        tube(od=1460,id=id,h=h,anchor=anchor,spin=spin,orient=orient)
        //zrot_copies(n=3) left(10) position(RIGHT+BOTTOM) cube([100,180,120],anchor=anchor,spin=spin,orient=orient);
        zrot_copies(n=3) left(10) position(RIGHT+BOTTOM) cube([100,180,120],anchor=LEFT+BOTTOM);
        children();
    }
}

