ViewScale = [0.0254, 0.0254, 0.0254];
include <inner.dat>
include <outer.dat>

models=1;

module model_nut() 
{
    linear_extrude(300)
    circle(260, $fn=6);
}

module model_disk()
{
    getcol = function(arr, col) [for(ii=[0:len(arr)-1]) [arr[ii][col]]];
//    rotate_extrude(angle = 15, convexity=2, $fn=96)
//    revouter = [for(ii=[len(outer)-1:-1:0]) [outer[ii].x,outer[ii].y]];
    echo ("last is ", outer[len(outer)-1][0]);
    translate([13500/2-outer[len(outer)-1][0], 0, 0])
    polygon(points=outer);
    //scale([-1.0, 1.0, 1.0]) polygon(points=outer);
    //polygon(points=concat(inner, outer));
    //xshift = [for(ii=[len(inner)-1:-1:0]) [inner[ii].x-100,inner[ii].y+100]];
}

module upper()
{
    module template(r) {
        rotate([0, 0, r])
        rotate_extrude(angle = 15, convexity=2, $fn=96)
        translate([(13500/2)-350-125, 0, 0]) {
            difference() {
                square([900, 500]);
                translate([350, 150]) 
                circle(250/2, $fn=96);
                translate([225, -100, 0])
                square([250, 250]);
            }
            // Spine
            translate([474, -475, 0])
            square([426, 476]);
            // Chin
            translate([-1100, -975, 0])
            square([2000, 500]);

            translate([100, -600, 0])
            polygon(points=[[0, 0], [500, 0], [500, 500]]);

        }
    }
    template(15); 
    template(-30);
    if (models) {
        color("red")
        translate([0, 0, -200])
        linear_extrude(100)
        circle(13500/2, $fn=96);
    }

    // Lower circle
    translate([0, 0, -975])
    linear_extrude(225)
    intersection() {
        difference() {
            circle(13500/2+500, $fn=96);
            circle((13500/2)-500, $fn=96);
            translate([13500/2, 0, 0])
            circle(280/2, $fn=96);
        }
        translate([13500/2-1500, -2500, 0])
        square([2000, 5000]);

    }

    // Upper circle
    translate([0, 0, 275])
    linear_extrude(225)
    intersection() {
        difference() {
            circle(13500/2+500, $fn=96);
            circle((13500/2)-475, $fn=96);
        }
        translate([13500/2-1500, -2500, 0])
        square([2000, 5000]);

    }

}

module forViewing()
{
    upper();
    rotate([0, 0, 180])
    translate([-13550, 0, 0])
    upper();

    // Nut holder
    translate([13500/2, 0, -740])
    linear_extrude(270)
    difference() {
        circle(500/2, $fn=6);
        circle(280/2, $fn=6);
    }

    *translate([13500/2-2000, -2500, -975])
    linear_extrude(500)
    difference() {
        square([4000, 5000]);
        translate([500, 500, 0])
        square([3000, 4000]);
    }

    *translate([13500/2-500, -2500, 200])
    linear_extrude(300)
    square([1000, 5000]);
}

module forPrinting()
{
}

scale(ViewScale)
{
    model_disk();
//    forViewing();
}
