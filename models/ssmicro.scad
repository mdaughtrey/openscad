module ssmicro(anchor=CENTER,spin=0,orient=UP)
{
    module ssmicro_()
    {
        rmtag="rt53r";
        diff(rmtag)
        recolor("blue")
        cuboid([800, 750, 80])
        {
            position(FRONT+BOT) cuboid([470,430,80], anchor=BACK+BOT);
            recolor("black") position(TOP) cuboid([275,275,25], anchor=BOT);
            recolor("cornflowerblue") position(BOT) cuboid([550,550,80], anchor=TOP);
            tag(rmtag)
            {
                position(BOT+LEFT) down(1) right(60) ycopies(n=6, spacing=100) cyl(d=50,h=82,anchor=BOT);
                position(BOT+RIGHT) down(1) left(60) ycopies(n=6, spacing=100) cyl(d=50,h=82,anchor=BOT);
                position(BOT+BACK) down(1) fwd(60) xcopies(n=6, spacing=100) cyl(d=50,h=82,anchor=BOT);
            }
        }
    }
    attachable(anchor,spin,orient,size=[800,1180,180])
    {
        down(40+25)
        up(180/2)
        ssmicro_();
        children();
    }
}
