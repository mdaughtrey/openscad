module model_aviation_connector_3pin()
{
    module base(h=357) {
        intersection() {
            cyl(r=458/2,h,$fn=96);
            cuboid([423,1000,h]);
        }
    }
    union() {
        base(357);
        rot_copies(n=3) down(186) xmove(75) cyl(r=30,h=186,$fn=96,anchor=TOP);
        up(357/2+71/2) cyl(r=583/2,h=71,$fn=96) {
            attach(TOP) base(197);
            position(BOT) cyl(r=663/2,h=137,$fn=6,anchor=TOP);
        }
    }
}
