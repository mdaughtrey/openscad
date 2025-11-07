include <../../BOSL2-master/std.scad>

// Units = inches
// Two by Four
TBF_SHORT = 2;
TBF_LONG = 4;

// Garage Opening
GARAGE_OPENING_X = 96;
GARAGE_OPENING_Y = 3;
GARAGE_OPENING_Z = 84;

// Gaps
GDOOR_FRAME_GAP_SIDE = 0.5;
GDOOR_FRAME_GAP_TOP = 0.5;
GDOOR_FRAME_GAP_BOTTOM = 1;
GDOOR_FRAME_GAP_BETWEEN = 0.5;
DOOR_HEIGHT = GARAGE_OPENING_Z-GDOOR_FRAME_GAP_TOP-GDOOR_FRAME_GAP_BOTTOM;

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
                position(BACK+LEFT) cuboid([width-(long*2), short, long], anchor=RIGHT+BACK);
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

module door(anchor=CENTER,spin=0,orient=UP,bevel=0)
{
    trim_short = 0.25;
    trim_long = 6;
    module door_()
    {
        rmtag = "v2q3rc";
        diff(rmtag)
        door_frame(width=GDOOR_X, height=DOOR_HEIGHT-4,short=TBF_SHORT,long=TBF_LONG)
        {
            if (bevel == LEFT)
            {
                tag(rmtag) position(TOP+LEFT) zrot(-45) cuboid([TBF_SHORT/2,TBF_SHORT*2,DOOR_HEIGHT-3.9], anchor=TOP+RIGHT);
            }
            if (bevel == RIGHT)
            {
                tag(rmtag) position(TOP+RIGHT) zrot(45) cuboid([TBF_SHORT/2,TBF_SHORT*2,DOOR_HEIGHT-3.9], anchor=TOP+LEFT);
            }
            // Plywood
            recolor("brown")
            position(FRONT+TOP) cuboid([GDOOR_X, 0.5, DOOR_HEIGHT], anchor=BACK+TOP)
            // LP Cover
            recolor("purple")
            position(FRONT+TOP) cuboid([GDOOR_X, 0.25, DOOR_HEIGHT], anchor=BACK+TOP)
            // Trim
            recolor("black")
            position(FRONT)
            door_frame(width=GDOOR_X, height=DOOR_HEIGHT, short=trim_short, long=trim_long);
        }
    }
    attachable(anchor,spin,orient,size=[GDOOR_X,TBF_SHORT,DOOR_HEIGHT])
    {
        door_();
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

module forPrinting()
{
    
}

module all()
{
}

module forViewing()
{
    garage_frame()
    {
        up(2) position(TOP+LEFT+FRONT) right(3+GDOOR_FRAME_GAP_SIDE) down(6+GDOOR_FRAME_GAP_TOP) door(anchor=TOP+LEFT+FRONT, bevel=RIGHT);
        up(2) position(TOP+RIGHT+FRONT) left(3+GDOOR_FRAME_GAP_SIDE) down(6+GDOOR_FRAME_GAP_TOP) door(anchor=TOP+RIGHT+FRONT, bevel=LEFT);
    }
//    left_door();
//    door_frame(width=GDOOR_X, height=GARAGE_OPENING_Z-1,short=TBF_SHORT,long=TBF_LONG);
}

module forPrinting()
{
}

forViewing();
