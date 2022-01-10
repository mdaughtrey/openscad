ViewScale = [0.0254, 0.0254, 0.0254];

clearance = 20;
nutdiameter = 750 + clearance;

function mycircle(r, p) = [ for (a = [0:1:359]) [ (r+p[a]) * cos(a),  (r+p[a]) * sin(a)] ];
function sinewave(r, s) = [ for (a = [0:s:360*s-1]) r * sin(a)];

module lowerwrench()
{
    linear_extrude(400)
    difference()
    {
        polygon(mycircle(nutdiameter/2 + 100, sinewave(20,50)));
        circle(nutdiameter/2, $fn=6);
    }
}

module upperwrench()
{
    linear_extrude(200)
    {
        difference()
        {
            circle(nutdiameter/2+200, $fn=96);
            circle(nutdiameter/2, $fn=6);
            translate([-332, 0, 0])
            square([664, 664], center=true);
        }
        translate([1400, 0, 0])
        square([2000, nutdiameter/2], center=true);
    }
}

module forViewing()
{
    lowerwrench();
    upperwrench();
}

module forPrinting()
{

    translate([-600, 0, 0])
    lowerwrench();
    translate([600, 0, 0])
    upperwrench();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
