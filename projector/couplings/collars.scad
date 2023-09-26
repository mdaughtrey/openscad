module collar_inserter(anchor=CENTER,spin=0,orient=UP)
{
    attachable(anchor,spin,orient,size=[1500,1500,600]) {
        down(300)
        union() {
            rect_tube(h=500,size=1380,isize=1280,rounding=50)
            attach(TOP,overlap=1)
            rect_tube(h=100,size=1500,isize=1280,rounding=50,anchor=BOT);
        }
        children();
    }
}

module collar_acceptor(anchor=CENTER,spin=0,orient=UP)
{
    attachable(anchor,spin,orient,size=[1500,1500,600]) {
        up(50) rect_tube(h=500,size=1500,isize=1400,rounding=50,anchor=CENTER)
            attach(BOT,overlap=1) rect_tube(size=[1500,1500],isize=[500,300],h=100,rounding=50,anchor=BOT);
        children();
    }
}

