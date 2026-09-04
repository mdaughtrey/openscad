ViewScale = [0.0254, 0.0254, 0.0254];
include <../../../BOSL2-master/std.scad>
include <joystick.scad>
$fn=96;

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
    joystick_outer_shaft();
    recolor("skyblue")
    joystick_inner_shaft();
    recolor("cornflowerblue")
    down(1100) 
    joystick_switch_base();
    down(900)
    recolor("ForestGreen")
    joystick_switch_upper();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
//     joystick_sphere_dia=1000;
//     joystick_halfball(inner_d=joystick_sphere_dia+30, outer_d=joystick_sphere_dia+100);
}
