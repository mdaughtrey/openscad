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


module bearing_cap608(anchor=CENTER,spin=0,orient=UP,offset=0) 
{
    $fn=96;
    module bearing_cap608_()
    {
        diff()
        cyl(d=discd,h=100) {
            tag("remove") right(offset) attach(BOT,norot=1) cyl(d=200,h=300,anchor=BOT);
            attach(TOP,norot=1) cyl(d=500,h=mm(0.7),anchor=BOT)
            attach(TOP,norot=1) cyl(d=mm(7.5),h=mm(3),anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,d=discd,l=100+mm(3.7))
    {
        bearing_cap608_();
        children();
    }
}

module bearing_cap6001(anchor=CENTER,spin=0,orient=UP) 
{
    $fn=96;
    module bearing_cap6001_()
    {
        diff()
        cyl(d=discd+200,h=100) {
            tag("remove") attach(BOT,norot=1) cyl(d=200,h=300,anchor=BOT);
            attach(TOP,norot=1) cyl(d=650,h=mm(0.7),anchor=BOT)
            attach(TOP,norot=1) cyl(d=mm(7.5),h=mm(3),anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,d=discd,l=100+mm(3.7))
    {
        bearing_cap6001_();
        children();
    }
}

module onebearing608(anchor=CENTER,spin=0,orient=UP,lift=1,offset=0)
{
    $fn=96;
    discd = discd -50;
    module onebearing_()
    {
        diff()
        cyl(d=discd,h=100) {
            tag("remove") right(offset) attach(BOT,norot=1) cyl(d=200,h=300+lift,anchor=BOT);
            attach(TOP,norot=1) cyl(d=discd,h=lift,anchor=BOT)
            attach(TOP,norot=1) cyl(d=500,h=mm(0.7),anchor=BOT) {
                if (model)
                {
                    recolor("dimgray")
                    attach(TOP,norot=1) scale([1/25.4,1/25.4,1/25.4]*1000) ball_bearing("608ZZ",anchor=BOT);
                }
                attach(TOP,norot=1) cyl(d=mm(7.5),h=mm(3),anchor=BOT);
            }
        }
    }
    attachable(anchor,spin,orient,r=discd,h=100+lift+mm(0.7)+mm(3))
    {
        down((100+lift+mm(0.7)+mm(3))/2-50)
        onebearing_();
        children();
    }
}

module onebearing6001(anchor=CENTER,spin=0,orient=UP,lift=1,discd=1100)
{
    $fn=96;
    module onebearing_()
    {
        diff()
        cyl(d=discd,h=100) {
            tag("remove") attach(BOT,norot=1) cyl(d=200,h=300+lift,anchor=BOT);
            attach(TOP,norot=1) cyl(d=discd,h=lift,anchor=BOT)
            attach(TOP,norot=1) cyl(d=650,h=mm(0.7),anchor=BOT) {
                if (model)
                    attach(TOP,norot=1) scale([1/25.4,1/25.4,1/25.4]*1000) ball_bearing("6001",anchor=BOT);
                attach(TOP,norot=1) cyl(d=mm(11),h=mm(3),anchor=BOT);
            }
        }
    }
    attachable(anchor,spin,orient,r=discd,h=100+lift+mm(0.7)+mm(3))
    {
        down((100+lift+mm(0.7)+mm(3))/2-50)
        onebearing_();
        children();
    }
}

module filmguides(anchor=CENTER,spin=0,orient=UP,span=2000,lift=1)
{
    $fn=96;
    //onebearing608(lift=lift)
    diff()
    cyl(d=discd,h=100) {
        tag("remove") attach(BOT,norot=1) cyl(d=200,h=100,anchor=BOT);
        if (model)
        {
            recolor("cornflowerblue")
            attach(TOP,norot=1) left(50) onebearing608(lift=100,offset=50,anchor=BOT)
            attach(TOP,norot=1) left(50) up(360) recolor("yellowgreen") onebearing608(offset=50,orient=DOWN,anchor=BOT);
            //attach(TOP,norot=1) left(50) up(360) recolor("yellowgreen") bearing_cap608(offset=50,orient=DOWN,anchor=BOT);
        }
        attach(BOT,norot=1) cuboid([span,500,100],anchor=BOT+LEFT) {
            tag("remove") attach(LEFT+BOT,norot=1) cyl(d=200,h=301+lift,anchor=BOT);
            tag("remove") attach(RIGHT+BOT,norot=1) cyl(d=200,h=301+lift,anchor=BOT);
            attach(RIGHT+BOT,norot=1) cyl(d=discd,h=100,anchor=BOT) {
                if (model)
                {
                    recolor("cornflowerblue")
                    attach(TOP,norot=1) left(50) onebearing608(lift=100,offset=50,anchor=BOT)
                    attach(TOP,norot=1) left(50) up(360) recolor("yellowgreen") bearing_cap608(offset=50,orient=DOWN,anchor=BOT);
                }
                attach(BOT,norot=1) zrot(-45) cuboid([discd+300,500,100],anchor=BOT+LEFT) 
                {
                    tag("remove") attach(LEFT+BOT,norot=1) cyl(d=200,h=301+lift,anchor=BOT);
                    tag("remove") attach(RIGHT+BOT,norot=1) cyl(d=200,h=301+lift,anchor=BOT);
                    attach(RIGHT+BOT,norot=1) onebearing6001(lift=lift-10,discd=discd+200,anchor=BOT);
                }
            }
        }
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
//    bearing_cap6001();
    onebearing608(offset=45);
//    vexmount1(span=1800);
//    vexmount0();
    
}

module forViewing()
{
    filmguides(span=1800,lift=200);
    right(800) up(800) sensorholder(orient=BACK,spin=90);
    //bearing_cap608(lift=100,offset=50);
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
