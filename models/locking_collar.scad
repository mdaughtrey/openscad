
module locking_collar(
    anchor=CENTER,
    spin=0,
    orient=UP,
    female=false,
    id=2000,
    od=2100,
    tabout=100,
    tabs=3,
    tabdown=100,
    h=500)
{
    module locking_collar_male_()
    {
        tube(id=id,od=od,h=h);
        intersection()
        {
            tube(id=id,od=od+tabout,h=h);
            position(TOP) down(tabdown)
            {
                zrot_copies(n=tabs,d=od+tabout) 
                    pie_slice(d=od+tabout, h=100, ang=10, anchor=TOP+RIGHT);
            }
        }
    }
    module locking_collar_female_()
    {
        rmtag="r4acv32";
        diff(rmtag)
        tube(id=id,od=od,h=h)
        {
           position(TOP) down(tabdown) tag(rmtag)
           {
                zrot_copies(n=tabs,d=od+tabout) 
                    pie_slice(d=od+tabout, h=115, ang=21, anchor=TOP+RIGHT)
                    position(TOP+RIGHT) pie_slice(d=od+tabout, h=tabdown+2, ang=11, anchor=BOT+RIGHT);
           }
        }
    }
    attachable(anchor,spin,orient,r=od+(female==true?0:tabout),h=h)
    {
        if (female == true)
        {
            locking_collar_female_();
        } else {
            locking_collar_male_();
        }
        children();
    }
}
