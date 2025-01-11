ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>

$fn=96;
// include <../BOSL2-master/rounding.scad>
include <../models/model_ssd1306.scad>
include <../models/model_rpi_pico.scad>
include <../models/model_5v_3v3_buck.scad>
include <../models/model_rpi_pico.scad>
// include <../models/pushbutton.scad>
// include <../models/model_fingerprint_sensor_as608.scad>
// include <../models/model_fingerprint_sensor_zw101.scad>
// include <../models/model_esp32_s3_wroom.scad>
// include <../models/model_io_expander.scad>
// include <../models/model_i2c_mux.scad>

//         fingerprintSensorFacia(d=950,rounding=50,anchor=BOT);
// module fingerprintSensorFacia(d, rounding=200, anchor=CENTER, spin=0, orient=UP)
// {
//     path = circle(d=d);
//     attachable(anchor, spin, orient, d=d,l=rounding)
//     {
//         top_half(s = d + 200)
//         path_sweep(circle(d = 2*rounding),path,closed=true);
//         children();
//     }
// }
//                 // Fingerprint Sensor Cutout
//                 attach(BACK+LEFT, norot=1) right(coverWall + 1700/2) fwd(200 + coverWall + 800/2)
//                 tag("remove")
//                 {
//                     attach(TOP, norot=1) cyl(d=846, h=50, anchor=TOP) 
//                     {
//                         attach(BOT, norot=1) cyl(d=768, h=130, anchor=TOP) 
//                         {
//                             zrot(-45) attach(LEFT, norot=1) cyl(d=100,h=130);
//                             zrot(45) attach(LEFT, norot=1) cyl(d=100,h=130);
//                             zrot(180) attach(LEFT, norot=1) cyl(d=100,h=130);
//                             //attach(BOT, norot=1) cyl(d=600, h=526 - 175, anchor=TOP)
//                             attach(BOT, norot=1) cyl(d=1100, h=526-50, anchor=TOP);
//                         }
//                         //attach(BOT, norot=1) tube(id=920, wall=100, h=526-50, anchor=TOP);
//                     }
//                 }
// 
//module modname(anchor=CENTER,spin=0,orient=UP)
//{
//    module modname_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        modname_();
//        children();
//    }
//}

module top_display(anchor=CENTER,
    spin=0,
    orient=UP,
    l = ssd1306_128_32_length,
    w = ssd1306_128_32_width
)
{
    attachable(anchor,spin,orient, size=[l+120,w+120,120])
    {
        up(50)
        diff("td_remove")
        //cuboid([l+120,w+120,150])
        cuboid([l+120,w+120,20])
        {
            attach(BOT, norot=1)
            rect_tube(isize=[l+20, w+20], size=[l+120, w+120], h=100, anchor=TOP);
            tag("td_remove") 
            {
                attach(TOP,norot=1)
                cuboid([l-440,w-40,20],anchor=TOP);
            
//                *attach(BOT+LEFT, norot=1)
//                cuboid([1270, w, 50], anchor=TOP+LEFT);
//                attach(BOT+RIGHT, norot=1)
//                cuboid([l, w, 50], anchor=TOP+RIGHT);
//

//                attach(BOT,norot=1) 
//                cuboid([l+20,w+20,60],anchor=BOT)
//                attach(RIGHT+TOP,norot=1,overlap=1) left(230)  
//                cuboid([l-230+20,w+20,75], anchor=RIGHT+BOT);
//                {
//                    right(230/2)
////                    {
//                        tag("keep")
//                        {
//                            attach(TOP,norot=1) facia_top(l=l,w=w); 
//                        }
//                    }
//                }
            }
        }
    children();
    }
}

// module buttonblank()
// {
// //    rect_tube(190,size=[ssd1306_128_32_length+120,ssd1306_128_32_width+120],
// //        wall=60,rounding=100) ;
// //    attach(TOP,norot=1) facia(anchor=BOT);
//     facia();
// }

module top_sensor(anchor=CENTER,spin=0,orient=UP,
    l = ssd1306_128_32_length,
    w = ssd1306_128_32_width)
{
    module top_sensor_()
    {
        diff("cs_remove")
        cuboid([l+120,1200,120])
        {
            attach(TOP, norot=1) up(1)
            tag("cs_remove")
            {
                //             attach(TOP, norot=1) cyl(d=846, h=50, anchor=TOP) 
                cyl(d=846, h=50, anchor=TOP) 
                {
                    attach(BOT, norot=1) cyl(d=768, h=130, anchor=TOP) 
                    {
                        zrot(-45) attach(LEFT, norot=1) cyl(d=100,h=130);
                        zrot(45) attach(LEFT, norot=1) cyl(d=100,h=130);
                        zrot(180) attach(LEFT, norot=1) cyl(d=100,h=130);
                        //attach(BOT, norot=1) cyl(d=600, h=526 - 175, anchor=TOP)
                        // attach(BOT, norot=1) cyl(d=1100, h=526-50, anchor=TOP);
                    }
                }
            }
            //attach(BOT, norot=1) tube(id=920, wall=100, h=526-50, anchor=TOP);
        }
    }
    attachable(anchor,spin,orient,size=[l+120,1200,120])
    {
        top_sensor_();
        children();
    }
}

module case_top(anchor=CENTER,spin=0,orient=UP)
{
    l = ssd1306_128_32_length;
    w = ssd1306_128_32_width;
    module case_top_()
    {
        top_sensor()
        attach(BACK+TOP, norot=1) top_display(anchor=FRONT+TOP)
        attach(BACK+TOP, norot=1) cuboid([l+120, 500, 120], anchor=FRONT+TOP);
    }
    attachable(anchor,spin,orient,size=[1000,1000,120])
    {
        case_top_();
        children();
    }
}

module buck_mount(anchor=CENTER,spin=0,orient=UP)
{
    l = model_5v_3v3_buck_length + 20 + 100;
    w = model_5v_3v3_buck_width + 20 + 100;
    h = model_5v_3v3_buck_height;
    module buck_mount_()
    {
        model_5v_3v3_buck(anchor=BOT);
        rect_tube(isize=[model_5v_3v3_buck_length + 20,
            model_5v_3v3_buck_width + 20],
            wall = 50, h=h)
        {
            // SS34
            attach(LEFT+TOP+BACK, norot=1) right(220+50) fwd(50) cuboid([160, 100, 30], anchor=LEFT+TOP+BACK);
            // MP1584
            attach(LEFT+TOP+BACK, norot=1) right(177+50) fwd(250) cuboid([200, 160, 50], anchor=LEFT+TOP+BACK);
            // Top
            attach(TOP, norot=1) cuboid([l, w, 30], anchor=BOT);
        }

    }
    attachable(anchor,spin,orient,size=[l, w, h+30])
    {
        buck_mount_();
        children();
    }
}

module forViewing()
{
    buck_mount();
//    case_top();
//    down(500) back(400)
//    model_rpi_pico(spin=-90);
//    down(400) back(500)
//*    back(1050) down(100)
//    model_ssd1306_128_32();
//    buttonblank();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
