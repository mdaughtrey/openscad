ViewScale = [0.0254, 0.0254, 0.0254];
include <../../../BOSL2-master/std.scad>
include <../../../BOSL2-master/ball_bearings.scad>

include <../../../models/model_film.scad>
include <../../../models/model_ir_reflective_sensor.scad>

mm = function(tomill) tomill/25.4*1000;

model=0;
discd=1100;

module ir_sensor_mount(anchor=CENTER,spin=0,orient=UP)
{
    cutoutpad=10;
    norot=1;
    module ir_sensor_mount_()
    {
        diff()
        model_ir_reflective_sensor(cutoutpad=100)
        {
            // Temporary block to figure out the sense distance. Reduce or remove this and set the bearings to lift the film to the 
            // correct distance.
            attach(TOP,norot=1) cuboid([580,400,100],anchor=BOT);
            tag("remove") attach(BOT,norot=1)
            cuboid([700+cutoutpad*2,200+cutoutpad*2,250],anchor=BOT)
            attach(TOP,norot=1) prismoid(size1=[700+cutoutpad*2,200+cutoutpad*2],size2=[400+cutoutpad*2,200+cutoutpad*2],h=500,anchor=BOT)
            attach(TOP,norot=1) cuboid([200,100,150],anchor=BOT);


            tag("remove") attach(BOT,norot=1) fwd(50-5)
            cuboid([500,310,200+cutoutpad*2],anchor=BOT)
            attach(TOP+BACK,norot=1) 
            prismoid(size1=[500,310],size2=[280,310],h=450+cutoutpad,anchor=BOT+BACK);
        }
    }
    attachable(anchor,spin,orient,size=[700+200,200+200,600])
    {
        ir_sensor_mount_();
        children();
    }
}


module bearing_cap(anchor=CENTER,spin=0,orient=UP) 
{
    $fn=96;
    module bearing_cap_()
    {
        diff()
        cyl(d=discd,h=100) {
            tag("remove") attach(BOT,norot=1) cyl(d=200,h=300,anchor=BOT);
            attach(TOP,norot=1) cyl(d=500,h=mm(0.7),anchor=BOT)
            attach(TOP,norot=1) cyl(d=mm(7.5),h=mm(3),anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,d=discd,l=100+mm(3.7))
    {
        bearing_cap_();
        children();
    }
}

module filmguides(anchor=CENTER,spin=0,orient=UP,span=2000,lift=1)
{
    $fn=96;
    module filmguides_()
    {
        diff()
        cyl(d=discd,h=100) {
            tag("remove") attach(BOT,norot=1) cyl(d=200,h=300+lift,anchor=BOT);
            attach(BOT,norot=1) cuboid([span,500,100],anchor=BOT+LEFT)
            attach(RIGHT,norot=1) cyl(d=discd,h=100) {
                tag("remove") attach(BOT,norot=1) cyl(d=200,h=300+lift,anchor=BOT);
                attach(TOP,norot=1) cyl(d=discd,h=lift,anchor=BOT)
                attach(TOP,norot=1) cyl(d=500,h=mm(0.7),anchor=BOT)
                {
                    if (model)
                    {
                        attach(TOP,norot=1) scale([1/25.4,1/25.4,1/25.4]*1000) ball_bearing("608ZZ",anchor=BOT);
                    }
                    attach(TOP,norot=1) cyl(d=mm(7.5),h=mm(3),anchor=BOT);
                }
            }

            attach(TOP,norot=1) cyl(d=discd,h=lift,anchor=BOT)
            attach(TOP,norot=1) cyl(d=500,h=mm(0.7),anchor=BOT) {
                if (model)
                {
                    attach(TOP,norot=1) scale([1/25.4,1/25.4,1/25.4]*1000) ball_bearing("608ZZ",anchor=BOT);
                }
                attach(TOP,norot=1) cyl(d=mm(7.5),h=mm(3),anchor=BOT);
            }
        }
    }
    attachable(anchor,spin,orient,size=[span+discd,discd,100+lift+mm(0.7)+mm(3)])
    {
        left(span/2)
        down((100+lift+mm(3.7))/2-50)
        filmguides_();
        children();
    }
}


module filmguides0(anchor=CENTER,spin=0,orient=UP,width=1000)
{
    module _filmguides() {
        $fn=96;
        diff()
        cuboid([width,2300,100],rounding=450,edges="Z") {
            tag("remove") attach(TOP+BACK,norot=1) fwd(500) up(1) cyl(d=180,h=104,anchor=TOP);
            tag("remove") attach(TOP+FRONT,norot=1) back(500) up(1) cyl(d=180,h=104,anchor=TOP);
            tag("keep") attach(TOP+BACK,norot=1) fwd(500) tube(od=400,id=180,h=25,anchor=BOT) {
                attach(TOP) tube(od=300,id=180,h=130,anchor=BOT);
            }
            tag("keep") attach(TOP+FRONT,norot=1) back(500) tube(od=400,id=180,h=25,anchor=BOT) {
                attach(TOP) tube(od=300,id=180,h=130,anchor=BOT);
            }
        }
    }

    attachable(anchor,spin,orient,size=[width,2300,200+25+130])
    {
        down(50+25+275/2) _filmguides();
        children();
    }
}

module sensorholder(anchor=CENTER,spin=0,orient=UP)
{
    cutoutpad=10;
    module sensorholder_()
    {
        diff()
        cuboid([1000,400+cutoutpad*4+200,800]) {
            tag ("remove") attach(BOT,norot=1) back(100)
            cuboid([700+cutoutpad*2,200+cutoutpad*2,150],anchor=BOT) {
                attach(TOP,norot=1) prismoid(size1=[700+cutoutpad*2,200+cutoutpad*2],size2=[400+cutoutpad*2,200+cutoutpad*2],h=500,anchor=BOT) 
                attach(TOP,norot=1) cuboid([200,100,150],anchor=BOT);
                attach(FRONT+BOT,norot=1) left(50)  cuboid([700+cutoutpad*2,200+cutoutpad*2,150],anchor=BACK+BOT)
                attach(TOP,norot=1) prismoid(size1=[700+cutoutpad*2,200+cutoutpad*2],size2=[400+cutoutpad*2,200+cutoutpad*2],h=500,anchor=BOT) 
                attach(TOP,norot=1) cuboid([200,100,150],anchor=BOT);
            }
            tag("remove") attach(RIGHT,norot=1) cuboid([110,400+cutoutpad*4+200,510],anchor=RIGHT);
        }
    }
    attachable(anchor,spin,orient,size=[1000,400+cutoutpad*4+200,800])
    {
        sensorholder_();
        children();
    }
}

module vexmount0(anchor=CENTER,spin=0,orient=UP)
{
    $fn=96;
    module vexmount0_()
    {
        diff()
        cuboid([3000,900,200],rounding=100,edges="Z") {
        tag("remove") left(250) grid_copies(n=2,size=[1500,500]) cuboid([750,180,200],rounding=90,edges="Z");
        tag("remove") attach(RIGHT,norot=1) cuboid([200,510,200],anchor=RIGHT);
        }
    }
    attachable(anchor=anchor,spin=spin,orient=orient,size=[3000,900,200])
    {
        vexmount0_();
        children();
    }
}

module vexmount1(anchor=CENTER,spin=0,orient=UP,span=1000)
{
    $fn=96;
    discd=600;
    tilt=10;
    module vexmount1_()
    {
        diff()
        cyl(d=discd,h=200) {
            tag("remove") attach(BOT,norot=1) cyl(d=200,h=200,anchor=BOT);
            attach(BOT,norot=1) cuboid([span,500,200],anchor=BOT+LEFT) {
            intersect("mask") {
                attach(TOP,norot=1) zrot(tilt) left(105) cuboid([100,600,300],anchor=BOT+RIGHT)
                attach(RIGHT+BOT,norot=1) right(210) cuboid([100,600,300],anchor=BOT+LEFT);
                tag("mask") attach(TOP,norot=1) cuboid([1000,500,300],anchor=BOT);
            }
            tag("remove") attach(TOP,norot=1) zrot(tilt) back(300) cuboid([210,100,200],anchor=TOP);
            tag("remove") attach(TOP,norot=1) zrot(tilt) fwd(300) cuboid([210,100,200],anchor=TOP);
            attach(RIGHT,norot=1) cyl(d=discd,h=200) 
                tag("remove") attach(BOT,norot=1) cyl(d=200,h=200,anchor=BOT);
            }
        }

    }
    attachable(anchor=anchor,spin=spin,orient=orient,size=[span+discd,discd,500])
    {
        left(span/2)
        vexmount1_();
        children();
    }
}

module test()
{
    diff()
    cuboid([2000,500,200])
    {
        intersect("mask") {
            attach(TOP,norot=1) zrot(10) left(105) cuboid([100,600,300],anchor=BOT+RIGHT)
            attach(RIGHT+BOT,norot=1) right(210) cuboid([100,600,300],anchor=BOT+LEFT);
            tag("mask") attach(TOP,norot=1) cuboid([1000,500,300],anchor=BOT);
        }
        tag("remove") attach(TOP,norot=1) zrot(10) back(300) cuboid([210,100,200],anchor=TOP);
        tag("remove") attach(TOP,norot=1) zrot(10) fwd(300) cuboid([210,100,200],anchor=TOP);
    }
}


module forPrinting()
{
//    sensorholder();
//    filmguides(span=1800,lift=200);
//    bearing_cap();
    vexmount1(span=1800);
//    vexmount0();
    
}

module forViewing()
{
    *test();
    *vexmount1(span=1800);
    vexmount0()
    attach(RIGHT)  down(100)
    zrot(10) vexmount1(orient=DOWN,spin=90,span=1800);
    *sensorholder();
    *filmguides();
    *sensorholder()
    attach(RIGHT,norot=1) left(445)
    filmguides(anchor=TOP,spin=90,orient=LEFT,span=1800,lift=200)
    {
//        attach(TOP) up(200) right(1000) bearing_cap(orient=DOWN);
    }

//    bearing_support();
    *ir_sensor_mount() {
        attach(BACK,norot=1) right(260) up(100) bearing_support(anchor=RIGHT,spin=-90,orient=LEFT);
        attach(FRONT,norot=1) left(50) ir_sensor_mount(anchor=BACK)
        attach(FRONT,norot=1) right(310) up(100) bearing_support(anchor=RIGHT,spin=90,orient=LEFT);
        if (model)
        right(50) up(520) recolor("red") xflip() model_film_super8(frames=5);
    }
    *if (model) {
        recolor("dimgray") up(100)
        model_ir_reflective_sensor();
    }
}

scale(ViewScale)
{
    forPrinting();
    *forViewing();
    *bearing_support();
    *filmguides();
    *ir_sensor_mount();
    *recolor("cornflowerblue")
    *up(100)
    *model_ir_reflective_sensor();
}
