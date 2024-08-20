ViewScale = [0.0254, 0.0254, 0.0254];
include <../../../BOSL2-master/std.scad>
include <../../../models/model_ir_reflective_sensor.scad>

model=1;

offset_s8 = 220-110;
offset_8mm = 197-110;
caseY = 800;
// offset_s8 = 0;
// offset_8mm = 0;

// module modname(anchor=CENTER,spin=0,orient=UP)
// {
//     module modname_()
//     {
//     }
//     attachable(anchor,spin,orient,size=)
//     {
//         modname_();
//         children();
//     }
// }


//module model_ir_reflective_sensor(anchor=CENTER,spin=0,orient=UP,cutoutpad=0)
module case()
{
    diff()
    cuboid([110,caseY,150]) // left bottom
    {
        // 8mm offset
        if (offset_8mm)
            attach(TOP+BACK,norot=1) fwd(50) cuboid([110,offset_8mm,100],anchor=BOT+BACK);
        // Back
        attach(BOT+BACK+LEFT,norot=1) cuboid([550,50,765],anchor=BOT+BACK+LEFT)
        {
            // Attachment cutout
            tag("remove") attach(TOP,norot=1) cuboid([550,50,500],anchor=TOP);
            // Top
            attach(TOP+LEFT+BACK,norot=1) cuboid([550,caseY,100],anchor=LEFT+BOT+BACK)
            {
                tag("remove") cuboid([350,caseY-200,101]);
                // Clip acceptor
                attach(TOP+LEFT+FRONT,norot=1) cuboid([50,caseY-50,190],anchor=TOP+RIGHT+FRONT);
                attach(TOP+RIGHT+FRONT,norot=1) cuboid([50,caseY-50,190],anchor=TOP+LEFT+FRONT);
            }
        }
        // Sides
        attach(TOP+LEFT,norot=1) cuboid([60,caseY,615],anchor=BOT+LEFT); // left side
        attach(RIGHT,norot=1) right(100) cuboid([130,caseY,150],anchor=LEFT) // center bottom
        attach(RIGHT,norot=1) right(100) cuboid([110,caseY,150],anchor=LEFT) // right bottom
        {
            attach(TOP+RIGHT,norot=1) cuboid([60,caseY,615],anchor=BOT+RIGHT); // right side
            // Super 8 offset
            if (offset_s8)
                attach(TOP+BACK,norot=1) fwd(50) cuboid([110,offset_s8,100],anchor=BOT+BACK);
        }

        if (model) recolor("cornflowerblue")
        {
            attach(TOP,norot=1) fwd(offset_8mm) right(10) model_ir_reflective_sensor(anchor=BOT+FRONT,spin=-90)
            attach(BACK,norot=1) fwd(offset_8mm-offset_s8) fwd(10) model_ir_reflective_sensor(anchor=FRONT,spin=0);
        }

    }
}

module insert(anchor=CENTER,spin=0,orient=UP)
{
    // isize=[340,caseY-210,50];
    isize=[340,caseY-410,50];
    module insert_()
    {
        diff()
        cuboid(isize)
        {
            tag("remove") attach(FRONT,norot=1) 
            {
                left(100) fwd(1) cuboid([40,300,51], anchor=FRONT);
                right(100) fwd(1) cuboid([40,300,51], anchor=FRONT);
            }
        }
    }
    attachable(anchor,spin,orient,size=isize)
    {
        insert_();
        children();
    }
}

module forViewing()
{
//    model_ir_reflective_sensor(anchor=BOT);
    case();
    recolor("pink") up(800) right(220) insert();
}

module forPrinting()
{
    insert();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
