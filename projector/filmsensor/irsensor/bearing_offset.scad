ViewScale = [0.0254, 0.0254, 0.0254];
include <../../../BOSL2-master/std.scad>
include <../../../BOSL2-master/ball_bearings.scad>

model = 1;
mm = function(tomill) tomill/25.4*1000;
discd=1100;

module bearing_cap608(anchor=CENTER,spin=0,orient=UP) 
{
    $fn=96;
    module bearing_cap608_()
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
        bearing_cap608_();
        children();
    }
}

module onebearing608(anchor=CENTER,spin=0,orient=UP,lift=1)
{
    $fn=96;
    module onebearing_()
    {
        diff()
        cyl(d=discd,h=100) {
            tag("remove") attach(BOT,norot=1) right(50) #cyl(d=180,h=300+lift,anchor=BOT);
            attach(TOP,norot=1) cyl(d=discd,h=lift,anchor=BOT)
            attach(TOP,norot=1) cyl(d=500,h=mm(0.7),anchor=BOT) {
                if (model)
                     attach(TOP,norot=1) scale([1/25.4,1/25.4,1/25.4]*1000) ball_bearing("608ZZ",anchor=BOT);
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

module forViewing()
{
    onebearing608();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
