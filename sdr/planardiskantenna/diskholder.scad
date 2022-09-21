ViewScale = [0.0254, 0.0254, 0.0254];
include <inner.dat>
include <outer.dat>

models=1;

module model_nut() 
{
    linear_extrude(300)
    circle(260, $fn=6);
}

module model_velcro_adhesive()
{
    linear_extrude(200)
    square([1200, 1200]);
}

module model_tripodhead()
{
    linear_extrude(750)
    circle(2260/2, $fn=96);
}

module model_disk()
{
    innershift = [for(ii=[len(inner)-1:-1:0]) [inner[ii].x,inner[ii].y+50]];
    rotate_extrude(angle=360, convexity=2, $fn=96) {
        polygon(points=concat(inner, innershift));
        translate([6858, 700, 0])
        circle(100/2, $fn=96);
    }
    translate([2500, -600, -100])
    model_velcro_adhesive();
    
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
                translate([-25, -100, 0])
                square([500, 250]);
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
        color("silver")
        translate([-200, 0, -500])
        model_disk();
    }

    module lowercircle(x,y)
    {
        intersection() {
            difference() {
                circle(13350/2+500, $fn=96);
                circle((13500/2)-500, $fn=96);
                // tripod mount
                translate([13500/2, 0, 0])
                circle(x/2, $fn=y);
            }
            translate([13500/2-1500, -2500, 0])
            square([2000, 5000]);

        }
    }
    // Lower circle
    translate([0, 0, -975])
    linear_extrude(25)
    lowercircle(280, 96);

    translate([0, 0, -951])
    linear_extrude(300)
    lowercircle(500, 6);

    // Upper circle
    *translate([0, 0, 275])
    linear_extrude(225)
    intersection() {
        difference() {
            circle(13350/2+500, $fn=96);
            circle((13500/2)-475, $fn=96);
        }
        translate([13500/2-1500, -2500, 0])
        square([2000, 5000]);

    }
}

module arm()
{
    rotate([0, 0, -15])
    rotate_extrude(angle = 30, convexity=2, $fn=96)
    translate([10350/2-3000, 0, 0])
    square([4000, 400]);

    translate([0, 0, 399])
    rotate([0, 0, -15])
    rotate_extrude(angle = 30, convexity=2, $fn=96)
    translate([10350/2-1800, 0, 0])
    square([2800, 101]);
}

module forViewing()
{
    upper();
    *translate([0, 0, -1000])
    color("lightblue")
    arm();
    
    rotate([0, 0, 180])
    translate([-13500, 0, 0]) {
        upper();
        *translate([0, 0, -1000])
        color("lightblue")
        arm();
    }

    if (models)
    {
        translate([13350/2, 0, -2000])
        color("lightgreen")
        model_tripodhead();
    }
}

module forPrinting()
{
    //arm();
}

scale(ViewScale)
{
//    model_disk();
    forViewing();
    forPrinting();
}
