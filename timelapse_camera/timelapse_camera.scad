ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>
include <../models/model_rpi_zero_wireless.scad>
include <../models/model_rpi_camera.scad>

$fn=96;

models=1;

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


module mount(anchor=CENTER,spin=0,orient=UP)
{
    module mount_()
    {
        if (models)
        {
            down(110)
            model_rpi_camera(models=models);
            down(360) fwd(870)
            model_rpi_zero_wireless(orient=DOWN, spin=-90,anchor=RIGHT);
        }
        rmtag="klfjhd";
        diff(rmtag)
        position(BOT) // up(model_rpi_camera_pcbH)
        // Board surround
        rect_tube(isize=[model_rpi_camera_pcbL+20,model_rpi_camera_pcbW+20], h=model_rpi_camera_pcbH, size=[1200,1200],anchor=TOP)
        {
            // Mounting holes
            position(BOT+FRONT) grid_copies(spacing=[820, 490], n=2)
                 back(120+326) down(40) rect_tube(isize=[120,120],size=[250,200],irounding=60,rounding=30,h=160, anchor=TOP);
            // Main Surround
            position(BOT)
            rect_tube(isize=[model_rpi_camera_pcbL+20,model_rpi_camera_pcbW+20], h=200, size=[1200,1200],anchor=TOP)
            {
                tag(rmtag) position(TOP+BACK) back(1) cuboid([model_rpi_camera_pcbL, 150, 100], anchor=TOP+BACK);

                // RPi Mounting holes
                position(BOT) back(480) down(50) grid_copies(spacing=[900, 2300], n=2)  tube(id=120,od=200,h=160, anchor=BOT);
                position(BOT) back(480) down(50) rect_tube(size=[model_rpi_zero_wireless_pcbW, model_rpi_zero_wireless_pcbL], 
                    rounding=150, wall=70, h=100, anchor=BOT)
                // Assembly surround
                position(BACK+BOT) back(300) rect_tube(size=[model_rpi_zero_wireless_pcbW, model_rpi_zero_wireless_pcbL+750+300], 
                    wall=70, h=310, anchor=BACK+BOT);

            }
        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        mount_();
        children();
    }
}

module case(anchor=CENTER,spin=0,orient=UP)
{
    module case_()
    {
        pcbW = model_rpi_zero_wireless_pcbW;
        pcbL = model_rpi_zero_wireless_pcbL;

        rmtag="liwfhds";
        htag="hliwfhds";
        ktag="kliwfhds";
        hide(htag)
        diff(rmtag)
        rect_tube(size=[pcbW, pcbL+750+300], wall=70, h=100)
        {
            position(TOP) cuboid([pcbW+200, pcbL+750+500, 50], anchor=BOT, rounding=50, edges="Z")
            {
                position(TOP) up(1) fwd(260)  tag(rmtag) cuboid([320, 320, 102], anchor=TOP);
                // Main case
                tag(ktag) position(BOT) rect_tube(size=[pcbW+200, pcbL+750+500], wall=80, h=700, anchor=TOP, rounding=50)
                {
                    tag(rmtag) position(BOT+RIGHT+BACK)
                    {
                        // Connector cutouts
                        fwd(550) down(1) right(1) cuboid([82, 700, 300], rounding=50, edges=[TOP+FRONT, TOP+BACK],  anchor=BOT+RIGHT+BACK)
                        position(FRONT) fwd(550)  cuboid([82, 1000, 300], rounding=50, edges=[TOP+FRONT, TOP+BACK],  anchor=BACK);
                    }
                
                    // Vents
                    tag(rmtag)
                    position(FRONT+BOT) up(200) fwd(1) cuboid([1000,82,100],rounding=50, edges="Y", anchor=BOT+FRONT);
                    tag(rmtag)
                    position(BACK+BOT) up(200) back(1) cuboid([1000,82,100],rounding=50, edges="Y", anchor=BOT+BACK);
                }


                tag(ktag)
                // Mounting holes
                position(BOT) grid_copies(spacing=[840, 3250], n=2)
                     rect_tube(isize=[70,70],size=[200,200],irounding=35,rounding=30,h=540, anchor=TOP);
            }

        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
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
        cuboid([pcbW+200, pcbL+750+500, 50], rounding=50, edges="Z")
        {
            // Inner lip
            position(TOP) rect_tube(size=[pcbW+40,pcbL+750+300], wall=80, h=100, anchor=BOT)
            {
                // End tabs
                position(TOP+FRONT) cuboid([1200, 80, 180], anchor=BOT+FRONT)
                tag(rmtag) up(1) position(TOP) cuboid([800,82,180], anchor=TOP);
                position(TOP+BACK) cuboid([1200, 80, 180], anchor=BOT+BACK)
                tag(rmtag) up(1) position(TOP) cuboid([800,82,180], anchor=TOP);
            }
            // Mounting columns
            position(TOP) grid_copies(spacing=[840, 3250], n=2)
                   rect_tube(isize=[100,100],size=[250,250],irounding=50,rounding=50,h=160, anchor=BOT);
            // Screw holes
            tag(rmtag)
            position(BOT) grid_copies(spacing=[840, 3250], n=2) down(1) cyl(d=200, h=150, anchor=BOT);
            // Vents
            tag(rmtag)  position(BOT) ycopies(spacing=200, n=14) down(1) cuboid([500,100,52], rounding=50, edges="Z", anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,size=[pcbW, pcbL,100])
    {
        lid_();
        children();
    }
}

module forViewing()
{
    fwd(260) up(50)
    recolor("cornflowerblue")
    mount();
    case();
    down(630) lid();
//    model_rpi_camera();
//    model_rpi_zero_wireless();
//    back(2500)
//    model_rpi_camera();
}

module forPrinting()
{
//    case();
    lid();
}


scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
