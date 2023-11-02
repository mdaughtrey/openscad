ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>

module tab_cutout(radius, anchor=CENTER,spin=0,orient=UP)
{
    attachable(anchor,spin,orient,size=[adj_ang_to_opp(radius,27),radius,300]) {
        union() {
            opp=adj_ang_to_opp(radius,11);
            move = sqrt(sqr(radius)-sqr(opp/2)); 
            fwd(move) xrot(-90) yrot(-11/2) wedge([300,opp,radius],spin=90,anchor=BOT);

            opp0=adj_ang_to_opp(radius,5);
            move0 = sqrt(sqr(radius)-sqr(opp0/2));
            zrot(11/2+5/2) fwd(move0) down(40) xrot(-90) yrot(-5/2) wedge([220,opp0,radius],spin=90,anchor=BOT);

            opp1=adj_ang_to_opp(radius,11);
            move1 = sqrt(sqr(radius)-sqr(opp1/2));
            zrot(11/2+5/2+11/2) fwd(move1) down(25) xrot(-90) yrot(-11/2) wedge([250,opp1,radius],spin=90,anchor=BOT);
        }
        children();
    }
}

module tabsin(od=1460,id=1360,numtabs=4,anchor=CENTER,spin=0,orient=UP)
{
    $fn=96;
    attachable(anchor,spin,orient,d=od,l=200) {
        union() {
            tube(od=od,id=id,h=200) {
                attach(TOP) down(100) tube(od=id+5,id=id-95,h=50,anchor=TOP);
                attach(TOP,BOT,overlap=1)
                zrot(-8.5)

                diff() {
                    tube(od=od,id=id,h=300,anchor=BOT);
                    tag("remove") zrot_copies(n=numtabs) tab_cutout(200+od/2,anchor=BOT);
                    tag("keep") tube(od=od,id=od-20,h=300);
                }
            }
        }
        children();
    }
}

module tabsin0(od=1460,id=1360,numtabs=4)
{
    $fn=96;
    difference() { tube(od=od,id=id,h=220); zrot_copies(n=numtabs) pie_slice(h=221,ang=26,r=200+od/2,anchor=CENTER); } 
    up(120) difference() {
        #tube(od=od,id=id,h=30,anchor=BOT);
        zrot(15) zrot_copies(n=numtabs) down(1) pie_slice(h=32,ang=11,r=200+od/2,anchor=BOT); 
        zrot_copies(n=numtabs) down(1) pie_slice(h=32,ang=11,r=200+od/2,anchor=BOT);
        }
//    up(120) difference() { #tube(od=od,id=id,h=80,anchor=BOT); zrot_copies(n=numtabs) down(1) pie_slice(h=82,ang=11,r=200+od/2,anchor=BOT); }
//    up(110) difference() { tube(od=od,id=id,h=30); zrot_copies(n=numtabs) pie_slice(h=81,ang=11,r=200+od/2,anchor=CENTER); }
}

module tabsout(od=1340,id=1240,numtabs=4,spin=0,anchor=CENTER,orient=UP)
{
    $fn=96;
    attachable(anchor,spin,orient,d=od,l=800) {
        union() {
            // Springy bits
            springh=200;
            tube(od=od,id=id,h=50)
            attach(TOP,BOT) zrot_copies(n=numtabs)
            intersect("mask") {
                yrot(15)  tube(od=od,id=id,h=30);
                tag("mask") fwd(200) cuboid([600,od,springh]);
            }
            up(springh-100) {
                tube(od=od,id=id,h=300,anchor=BOT);
                intersect("mask") {
                    zrot_copies(n=numtabs) pie_slice(h=200,ang=10,r=90+od/2);
                    tag("mask") tube(od=90+od,id=id,h=200,anchor=BOT);
                }
            }
        }
        children();
    }
}


//module forViewing()
//{
////    right(1500) tabsin();
//    tabsin();
//    recolor("cyan") up(150) tabsout();
////tab_cutout(11,200,1000);
//}
//
//module forPrinting()
//{
//    left(800) tabsin();
//    right(800) tabsout();
//}
//
//scale(ViewScale)
//{
//    forViewing();
////    forPrinting();
//}
