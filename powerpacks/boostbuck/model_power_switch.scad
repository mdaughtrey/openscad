module model_power_switch()
{
    recolor("darkslategrey") cyl(r=890/2,h=110,$fn=96) {
    position(TOP) cyl(r=600/2,h=130,$fn=96,anchor=BOT);
    position(BOT) cyl(r=760/2,h=550,$fn=96,anchor=TOP)
    {
        position(TOP) cuboid([135,880,450],anchor=TOP);
//        position(BACK+TOP) cuboid([135,90,440],anchor=TOP+FRONT);
        zrot(90) position(BACK+TOP) cuboid([80,40,450],anchor=TOP+FRONT);
        recolor("silver") position(BOT) xcopies(n=3,l=552) cuboid([32,190,300],anchor=TOP);
    }
    }
}

