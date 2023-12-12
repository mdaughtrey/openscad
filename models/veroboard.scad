module model_veroboard(anchor=CENTER,spin=0,orient=UP, holesX=10, holesY=10)
{
    module model_veroboard_() {
        color("darkgoldenrod")
        diff()
        cuboid([100*holesX,100*holesY,50])
        tag("remove") 
        grid_copies(n=[holesX,holesY],spacing=100)
        cyl(d=30,h=55);
    }
    attachable(anchor,spin,orient,size=[100*holesX,100*holesY,50])
    {
        model_veroboard_();
        children();
    }
}
