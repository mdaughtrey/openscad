//ViewScale = [0.0254, 0.0254, 0.0254];

use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>
use <skin.scad>

module wiggleTube(len)
{
    wiggle=len/30;
    scaleMin=5;
    skin([for(ii=[0:20:len])
        transform(translation([(sin(ii/2))*wiggle, (cos(ii/2))*wiggle, ii])*
            scaling([max(scaleMin,abs(sin(ii)*2)),
            max(scaleMin,abs(1+sin(ii)*2)),
            max(scaleMin,abs(1+sin(ii)*2))]),
        circle(30, $fn=48))]);
}

//scale(ViewScale)
//{
//    tube(2000);
//}
