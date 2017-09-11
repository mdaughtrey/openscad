include <defs.scad>
RealityScale = 1.27;
ViewScale=[.02*RealityScale,.02*RealityScale,.02*RealityScale];

scale(ViewScale)
{
    cube([1000, 1000, 1000]);
}
