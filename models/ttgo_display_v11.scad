include <../BOSL2-master/std.scad>

model_ttgo_display_v11_x = 2040;
model_ttgo_display_v11_y = 1000;
model_ttgo_display_v11_z = 250; 

module model_ttgo_display_v11(anchor=CENTER,spin=0,orient=UP)
{
    module model_ttgo_display_v11_()
    {
        rmtag="14vr1q";
        recolor("black")
        diff(rmtag)
        cuboid([2040,1000,50])
        {
            // Display
            recolor("grey")
            position(TOP+LEFT) right(475) cuboid([1220,690,65],anchor=LEFT+BOT);
            // USB Connector
            recolor("silver") 
            position(TOP+LEFT) left(40) cuboid([220,293,105],anchor=BOT+LEFT);
            // Buttons
            recolor("white")
            position(TOP+LEFT+BACK) fwd(95) right(35) cuboid([167,130,90],anchor=BOT+LEFT+BACK);
            recolor("white")
            position(TOP+LEFT+FRONT) back(95) right(35) cuboid([167,130,90],anchor=BOT+LEFT+FRONT);
            recolor("white")
            position(TOP+LEFT+FRONT) fwd(30) right(365) cuboid([167,130,90],anchor=BOT+LEFT+FRONT);

            // Battery Connector
            recolor("white")
            position(BOT+LEFT+FRONT) right(250) cuboid([180,300,135],anchor=TOP+LEFT+FRONT);
            
//            // WiFi Module
//            recolor("grey")
//            position(TOP+RIGHT) left(20) cuboid([1010,701,25], anchor=RIGHT+BOT)
//            recolor("silver")
//            position(TOP+LEFT) right(50) cuboid([698,630,90], anchor=BOT+LEFT);
//            // Connectors strips
//            recolor("yellow")
//            position(BOT+LEFT+BACK) right(135) cuboid([1900,100,100], anchor=LEFT+BACK+TOP)
//            recolor("silver") position(BOT) xcopies(n=19,spacing=100) cuboid([25,25,200], anchor=TOP);
//            recolor("yellow")
//            position(BOT+LEFT+FRONT) right(135) cuboid([1900,100,100], anchor=LEFT+FRONT+TOP)
//            recolor("silver") position(BOT) xcopies(n=19,spacing=100) cuboid([25,25,200], anchor=TOP);
            // Mounting holes
//            tag(rmtag)
//            position(TOP) grid_copies(n=2,size=[2000,930]) cyl(d=100,h=60,anchor=TOP);
        }
    }
    attachable(anchor,spin,orient,size=[model_ttgo_display_v11_x+15,
        model_ttgo_display_v11_y,
        model_ttgo_display_v11_z])
    {
        up(300+30)
        down(model_ttgo_display_v11_z/2)
        model_ttgo_display_v11_();
        children();
    }
}
