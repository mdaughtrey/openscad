ViewScale = [0.0254, 0.0254, 0.0254];

module io()
{
    translate([0, (1181/2)-138, 56])
    linear_extrude(100)
    square([2008,197], center=true);
}

module caps()
{
    xs=2560;
    ys=1190;
    
    // big caps
    rad=250/2;
    for(xx=[[1036,10],[1036,270]])
    {
        translate([-xs/2+xx[0]+rad, -ys/2+xx[1]+rad, 0])
        linear_extrude(300)
        circle(rad, $fn=96);
    }

    // small caps
    rad2=157/2;
    for(xx=[[384,309],[384,487],[1020, 570],[1350,0],[1670,0],[1870,220],[1870,400],[1870,580]])
    {
        translate([-xs/2+xx[0]+rad2, -ys/2+xx[1]+rad2, 0])
        linear_extrude(220)
        circle(rad2, $fn=96);
    }
}


module pcb()
{
    linear_extrude(56)
    difference()
    {
        union()
        {
            xpos=(2560/2)-118;
            ypos=(1181/2)-118;
            translate([xpos, ypos,0])
            circle(118, $fn=96);
            translate([-xpos, ypos,0])
            circle(118, $fn=96);
            translate([xpos, -ypos,0])
            circle(118, $fn=96);
            translate([-xpos, -ypos,,0])
            circle(118, $fn=96);
            square([2560,1181-236], center=true);
            square([2560-236,1181], center=true);
        }
        xpos=(2560/2)-138;
        ypos=(1181/2)-138;
        translate([xpos, ypos, 0])
        circle(98/2, $fn=96);
        translate([-xpos, ypos, 0])
        circle(98/2, $fn=96);
        translate([xpos, -ypos, 0])
        circle(98/2, $fn=96);
        translate([-xpos, -ypos, 0])
        circle(98/2, $fn=96);
    }
}

module jack()
{
    xs=2560;
    ys=1190;
    
    for(xx=[[150,300],[2310,310]])
    {
        translate([-xs/2+100/2+xx[0], -ys/2+300/2+xx[1], 0])
        linear_extrude(400)
        square([100, 300], center=true);
    }

    translate([-xs/2+300/2+210, -ys/2+100/2+100, 0])
    linear_extrude(400)
    square([300, 100], center=true);
}

module pins()
{
    linear_extrude(200)
    square([100, 300], center=true);
}


module pizerow()
{
    xs=2560;
    ys=1190;

    color("cyan")
    pcb();

    color("CornflowerBlue")
    translate([0, 0, 55])
    {
        io();
        caps();
        jack();
        pins();
        // microphone
        translate([-xs/2+300/2+2030, -ys/2+300/2, 0])
        linear_extrude(200)
        circle(300/2, $fn=96);
        // crystal
        translate([-xs/2+440/2+1420, -ys/2+180/2+350, -135-55])
        linear_extrude(135)
        square([440, 180], center=true);
    }
}

scale(ViewScale)
{
    pizerow();
}
