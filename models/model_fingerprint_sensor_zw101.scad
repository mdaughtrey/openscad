model_fingerprint_sensor_zw101_r = 800;
model_fingerprint_sensor_zw101_z = 300;
//model_fingerprint_sensor_ = 1755;

module model_fingerprint_sensor_sfm_v17(anchor=CENTER,spin=0,orient=UP)
{
    module model_fingerprint_sensor_sfm_v17_()
    {
        cyl(d=748, h=130)
        {
            rot_copies(n=3) attach(LEFT, norot=1) cyl(d=100,h=130);
            attach(TOP, norot=1) cyl(d=826, h=48, anchor=BOT)
            attach(TOP, norot=1) cyl(d=750, h=71, anchor=BOT);
//            attach(BOT, norot=1) cuboid([236, 40, 40], anchor=TOP);
        }
    }
    attachable(anchor,spin,orient,d=model_fingerprint_sensor_zw101_r,
        h=model_fingerprint_sensor_zw101_z)
    {
        model_fingerprint_sensor_sfm_v17_();
        children();
    }
}
