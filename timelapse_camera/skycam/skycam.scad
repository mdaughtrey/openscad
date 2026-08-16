ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
include <../../models/model_rpi_zero_wireless.scad>
include <../../models/model_rpi_camera.scad>
include <../../models/model_usbc_sink.scad>

$fn=96;

models=0;

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


// module mount(anchor=CENTER,spin=0,orient=UP)
// {
//     module mount_()
//     {
//         if (models)
//         {
//             *down(110)
//             model_rpi_camera(models=models);
//             down(360) fwd(870)
//             model_rpi_zero_wireless(orient=DOWN, spin=-90,anchor=RIGHT);
//         }
//         rmtag="klfjhd";
//         diff(rmtag)
//         position(BOT) // up(model_rpi_camera_pcbH)
//         // Board surround
//         rect_tube(isize=[model_rpi_camera_pcbL+20,model_rpi_camera_pcbW+20], h=model_rpi_camera_pcbH, size=[1200,1200],anchor=TOP)
//         {
//             // Mounting holes
//             position(BOT+FRONT) grid_copies(spacing=[820, 490], n=2)
//                  back(120+326) down(40) rect_tube(isize=[120,120],size=[250,200],irounding=60,rounding=30,h=160, anchor=TOP);
//             // Main Surround
//             position(BOT)
//             rect_tube(isize=[model_rpi_camera_pcbL+20,model_rpi_camera_pcbW+20], h=200, size=[1200,1200],anchor=TOP)
//             {
//                 tag(rmtag) position(TOP+BACK) back(1) cuboid([model_rpi_camera_pcbL, 150, 100], anchor=TOP+BACK);
// 
//                 // RPi Mounting holes
//                 position(BOT) back(480) down(50) grid_copies(spacing=[900, 2300], n=2)  tube(id=120,od=200,h=160, anchor=BOT);
//                 position(BOT) back(480) down(50) rect_tube(size=[model_rpi_zero_wireless_pcbW, model_rpi_zero_wireless_pcbL], 
//                     rounding=150, wall=70, h=100, anchor=BOT)
//                 // Assembly surround
//                 position(BACK+BOT) back(300) rect_tube(size=[model_rpi_zero_wireless_pcbW, model_rpi_zero_wireless_pcbL+750+300], 
//                     wall=70, h=310, anchor=BACK+BOT);
// 
//             }
//         }
//     }
//     attachable(anchor,spin,orient,size=[100,100,100])
//     {
//         mount_();
//         children();
//     }
// }

module case(anchor=CENTER,spin=0,orient=UP)
{
    pcbW = model_rpi_zero_wireless_pcbW;
    pcbL = model_rpi_zero_wireless_pcbL;
    module case_()
    {

        rmtag="liwfhds";
        htag="hliwfhds";
        ktag="kliwfhds";
        hide(htag)
        diff(rmtag)
        //rect_tube(size=[pcbW, pcbL+750+300], wall=70, h=100)
//        {
//            position(TOP)
            cuboid([pcbW+200, pcbL+800, 50], anchor=BOT, rounding=100, edges="Z")
            {
                // RPi Mounting holes
                position(BOT) grid_copies(spacing=[900, 2300], n=2) tube(id=80,od=180,h=200, anchor=TOP);
                if (models)
                {
                    down(250) 
                    model_rpi_zero_wireless(orient=DOWN, spin=-90,anchor=TOP);
                }

                *position(BOT) back(480) down(50) rect_tube(size=[model_rpi_zero_wireless_pcbW, model_rpi_zero_wireless_pcbL], 
                     rounding=150, wall=70, h=100, anchor=BOT);
                // position(TOP) up(1) fwd(260)  tag(rmtag) cuboid([320, 320, 102], anchor=TOP);
                // Main case
                tag(ktag) position(BOT) rect_tube(size=[pcbW+200, pcbL+800], wall=80, h=500, anchor=TOP, rounding=100)
                {
                    tag(rmtag) position(BOT+RIGHT+BACK) 
                    {
                        // Connector cutouts
                        fwd(550) down(1) right(1) cuboid([82, 700, 300], rounding=50, edges=[TOP+FRONT, TOP+BACK],  anchor=BOT+RIGHT+BACK)
                        position(FRONT) fwd(550)  cuboid([82, 1000, 300], rounding=50, edges=[TOP+FRONT, TOP+BACK],  anchor=BACK);
                    }
                    // Camera ribbon cutout
                    tag(rmtag) position(FRONT)
                    {
                        cuboid([700, 100, 100], edges="Y", rounding=50, anchor=FRONT);
                    }
                
                    // Vents
                    *tag(rmtag)
                    position(FRONT+BOT) up(200) fwd(1) cuboid([1000,82,100],rounding=50, edges="Y", anchor=BOT+FRONT);
                    tag(rmtag)
                    position(BACK+BOT) up(200) back(1) cuboid([1000,82,100],rounding=50, edges="Y", anchor=BOT+BACK);
                }


                tag(ktag)
                // Mounting holes
                position(BOT) grid_copies(spacing=[1050, 3000], n=2)
                     rect_tube(isize=[70,70],size=[200,200],irounding=35,rounding=30,h=440, anchor=TOP);
            }

 //       }
    }
    attachable(anchor,spin,orient,size=[pcbW+200,pcbL+800,550])
    {
        down(25) up(550/2)
        case_();
        children();
    }
}


module lid(anchor=CENTER,spin=0,orient=UP)
{
    pcbW = model_rpi_zero_wireless_pcbW;
    pcbL = model_rpi_zero_wireless_pcbL;
    module lid_()
    {

        rmtag="liwfhds";
        diff(rmtag)
        cuboid([pcbW+200, pcbL+800, 100], rounding=100, edges="Z")
        {
            // Inner lip
            // position(TOP) rect_tube(size=[pcbW+40,pcbL+800], wall=80, h=100, anchor=BOT)
            {
                // End tabs
                *position(TOP+FRONT) cuboid([1200, 80, 180], anchor=BOT+FRONT)
                tag(rmtag) up(1) position(TOP) cuboid([800,82,180], anchor=TOP);
                *position(TOP+BACK) cuboid([1200, 80, 180], anchor=BOT+BACK)
                tag(rmtag) up(1) position(TOP) cuboid([800,82,180], anchor=TOP);
            }
            // Mounting columns
            position(TOP) grid_copies(spacing=[1050, 3000], n=2)
                   rect_tube(isize=[100,100],size=[200,180],irounding=50,rounding=50,h=50, anchor=BOT);
            // Screw holes
            tag(rmtag)
            position(BOT) grid_copies(spacing=[1050, 3000], n=2) down(1) cyl(d=180, h=51, anchor=BOT)
                  position(TOP) cyl(d=100, h=52, anchor=BOT); 
            // Vents
            tag(rmtag)  position(BOT) ycopies(spacing=200, n=14) down(1) cuboid([500,100,102], rounding=50, edges="Z", anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,size=[pcbW, pcbL,100])
    {
        lid_();
        children();
    }
}

module base(anchor=CENTER,spin=0,orient=UP)
{
    module base_()
    {
        rmtag="rvcr5q12";
        diff(rmtag)
        tube(id=4560, wall=100, h=200)
        {
            position(BOT) tube(od=4560, wall=100, h=430, anchor=BOT);
            position(BOT) tube(id=4560, wall=100, h=1250, anchor=TOP)
            {
                if (models)
                {
                    recolor("cornflowerblue")
                    position(BOT+BACK) fwd(1000)
                    cuboid([3356, 670,1400], anchor=BOT+BACK);
                }
                // RPi Holder
                position(BOT+BACK) fwd(1340)
                grid_copies(n=2,spacing=[2000,1020]) rect_tube(isize=[80,80],size=[300,300],irounding=40,rounding=50,l=1350,anchor=BOT);
                *position(BOT+BACK) fwd(890) cuboid([2000,200,500],anchor=BOT)
                position(FRONT+BOT) fwd(690) cuboid([2000,100,200],anchor=BACK+BOT);
                // Base
                position(BOT) cyl(d=4760,h=100,anchor=TOP)
                {
                    // Base Screw Holes 1934
                    position(BOT) tag(rmtag)
                    zrot_copies(n=3, r=1934, sa=-30) down(1) cyl(d=400,l=102,anchor=BOT);
                    position(TOP) down(1) zrot_copies(n=3, r=1934, sa=-30) 
                    tube(id=400,wall=100,l=1200,anchor=BOT)
                    position(TOP) tube(id=180,od=600,l=200,anchor=BOT);

                    // USBC Cable Entry Cutout and Shroud
                    tag(rmtag)
                    position(FRONT+BOT) down(1)
                    cuboid([600,1000,400],anchor=FRONT+BOT, edges=[TOP+LEFT,TOP+RIGHT], rounding=100);
                }

                // USBC Sink Holder
                position(BOT+FRONT) back(1500) left(400)
                {
//                    translate([-160,410,-270]) rect_tube(size=[300,390],isize=[80,80],h=260,irounding=40,rounding=50);
                    rect_tube(size=[390,300],isize=[80,80],h=260,irounding=40,rounding=50)
                    {
                        position(BOT+RIGHT) right(430)
                        rect_tube(size=[390,300],isize=[80,80],h=260,irounding=40,rounding=50,anchor=BOT+LEFT);
                        if (models)
                        {
                            position(BOT+RIGHT) up(60)
                            model_usbc_sink(spin=-90,anchor=BOT+FRONT);
                        }
                    }
                }
                // USBC Cable Entry Cutout and Shroud
                *tag(rmtag)
                position(FRONT+BOT)
                cuboid([900,1000,400],anchor=FRONT+BOT);
                //cyl(d=900,h=1000,orient=FRONT,anchor=TOP);
                position(FRONT+BOT) back(80) down(100)
                top_half(s=2500)
                rect_tube(isize=[600,300], wall=100,l=1000,anchor=BACK+BOT,orient=BACK,rounding=100);
//                tag("keep") position(BOT) tube(od=1100,id=500,l=100,anchor=BOT);

            }
            
        }
    }
    attachable(anchor,spin,orient,d=4560, h=200)
    {
        base_();
        children();
    }
}

module forViewing()
{
//    model_usbc_sink()
//    position(TOP+LEFT) left(160) down(200)
//    usbc_sink_cover(anchor=LEFT);
    base();
//    fwd(260) up(50)
//    recolor("cornflowerblue")
//    mount();
//    case()
//    position(BOT) down(00)
//    %lid();
//    down(630) lid();
//    model_rpi_camera();
//    model_rpi_zero_wireless();
//    back(2500)
//    model_rpi_camera();
}

module forPrinting()
{
//    case();
//    lid();
//    usbc_sink_cover();
    base();
}


scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
