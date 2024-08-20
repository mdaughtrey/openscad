model_fingerprint_sensor_as608X = 800;
model_fingerprint_sensor_as608Y = 920;
model_fingerprint_sensor_as608Z = 1755;

module model_fingerprint_sensor_as608(anchor=CENTER,spin=0,orient=UP)
{
    module model_fingerprint_sensor_as608_()
    {
        edges = [FRONT+LEFT, FRONT+RIGHT];
        cuboid([800,920,760], rounding=50, edges=edges)
        attach(TOP, norot=1)
        cuboid([660,920,95], rounding=50, edges=edges, anchor=BOT)
        attach(TOP, norot=1)
        cuboid([800,920,350], rounding=50, edges=edges,anchor=BOT)
        attach(TOP+FRONT, norot=1)
        diff()
        prismoid(size1=[800, 820], size2=[800,0], shift=[0,820/2], h=550, anchor=BOT+FRONT)
        {
            attach(BACK, norot=1)
            cuboid([800,100,550],anchor=FRONT);
            attach(FRONT) tag("remove") up(1)
            cuboid([615,780,20],anchor=TOP);
        }
    }
    attachable(anchor,spin,orient,size=[model_fingerprint_sensor_as608X,
        model_fingerprint_sensor_as608Y, model_fingerprint_sensor_as608Z])
    {
        up(760/2)
        model_fingerprint_sensor_as608_();
        children();
    }
}
