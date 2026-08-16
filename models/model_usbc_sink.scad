
module model_usbc_sink(anchor=CENTER,spin=0,orient=UP)
{
    module model_usbc_sink_()
    {
        recolor("darkblue")
        cuboid([1100,420,65])
        {
            // USBC Connector
            position(TOP+RIGHT) recolor("silver") cuboid([320,350,120], edges="X", rounding=50, anchor=BOT+RIGHT);
            // DIP Switches
            position(TOP+RIGHT) left(350) recolor("darkred") cuboid([350,390,200], anchor=BOT+RIGHT)
                position(TOP) xcopies(n=3, spacing=100) recolor("white") cuboid([50,140,50], anchor=BOT);
            // Terminal
            position(TOP+LEFT) recolor("darkgreen") cuboid([300,400,400], anchor=BOT+LEFT);
        }
    }
    attachable(anchor,spin,orient,size=[1100,420,465])
    {
        up(65/2) down(465/2)
        model_usbc_sink_();
        children();
    }
}

module usbc_sink_cover(anchor=CENTER,spin=0,orient=UP)
{
    module usbc_sink_cover_()
    {
        rmtag="r4r13qddd";
        diff(rmtag)
        cuboid([1000,620,145])
        {
            // Terminal Cutout
            tag(rmtag) position(BOT+LEFT) right(100) down(1)
            cuboid([320,410,147],anchor=BOT+LEFT);

            // DIP Switch Cutout
            tag(rmtag) position(BOT+LEFT) right(490) down(1)
            cuboid([350,420,147],anchor=BOT+LEFT);

            *position(BOT+LEFT) right(500)
            cuboid([400,620,45],anchor=TOP+LEFT);
            // Screw Holes
            position(FRONT+BOT) back(50) right(150) cyl(d=300,h=145,anchor=BOT+BACK)
            tag(rmtag)
            position(TOP) up(1) cyl(d=220,h=62,anchor=TOP)
            position(BOT) up(1) cyl(d=100,h=87,anchor=TOP);

            position(BACK+BOT) fwd(50) right(150) cyl(d=300,h=145,anchor=BOT+FRONT)
            tag(rmtag)
            position(TOP) up(1) cyl(d=220,h=62,anchor=TOP)
            position(BOT) up(1) cyl(d=100,h=87,anchor=TOP);
        }
    
    }
    attachable(anchor,spin,orient,size=[1100,420,65])
    {
        usbc_sink_cover_();
        children();
    }
}
