include <../BOSL2-master/std.scad>

model_esp_wroom_32_x = 2155;
model_esp_wroom_32_y = 1108;
model_esp_wroom_32_z = 475; 

module model_esp_wroom_32(anchor=CENTER,spin=0,orient=UP)
{
    module model_esp_wroom_32_()
    {
        rmtag="14vv1q";
        recolor("black")
        diff(rmtag)
        cuboid([2155,1108,60],rounding=50,edges="Z")
        {
            // WiFi Module
            recolor("grey")
            position(TOP+RIGHT) left(20) cuboid([1010,701,25], anchor=RIGHT+BOT)
            recolor("silver")
            position(TOP+LEFT) right(50) cuboid([698,630,90], anchor=BOT+LEFT);
            // USB Connector
           recolor("silver") 
            position(TOP+LEFT) left(15) cuboid([220,293,105],anchor=BOT+LEFT);
            // Buttons
            recolor("silver")
            position(TOP+LEFT+BACK) fwd(190) right(35) cuboid([157,100,65],anchor=BOT+LEFT+BACK);
            recolor("silver")
            position(TOP+LEFT+FRONT) back(190) right(35) cuboid([157,100,65],anchor=BOT+LEFT+FRONT);
            // Connectors strips
            recolor("yellow")
            position(BOT+LEFT+BACK) right(135) cuboid([1900,100,100], anchor=LEFT+BACK+TOP)
            recolor("silver") position(BOT) xcopies(n=19,spacing=100) cuboid([25,25,200], anchor=TOP);
            recolor("yellow")
            position(BOT+LEFT+FRONT) right(135) cuboid([1900,100,100], anchor=LEFT+FRONT+TOP)
            recolor("silver") position(BOT) xcopies(n=19,spacing=100) cuboid([25,25,200], anchor=TOP);
            // Mounting holes
            tag(rmtag)
            position(TOP) grid_copies(n=2,size=[2000,930]) cyl(d=100,h=60,anchor=TOP);
        }
    }
    attachable(anchor,spin,orient,size=[model_esp_wroom_32_x+15,
        model_esp_wroom_32_y,
        model_esp_wroom_32_z])
    {
        up(300+30)
        down(model_esp_wroom_32_z/2)
        model_esp_wroom_32_();
        children();
    }
}
