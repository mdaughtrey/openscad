ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>
include <../BOSL2-master/rounding.scad>
include <../models/model_ssd1306.scad>
include <../models/pushbutton.scad>
include <../models/model_fingerprint_sensor_as608.scad>
include <../models/model_fingerprint_sensor_sfm_v17.scad>
include <../models/model_esp32_s3_wroom.scad>

$fn=96;
coverX = 1700 * 2;
coverY = 1500 + 800 * 4;
coverZ = 525;
coverWall = 150;
    bcx = coverX + coverWall * 2 - 200 - 40;
    bcy = coverY + coverWall * 2 - 200 - 40;
    bcz = 500;
    bcx2 = floor(bcx/2);
    bcy2 = floor(bcy/2);
    bcz2 = floor(bcz/2);

alignment = true;

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


module board_surround(anchor=CENTER,spin=0,orient=UP,twobuttons=0)
{
    l = ssd1306_128_32_length;
    w = ssd1306_128_32_width;

    module _board_surround()
    {
        diff()
        cuboid([l+100,w+100,50],rounding=100,edges="Z")
        {
            // Components
            tag("remove")
            attach(TOP+LEFT,norot=1)
            right(535) 
            cuboid([160,w,50],anchor=TOP+LEFT);

            tag("remove")
            attach(TOP+LEFT,norot=1)
            right(765)
            cuboid([160,w,50],anchor=TOP+LEFT);

            tag("remove")
            attach(TOP+LEFT,norot=1)
            right(1035)
            cuboid([210,w,50],anchor=TOP+LEFT);

            // Signal Connections
            tag("remove")
            attach(RIGHT+BOT,norot=1)
            left(60)
            cuboid([200,w,60],anchor=RIGHT+BOT,rounding=50,edges="Z");

            // Wire Channel
            tag("remove")
            attach(LEFT+BOT,norot=1)
            right(60)
            cuboid([l-60,200,60],anchor=LEFT+BOT);

            // General Cutout
            *tag("remove")
            attach(LEFT+BOT,norot=1)
            right(60)
            cuboid([380,w,60],anchor=LEFT+BOT,rounding=50,edges="Z");
            
            if (twobuttons)
            {
                // Button Surround
                attach(LEFT+BOT,norot=1) right(180)
                rect_tube(140,isize=[490,490],size=[590,w+100],anchor=TOP+LEFT)
                tag("remove")
                attach(BOT,norot=1)
                cuboid([600,290,140],anchor=BOT);

                // Button Surround
                attach(RIGHT+BOT,norot=1) left(180)
                rect_tube(140,isize=[490,490],size=[590,w+100],anchor=TOP+RIGHT)
                tag("remove")
                attach(BOT,norot=1)
                cuboid([600,290,140],anchor=BOT);
            }
            else
            {
                // Button Surround
                attach(BOT,norot=1)
                rect_tube(140,isize=[480,480],size=[590,w+120],anchor=TOP)
                tag("remove")
                attach(BOT,norot=1)
                cuboid([600,290,140],anchor=BOT);

            }
            // Skirt
            attach(BOT,norot=1)
            rect_tube(140,size=[l+100,w+100],
                wall=50,rounding=100,anchor=TOP); 
        }
    }
    attachable(anchor,spin,orient,size=[l+110,w+110,190])
    {
        _board_surround();
        children();
    }
}

module facia_top(d=120,l,w)
{
    rect_tube(h=50,rounding=d/2,wall=d,isize=[l-460-d,w-d])
    attach(TOP,norot=1)

    top_half(s=l*2)
    {
        ycopies(n=2,spacing=w)
        cyl(l=l-460,d=d,orient=LEFT)
        {
            attach(TOP) sphere(d=d);
            attach(BOT) sphere(d=d);
        }

        xcopies(n=2,spacing=l-460)
        cyl(l=w,d=d,orient=BACK)
        {
            attach(TOP) sphere(d=d);
            attach(BOT) sphere(d=d);
        }
    }
}

module facia(anchor=CENTER,
    spin=0,
    orient=UP,
    l = ssd1306_128_32_length,
    w = ssd1306_128_32_width
)
{
    
    attachable(anchor,spin,orient,
        size=[l+120,w+120,175])
    {
        diff()
        cuboid([l+120,w+120,150],rounding=100,edges="Z")
        {
            tag("remove") {
                attach(BOT,norot=1) 
                cuboid([l+20,w+20,60],anchor=BOT)
                attach(RIGHT+TOP,norot=1,overlap=1) left(230)  
                cuboid([l-230+20,w+20,75],
                    anchor=RIGHT+BOT)
                {
                    right(230/2)
                    {
                        tag("keep")
                        {
                            attach(TOP,norot=1) facia_top(l=l,w=w); 
                        }
                        attach(TOP,norot=1) 
                        cuboid([l-460,w,26],anchor=BOT);
                    }
                }
             }
        }
        children();
    }
}

module enclosure(anchor=CENTER,spin=0,orient=UP,tapeinsert=0)
{
    l = ssd1306_128_32_length;
    w = ssd1306_128_32_width;

    extra = tapeinsert ? 5 : 0;

    module _enclosure()
    {
        d=120;
        rect_tube(h=475,isize=[l+140+extra,w+140+extra],wall=70-extra)
        attach(TOP,norot=1)
        diff()
        cuboid([l+280-extra,w+280-extra,35],anchor=BOT)
        tag("remove") attach(CENTER)
        cuboid([l-460-d+240+30+extra,w+150-d+110+extra,51],rounding=75,edges="Z");
    }
    attachable(anchor,spin,orient,
        size=[l+140+extra,w+140+extra,510])
    {
        _enclosure();
        children();
    }
}

module standalone_backstop(anchor=CENTER,spin=0,orient=UP)
{
    l = ssd1306_128_32_length;
    w = ssd1306_128_32_width;

    module standalone_backstop_()
    {
        diff()
        cuboid([l+140+80,w+140+80,50])
        {
            //attach(TOP,norot=1) cuboid([l+130,w+130,50],anchor=BOT);
            attach(TOP,norot=1) rect_tube(h=100,size=[l+130,w+130],wall=50,anchor=BOT)
            {
                attach(LEFT+BOT,norot=1) right(390/2+180+90)
                cyl(h=80,d=310,anchor=BOT);
                attach(RIGHT+BOT,norot=1) left(390/2+180+90)
                cyl(h=80,d=310,anchor=BOT);
            }
            tag("remove") attach(RIGHT+BOT,norot=1) left(100) cuboid([300,500,101],rounding=100,edges="Z",anchor=BOT+RIGHT);
        }
    }
    attachable(anchor,spin,orient,size=[l+140,w+140,150])
    {
        down(50)
        standalone_backstop_();
        children();
    }
}

module backstop(anchor=CENTER,spin=0,orient=UP)
{
    l = ssd1306_128_32_length;
    w = ssd1306_128_32_width;

    module backstop_()
    {
        diff("remove2")
//        cuboid([l+140+80,w+140+80,50])
//        {
            //attach(TOP,norot=1) cuboid([l+130,w+130,50],anchor=BOT);
            rect_tube(h=150,size=[l+100,w+100],wall=50,anchor=BOT)
            {
                tag("remove2")
                {
                    attach(FRONT, norot=1, overlap=1)
                    cuboid([1000,60,152], anchor=FRONT);
                    attach(BACK, norot=1, overlap=1)
                    cuboid([1000,60,152], anchor=BACK);
                }
                attach(LEFT+BOT,norot=1) right(390/2+180+90)
                cyl(h=90,d=310,anchor=BOT);
                attach(RIGHT+BOT,norot=1) left(390/2+180+90)
                cyl(h=90,d=310,anchor=BOT);
            }
//            tag("remove") attach(RIGHT+BOT,norot=1) left(100) cuboid([300,500,101],rounding=100,edges="Z",anchor=BOT+RIGHT);
//        }
    }
    attachable(anchor,spin,orient,size=[l+140,w+140,150])
    {
        down(75)
        backstop_();
        children();
    }
}

module buttonblank()
{
    rect_tube(190,size=[ssd1306_128_32_length+120,ssd1306_128_32_width+120],
        wall=60,rounding=100) 
    attach(TOP,norot=1) facia(anchor=BOT);
}

module fingerprint_surround(anchor=CENTER, spin=0, orient=UP)
{
    modelX = model_fingerprint_sensor_as608X;
    modelY = model_fingerprint_sensor_as608Y;
    modelZ = model_fingerprint_sensor_as608Z;

    rect_tube(isize=[modelX+20, modelY+20], wall=100, h=modelZ-550, rounding=170, irounding=0);
}


module fingerprint_sensor_surround(anchor=CENTER, spin=0, orient=UP, size=[1000, 1000])
{
    module fingerprint_sensor_surround_()
    {
        diff()
        cuboid([size[0], size[1], 526], rounding=100, edges=[LEFT+BACK,RIGHT+BACK])
        {
            tag("remove")
            {
                attach(TOP, norot=1) cyl(d=700, h=75, anchor=TOP)
                attach(BOT, norot=1) cyl(d=600, h=100, anchor=TOP)
                attach(BOT, norot=1) cyl(d=1000, h=526 - 175, anchor=TOP);
            }
        }
    }
    attachable(anchor, spin, orient, size=[size[0], size[1], 526])
    {
        fingerprint_sensor_surround_();
        children();
    }
}

module caseFacia(x, y, rounding=200, anchor=CENTER, spin=0, orient=UP)
{
    path = rect([x-rounding, y-rounding]);
    r = round_corners(path, r = rounding);
    attachable(anchor, spin, orient, size=[x+rounding/2, y+rounding/2, rounding])
    {
        top_half(s = max(x, y) + 200)
        path_sweep(circle(d = rounding),r,closed=true);
        children();
    }
}

module fingerprintSensorFacia(d, rounding=200, anchor=CENTER, spin=0, orient=UP)
{
    path = circle(d=d);
    attachable(anchor, spin, orient, d=d,l=rounding)
    {
        top_half(s = d + 200)
        path_sweep(circle(d = 2*rounding),path,closed=true);
        children();
    }
}

module case()
{
//    l = ssd1306_128_32_length + 140;
//    w = ssd1306_128_32_width + 140;
    l = ssd1306_128_32_length;
    w = ssd1306_128_32_width;
    module onecutout(anchor=CENTER,spin=0,orient=UP)
    {
        module onecutout_()
        {
            d=120;
            extra = 0;
            cuboid([l+140,w+140,475])
            {
                attach(TOP,norot=1)
    //            cuboid([l-460-d+210+30,w+10-d+110,51],rounding=75,edges="Z",anchor=BOT);
                  cuboid([l-460-d+240+30+extra,w+150-d+110+extra,51],rounding=75,edges="Z", anchor=BOT);
//                attach(BOT+FRONT,norot=1) cuboid([500,200,500], anchor=BOT+BACK);
//                attach(BOT+BACK,norot=1) cuboid([500,300,300], anchor=BOT+FRONT);
            }
        }
        attachable(anchor, spin, orient, size=[l,w,526])
        {
            down(25)
            onecutout_();
            children();
        }
    }


    module case_(anchor=CENTER, orient=UP, spin=0)
    {
        attachable(anchor, spin, orient, size=[coverX + coverWall * 2, coverY + coverWall * 2, coverZ + 300])
        {
            down(coverZ/2)
            hide("hide")
            diff()
            tag(alignment?"hide":"")
            cuboid([coverX + coverWall * 2,
                coverY + coverWall * 2, 
                coverZ + 300],
                rounding = 200,
                edges = "Z",
                //edges = [FRONT+LEFT, FRONT+RIGHT, BACK+RIGHT],
                anchor = BOT)
            {
                // Wiring channels
                tag("remove")
                {
                    attach(BOT, norot=1) right(800) up(300)
                    cuboid([500, 4000, 300], anchor=BOT);
                    attach(BOT, norot=1) left(800) up(300)
                    cuboid([500, 4000, 300], anchor=BOT);
                    attach(BOT, norot=1) left(0) up(300) back(1750)
                    cuboid([1000, 400, 300], anchor=BOT);

                }


                // Heat inserts
                tag(alignment?"":"remove")
                attach(TOP, norot=1) down(50)
                {
                    grid_copies([coverX/3+400, coverY - 200], [3,2]) cyl(d=100, h=522, anchor=TOP);
                    back(1000) cyl(d=100, h=522, anchor=TOP);
                }
                // Macro Key cutouts
                attach(TOP+FRONT, norot=1) tag(alignment?"":"remove") back(1650)
                grid_copies([1700,700], [2, 4]) onecutout(anchor=TOP+FRONT);

                // Fingerprint Sensor Cutout
                attach(BACK+LEFT, norot=1) right(coverWall + 1700/2) fwd(200 + coverWall + 800/2)
                tag("remove")
                {
                    attach(TOP, norot=1) cyl(d=846, h=50, anchor=TOP) 
                    {
                        attach(BOT, norot=1) cyl(d=768, h=130, anchor=TOP) 
                        {
                            zrot(-45) attach(LEFT, norot=1) cyl(d=100,h=130);
                            zrot(45) attach(LEFT, norot=1) cyl(d=100,h=130);
                            zrot(180) attach(LEFT, norot=1) cyl(d=100,h=130);
                            //attach(BOT, norot=1) cyl(d=600, h=526 - 175, anchor=TOP)
                            attach(BOT, norot=1) cyl(d=1100, h=526-50, anchor=TOP);
                        }
                        //attach(BOT, norot=1) tube(id=920, wall=100, h=526-50, anchor=TOP);
                    }
                }

                // Selector Cutout
                tag(alignment?"":"remove")
                attach(BACK+RIGHT+TOP, norot=1) left(coverWall + 1700/2) fwd(200 + coverWall + 800/2)
                onecutout(anchor=TOP);

                // Skirt Cutout
                tag("remove")
                attach(BOT, norot=1, overlap=1)
                cuboid([coverX + coverWall * 2 - 200,
                coverY + coverWall * 2 - 200, 
                301],
                rounding = 100,
                edges = "Z",
                //edges = [FRONT+LEFT, FRONT+RIGHT, BACK+RIGHT],
                anchor = BOT);
                    
            
            }
            children();
        }
    }
    case_()
    attach(TOP, norot=1) up(150-130/2)
    {
        caseFacia(coverX + coverWall * 2, coverY + coverWall * 2, rounding=130, anchor=BOT);
        left(1700/2) back(1750) up(50)
        fingerprintSensorFacia(d=950,rounding=50,anchor=BOT);
    }
}

module sensor_test()
{
    // Fingerprint Sensor Cutout
    diff()
    cyl(d=1200,h=526)
//    attach(BACK+LEFT, norot=1) right(coverWall + 1700/2) fwd(200 + coverWall + 800/2)
    tag("remove")
    {
        attach(TOP, norot=1) cyl(d=846, h=50, anchor=TOP) 
        {
            attach(BOT, norot=1) cyl(d=768, h=130, anchor=TOP) 
            {
                zrot(-45) attach(LEFT, norot=1) cyl(d=100,h=130);
                zrot(45) attach(LEFT, norot=1) cyl(d=100,h=130);
                zrot(180) attach(LEFT, norot=1) cyl(d=100,h=130);
                attach(BOT, norot=1) cyl(d=600, h=526 - 175, anchor=TOP);
            }
              attach(BOT, norot=1) tube(id=920, wall=100, h=526-50, anchor=TOP);
        }
    }
}

module stand(anchor=CENTER, spin=0, orient=UP)
{
    cx = coverX + coverWall * 2 - 200 - 40;
    cy = coverY + coverWall * 2 - 200 - 40;
    module stand_()
    {
        diff()
        cuboid([cx, cy, 100], rounding = 100, edges = "Z")
        {
            // Heat inserts
            tag("remove")
            #attach(BACK, norot=1, overlap=1)
            {
                fwd(80)
                screws(d=100, h=alignment?1000:110, anchor=BACK);
                *grid_copies([coverX/3+400, coverY - 200], [3,2]) cyl(d=100, h=alignment?1000:110, anchor=BOT);
                *back(1000) cyl(d=100, h=alignment?1000:110, anchor=BOT);
            }
            // NW cutout
            tag("remove") attach(TOP+BACK+LEFT, norot=1)
            right(200) fwd(200) up(1) cuboid([1300, 1300, 111], rounding=200, edges="Z", anchor=TOP+LEFT+BACK);

            // Macro key backstops
            attach(TOP+FRONT, norot=1) back(1650+120)
            grid_copies([1700,700], [2, 4]) backstop(anchor=BOT);

            // Selector backstop
            attach(BACK+RIGHT+TOP, norot=1)
            left(coverWall + 1700/2 - 120) fwd(200 + coverWall + 800/2-120) backstop(anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,size=[cx,cy,301])
    {
        stand_();
        children();
    }
}

module screws(anchor=CENTER, spin=0, orient=UP, h=500, d=100)
{
    center_offset=1500;
    module screws_()
    {
        cyl(d=d, h=h)
        fwd(bcy2-center_offset)
        grid_copies([coverX/3+400, coverY - 200], [3,2]) 
        cyl(d=d, h=h);
    }
    sizeY = coverY-200+d;
    attachable(anchor,spin,orient,size=[2*(coverX/3+400)+d,sizeY,h])
    {
        back(bcy2-center_offset)
        screws_();
        children();
    }
}

module screws_back_cover(anchor=CENTER, spin=0, orient=UP, h=500, d=100)
{
    center_offset=1500;
    module screws_()
    {
        cyl(d=d, h=h)
        back(center_offset-d)
        xcopies(coverX/3+400, n=3)
        cyl(d=d, h=h);
    }
    sizeY = center_offset+d;
    attachable(anchor,spin,orient,size=[2*(coverX/3+400)+d,sizeY,h])
    {
        fwd(center_offset/2-d)
        screws_();
        children();
    }
}

module back_cover_outer(anchor=CENTER, spin=0, orient=UP)
{
    bcx = coverX + coverWall * 2 - 200 - 40;
    bcy = coverY + coverWall * 2 - 200 - 40;
    bcz = 500;
    bcx2 = floor(bcx/2);
    bcy2 = floor(bcy/2);
    bcz2 = floor(bcz/2);

    module back_cover_()
    {
        rounding=100;
//        diff()
        cuboid([bcx2, 2000, bcz], rounding=rounding, edges=[TOP,LEFT+BACK], except=[FRONT,RIGHT])
        {
            attach(RIGHT,norot=1)
            cuboid([bcx2, 2000, bcz], rounding=rounding, edges=[TOP,RIGHT+BACK,RIGHT+FRONT], except=[LEFT], anchor=LEFT);
            attach(FRONT, norot=1)
            cuboid([bcx2, bcy2-2000, bcz], anchor=BACK, rounding=rounding, edges=[TOP,LEFT+FRONT,RIGHT+FRONT], except=[BACK]);
        }
    }
    attachable(anchor, spin, orient, size=[bcx, 2000, bcz])
    {
        fwd(2000/2)
        back(bcy2/2)
        left(bcx2/2)
        back_cover_();
        children();
    }
}

module back_cover(anchor=CENTER, spin=0, orient=UP)
{
    diff("bc_remove")
    back_cover_outer(anchor,spin,orient)
    
    // Screw holes
//    move([0,0,alignment?-500:-500])
    back(110)
    tag("bc_remove")
    attach(BACK,norot=1) 
    {
        #screws_back_cover(anchor=BACK)
        up(100) screws_back_cover(d=250);
    }
}

module rounding_test0()
{
    rounding=100;
    diff()
    cuboid([1000, 1000, 500], rounding=rounding, edges=[FRONT+LEFT, BACK+LEFT])
    {
        tag("remove")
        {
             edge_mask([TOP], except=[RIGHT]) rounding_edge_mask(l=1000,r=rounding);
             attach([FRONT+TOP+LEFT], norot=1) rounding_corner_mask(r=rounding,orient=DOWN,spin=90);
             attach([BACK+TOP+LEFT], norot=1) rounding_corner_mask(r=rounding,orient=DOWN,spin=180);
        }
        attach(RIGHT+BACK, norot=1)
        cuboid([1000, 2000, 500], anchor=LEFT+BACK, rounding=rounding, edges=[FRONT+LEFT, FRONT+RIGHT, BACK+RIGHT])
        {
            tag("remove")
            {
                 edge_mask([TOP+BACK]) rounding_edge_mask(l=1000,r=rounding);
                 edge_mask([RIGHT+TOP]) rounding_edge_mask(l=2000,r=rounding);
                 edge_mask([FRONT+TOP]) rounding_edge_mask(l=1000,r=rounding);
                 fwd(500) edge_mask([LEFT+TOP]) rounding_edge_mask(l=1000,r=rounding);

                 attach([FRONT+TOP+LEFT], norot=1) rounding_corner_mask(r=rounding,orient=DOWN,spin=90);
                 attach([FRONT+TOP+RIGHT], norot=1) rounding_corner_mask(r=rounding,orient=DOWN,spin=0);
                 attach([BACK+TOP+RIGHT], norot=1) rounding_corner_mask(r=rounding,orient=DOWN,spin=-90);
            }
        }
    }
}

module rounding_test()
{
    cx = coverX + coverWall * 2 - 200 - 40;
    cy = coverY + coverWall * 2 - 200 - 40;
    path = [
        square([1000,900]),
        move([1000,-1000], p = square([900,1900]))
    ];
    q = union(path);
    rc = round_corners(q,r=50);

//    path_sweep(circle(d=100),rc,closed=true);
    
    rounding=100;
    diff()
    cuboid([1000, 1000, 500], rounding=rounding, edges=[FRONT+LEFT, BACK+LEFT])
    {
        tag("remove")
        {
             // Top edge cutout
             edge_mask([TOP], except=[RIGHT]) cuboid([rounding, rounding, 1000]);
        }
        attach(RIGHT+BACK, norot=1)
        cuboid([1000, 2000, 500], anchor=LEFT+BACK, rounding=rounding, edges=[FRONT+LEFT, FRONT+RIGHT, BACK+RIGHT])
        {
            tag("remove")
            {
                 // Top edge cutout
                 edge_mask([TOP], except=[LEFT,RIGHT]) cuboid([rounding, rounding, 1000]);
                 attach(RIGHT+TOP, norot=1) cuboid([rounding, 2000, rounding]);
                 attach(LEFT+TOP+FRONT, norot=1) cuboid([rounding, 1050, rounding],anchor=FRONT);
            }
        }
        // Rounded top
        tag("keep")
        left(450) fwd(450) up(200)
        path_sweep(circle(d=100),rc,closed=true);

        // Screw holes
        tag("remove")
        attach(BOT, norot=1)  up(100)
        {
            grid_copies([coverX/3+400, coverY - 200], [3,2]) 
            cyl(d=100, h=1000, anchor=BOT);
            back(1000) cyl(d=100, h=1000, anchor=BOT);
        }
       
    }
}

module rounded_squares()
{
    cuboid([1000,1000,500], rounding=100, edges=[TOP,LEFT+FRONT,LEFT+BACK], except=[RIGHT])
    attach(RIGHT, norot=1) 
    cuboid([1000,1000,500], rounding=100, edges=[TOP], except=[LEFT,FRONT], anchor=LEFT)
    attach(FRONT, norot=1) 
    cuboid([1000,1000,500], rounding=100, edges=[TOP], except=[BACK], anchor=BACK);
}

module forViewing()
{
    bcy = coverY + coverWall * 2 - 200 - 40;
    stand()
    attach(BOT,norot=1) recolor("cornflowerblue") 
    back(bcy/4)
    back_cover(orient=DOWN,anchor=BOT);
//      screws();
//        screws_back_cover();

}

module forPrinting()
{
//    buttonblank();
//   facia();
//    board_surround(twobuttons=1);
//    enclosure();
//    backstop();
//    stand();
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
//    facia();
}
