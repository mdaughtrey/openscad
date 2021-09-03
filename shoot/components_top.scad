include <components10.scad>
include <components11.scad>
include <components12.scad>
include <components13.scad>
include <components14.scad>
include <components15.scad>
include <components16.scad>
include <components17.scad>
include <components18.scad>
include <components19.scad>
include <components20.scad>
include <components21.scad>
include <components22.scad>
include <components23.scad>

module plot_components(size, coords)
{
    translate([0, 0, 0]) linear_extrude(100)
    {
        for (ii = coords)
        {
            hull() {
                translate([ii[0]-1970/2,ii[1]-3940/2,0])
                square(size, center=true);
                translate([ii[2]-1970/2,ii[3]-3940/2,0])
                square(size, center=true);
            }
        }
    }
}

module components_top()
{
    plot_components(d10()[0], d10()[1]);
    plot_components(d11()[0], d11()[1]);
    plot_components(d12()[0], d12()[1]);
//    d13(); // chips
    plot_components(d14()[0], d14()[1]);
    plot_components(d15()[0], d15()[1]);

    d16();
    plot_components(d17()[0], d17()[1]); // LEDs
    plot_components(d18()[0], d18()[1]); 
    plot_components(d19()[0], d19()[1]);
    //
    //plot_components(d20()[0], d20()[1]);
    *linear_extrude(100)
    d21();
    //
    //linear_extrude(100)
    //d22();
    d23();
}
