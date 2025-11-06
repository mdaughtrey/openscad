include <../../BOSL2-master/std.scad>

// Units = inches
// Two by Four
TBF_SHORT = 2;
TBF_LONG = 4;

// Garage Opening
GARAGE_OPENING_X = 120;
GARAGE_OPENING_Y = 3;
GARAGE_OPENING_Z = 84;

// Gaps
GDOOR_FRAME_GAP_SIDE = 1;
GDOOR_FRAME_GAP_TOP = 1;
GDOOR_FRAME_GAP_BOTTOM = 1;
GDOOR_FRAME_GAP_BETWEEN = 1;

// Door Width
GDOOR_X = (GARAGE_OPENING_X - (GDOOR_FRAME_GAP_SIDE*2) - GDOOR_FRAME_GAP_BETWEEN)/2;

module model_garage(anchor=CENTER,spin=0,orient=UP)
{
    module model_garage_()
    {
    }
    attachable(anchor,spin,orient,size=[10,10,10])
    {
        model_garage_();
        children();
    }
}

module right_door(anchor=CENTER,spin=0,orient=UP)
{
    module right_door_()
    {
    }
    attachable(anchor,spin,orient,size=[10,10,10])
    {
        right_door_();
        children();
    }
}

module door_frame(anchor=CENTER,spin=0,orient=UP, 
    width, height, long, short)
{
    module door_frame_()
    {
        cuboid([width, short, long], anchor=TOP)
        {
            position(LEFT+BACK+BOT) cuboid([long, short, height-(long*2)], anchor=LEFT+BACK+TOP);
            position(RIGHT+BACK+BOT) cuboid([long, short, height-(long*2)], anchor=RIGHT+BACK+TOP)
            {
                position(BACK+LEFT) cuboid([width-(short*2), short, long], anchor=RIGHT+BACK);
                position(BOT+BACK+RIGHT) cuboid([width, short, long], anchor=RIGHT+BACK+TOP);
            }
        }
    }
    attachable(anchor,spin,orient,size=[width, short, height])
    {
        up(height/2)
        door_frame_();
        children();
    }
}

module left_door0(anchor=CENTER,spin=0,orient=UP)
{
    door_height = GARAGE_OPENING_Z-1;
    trim_short = 0.25;
    trim_long = 6;
    module left_door_()
    {
        cuboid([GDOOR_X, TBF_SHORT, TBF_LONG])
        {
            position(LEFT+BACK+BOT) cuboid([TBF_LONG, TBF_SHORT, door_height-(TBF_LONG*2)], anchor=LEFT+BACK+TOP);
            position(RIGHT+BACK+BOT) cuboid([TBF_LONG, TBF_SHORT, door_height-(TBF_LONG*2)], anchor=RIGHT+BACK+TOP)
            {
                position(BACK+LEFT) cuboid([GDOOR_X-(TBF_SHORT*2), TBF_SHORT, TBF_LONG], anchor=RIGHT+BACK);
                position(BOT+BACK+RIGHT) cuboid([GDOOR_X, TBF_SHORT, TBF_LONG], anchor=RIGHT+BACK+TOP);
            }
            // Plywood
            recolor("brown")
            position(FRONT+TOP) cuboid([GDOOR_X, 0.5, door_height], anchor=BACK+TOP)
            // LP Cover
            recolor("purple")
            position(FRONT+TOP) cuboid([GDOOR_X, 0.25, door_height], anchor=BACK+TOP)
            // Trim
            recolor("black")
            position(FRONT+TOP)
            cuboid([GDOOR_X, trim_short, trim_long], anchor=BACK+TOP)
            {
                position(LEFT+BACK+BOT) cuboid([trim_long, trim_short, door_height-(trim_long*2)], anchor=LEFT+BACK+TOP);
                position(RIGHT+BACK+BOT) cuboid([trim_long, trim_short, door_height-(trim_long*2)], anchor=RIGHT+BACK+TOP)
                {
                    position(BACK+LEFT) cuboid([GDOOR_X-(trim_long*2), trim_short, trim_long], anchor=RIGHT+BACK);
                    position(BOT+BACK+RIGHT) cuboid([GDOOR_X, trim_short, trim_long], anchor=RIGHT+BACK+TOP);
                }
            }
        }
    }
    attachable(anchor,spin,orient,size=[GDOOR_X,TBF_SHORT,door_height])
    {
        up(door_height/2)
        left_door_();
        children();
    }
}

module left_door(anchor=CENTER,spin=0,orient=UP)
{
    door_height = GARAGE_OPENING_Z-1;
    trim_short = 0.25;
    trim_long = 6;
    module left_door_()
    {
        door_frame(width=GDOOR_X, height=GARAGE_OPENING_Z-1,short=TBF_SHORT,long=TBF_LONG)
        {
            // Plywood
            recolor("brown")
            position(FRONT+TOP) cuboid([GDOOR_X, 0.5, door_height], anchor=BACK+TOP)
            // LP Cover
            recolor("purple")
            position(FRONT+TOP) cuboid([GDOOR_X, 0.25, door_height], anchor=BACK+TOP)
            // Trim
            recolor("black")
            position(FRONT)
            door_frame(width=GDOOR_X, height=door_height, short=trim_short, long=trim_long);
//            cuboid([GDOOR_X, trim_short, trim_long], anchor=BACK+TOP)
//            {
//                position(LEFT+BACK+BOT) cuboid([trim_long, trim_short, door_height-(trim_long*2)], anchor=LEFT+BACK+TOP);
//                position(RIGHT+BACK+BOT) cuboid([trim_long, trim_short, door_height-(trim_long*2)], anchor=RIGHT+BACK+TOP)
//                {
//                    position(BACK+LEFT) cuboid([GDOOR_X-(trim_long*2), trim_short, trim_long], anchor=RIGHT+BACK);
//                    position(BOT+BACK+RIGHT) cuboid([GDOOR_X, trim_short, trim_long], anchor=RIGHT+BACK+TOP);
//                }
//            }
        }
    }
    attachable(anchor,spin,orient,size=[GDOOR_X,TBF_SHORT,door_height])
    {
        left_door_();
        children();
    }
}

module garage_frame(anchor=CENTER,spin=0,orient=UP)
{
    x = GARAGE_OPENING_X + 6;
    y = GARAGE_OPENING_Y;
    z = GARAGE_OPENING_Z + 6;
    module garage_frame_()
    {
        rmtag = "vawdfa";
        diff(rmtag)
        {
            cuboid([x, y, z]);
            tag(rmtag)
            position(BOT+BACK) back(1) down(1) cuboid([GARAGE_OPENING_X, GARAGE_OPENING_Y+2, GARAGE_OPENING_Z+1], anchor=BOT+BACK);
        }

    }
    attachable(anchor,spin,orient,size=[x, y, z])
    {
        garage_frame_();
        children();
    }
}

module all()
{
}

module forViewing()
{
    garage_frame();
}

module forPrinting()
{
    
}

module all()
{
}

module forViewing()
{
//    garage_frame();
    left_door();
//    door_frame(width=GDOOR_X, height=GARAGE_OPENING_Z-1,short=TBF_SHORT,long=TBF_LONG);
}

module forPrinting()
{
}

forViewing();
