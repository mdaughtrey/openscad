ViewScale = [0.0254, 0.0254, 0.0254];

use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>
use <skin.scad>

fn=32;
$fn=60;

r1 = 25;
r2 = 10;
R = 40;
th = 2;

module tube()
{
//    difference()
//    {
        skin([for(i=[0:fn]) 
                transform(rotation([0,180/fn*i,0])*translation([-R,0,0]), 
                    circle(r1+(r1-r2)/fn*i)) ]);
            //r1 = r1-th;
            //r2 = r2-th;
//            assign(r1 = r1-th, r2 = r2-th)
//            skin([for(i=[0:fn]) 
//                    transform(rotation([0,180/fn*i,0])*translation([-R,0,0]), 
//                        circle(r1+(r1-r2)/fn*i))]);
//    }
}

module tube2(len)
{
    wiggle=len/10;
    scaleMin=5;
    skin([for(ii=[0:len])
        transform(translation([(sin(ii))*wiggle, (cos(ii))*wiggle, ii])*
            scaling([max(scaleMin,abs(sin(ii)*2)),
            max(scaleMin,abs(1+sin(ii)*2)),
            max(scaleMin,abs(1+sin(ii)*2))]),
        circle(20, $fn=96))]);
}

module test()
{
    for(ii=[0:5:900]) {
        echo(abs(sin(ii), abs(sin(ii))));
    }
}

scale(ViewScale)
{
tube2(1000);
//test();
}
