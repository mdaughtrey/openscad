ViewScale = [0.0254, 0.0254, 0.0254];
include <../../../BOSL2-master/std.scad>
include <joystick.scad>
$fn=96;

models=1;

//module model_tv(anchor=CENTER,spin=0,orient=UP)
//{
//    module model_tv_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        model_tv_();
//        children();
//    }
//}
//
//module model_key(anchor=CENTER,spin=0,orient=UP)
//{
//    module model_key_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        model_key_();
//        children();
//    }
//}
//
//module key_support(anchor=CENTER,spin=0,orient=UP)
//{
//    module key_support_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        key_support_();
//        children();
//    }
//}
//
//module button_body(anchor=CENTER,spin=0,orient=UP)
//{
//    module button_body_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        button_body_();
//        children();
//    }
//}
//
//module fascia(anchor=CENTER,spin=0,orient=UP)
//{
//    module fascia_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        fascia_();
//        children();
//    }
//}
//
//module enclosure(anchor=CENTER,spin=0,orient=UP)
//{
//    module enclosure_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        enclosure_();
//        children();
//    }
//}
//
//module button_play_pause(anchor=CENTER,spin=0,orient=UP)
//{
//    module button_play_pause_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        button_play_pause_();
//        children();
//    }
//}
//
//module button_back(anchor=CENTER,spin=0,orient=UP)
//{
//    module button_back_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        button_back_();
//        children();
//    }
//}
//
//module button_next(anchor=CENTER,spin=0,orient=UP)
//{
//    module button_next_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        button_next_();
//        children();
//    }
//}
//
//module button_up(anchor=CENTER,spin=0,orient=UP)
//{
//    module button_up_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        button_up_();
//        children();
//    }
//}
//
//module button_down(anchor=CENTER,spin=0,orient=UP)
//{
//    module button_down_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        button_down_();
//        children();
//    }
//}
//
//module button_input1(anchor=CENTER,spin=0,orient=UP)
//{
//    module button_input1_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        button_input1_();
//        children();
//    }
//}
//
//module button_input2(anchor=CENTER,spin=0,orient=UP)
//{
//    module button_input2_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        button_input2_();
//        children();
//    }
//}
//
//module button_onoff(anchor=CENTER,spin=0,orient=UP)
//{
//    module button_onoff_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        button_onoff_();
//        children();
//    }
//}
//
//module mount(anchor=CENTER,spin=0,orient=UP)
//{
//    module mount_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        mount_();
//        children();
//    }
//}
//
//module back_cover(anchor=CENTER,spin=0,orient=UP)
//{
//    module back_cover_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        back_cover_();
//        children();
//    }
//}
//
//module board_mounts(anchor=CENTER,spin=0,orient=UP)
//{
//    module board_mounts_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        board_mounts_();
//        children();
//    }
//}


module case()
{
}


module forViewing()
{
    *down(300)
    joystick_outer_shaft();

    *recolor("skyblue")
    up(290-300-135)
    joystick_inner_shaft();

    recolor("cornflowerblue")
    down(890) 
    joystick_sliding_plate();

    down(740)
    recolor("ForestGreen")
    joystick_switch_upper();

    *recolor("tan")
    up(90)
    joystick_upper_trap(orient=DOWN);

    *recolor("SeaGreen")
    down(1490)
    joystick_switch_lower();

    *recolor("Crimson")
    up(1000)
    joystick_knob_inner();

    *recolor("Crimson")
    up(1480)
    joystick_knob_button_mount();
}

module forPrinting()
{
//    joystick_outer_shaft();
//    joystick_inner_shaft();
    joystick_upper_trap();
//  joystick_knob_inner();
//    joystick_sliding_plate();
//    joystick_switch_lower();
//   joystick_switch_upper();
}

scale(ViewScale)
{
    forPrinting();
//    forViewing();
//    button_and_mount();
//    joystick_switch_upper();
}
