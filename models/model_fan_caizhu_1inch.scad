include <../libs/MCAD/2Dshapes.scad>

module model_fan_caizhu_1inch(anchor=CENTER,spin=0,orient=UP)
{
    $fn=96;
    module model_fan_caizhi_1inch_() {
        diff()
        cuboid([1000,1000,410], rounding=100,edges="Z") {
            tag("remove") {
                grid_copies([800,800]) 
                cyl(d=125,h=415);
                cyl(d=940,h=415);
            }
            tag("keep") {
                attach(BOT,norot=1) cyl(d=630,h=415,anchor=BOT);
                rot_copies(n=3,delta=[390,0,0])
                cuboid([170,80,410]);
            }
        }
    }

    attachable(anchor,spin,orient,size=[1000,1000,410])
    {
        model_fan_caizhi_1inch_();
        children();
    }
}

