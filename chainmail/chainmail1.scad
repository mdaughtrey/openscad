ViewScale = [0.0254, 0.0254, 0.0254];

module full_link0(width, depth, height, thick, gap, bevel)
{
    module layer(width, depth, height, thick, gap) {
        linear_extrude(thick) 
        square([thick, width], center=true);
        linear_extrude(thick - gap/2) {
            translate([0, depth/2 - thick/2, 0])
            square([width, thick], center=true);
            translate([0, -depth/2 + thick/2, 0])
            square([width, thick], center=true);
        }
    }
    layer(width, depth, height, thick, gap);
    translate([0, 0, thick*2-1])
    rotate([180, 0, 90])
    layer(width, depth, height, thick, gap);

    for (ii=[1,-1]) {
        for (jj=[1,-1]) {
            linear_extrude(thick*2-1)
            translate([(width/2-thick/2)*ii, (depth/2-thick/2)*jj, 0])
            square([thick, thick], center=true);
        }
    }
}

module link_trim(width, depth, height, thick, bevel)
{
    height = thick*2;

    module one() {
        translate([-width/2, depth/2, 0])
        rotate([90, 0, 0])
        linear_extrude(depth)
        polygon(points=[[bevel,0],[width-bevel,0],[width,bevel],[width,height-bevel],
            [width-bevel,height],[bevel,height],[0,height-bevel],[0,bevel]]);
    }

    intersection() {
        one();
        rotate([0, 0, 90])
        one();
    }
}

module full_link(width, depth, height, thick, gap, bevel)
{
    module layer(width, depth, height, thick, gap, bevel) {
        a=width/2 - thick*1.5;
        module cutout(length, thick, bevel)
        {
//            translate([length/2-a/2, thick/2+50, thick-bevel])
            rotate([90, 0, 0])
            linear_extrude(thick+100)
            polygon(points=[[bevel,0],[a-bevel,0],[a,bevel],[a,thick-bevel],
                [a-bevel,thick],[bevel,thick],[0,thick-bevel],[0,bevel]]);
        }
        module bevel_rod(length,thick,bevel)
        {
            difference() {
                translate([-length/2, -thick/2, thick]) 
                rotate([0, 90, 0])
                linear_extrude(length)
                polygon(points=[[bevel,0],[thick-bevel,0],[thick,bevel],[thick,thick-bevel],
                    [thick-bevel,thick],[bevel,thick],[0,thick-bevel],[0,bevel]]);

                translate([-a/2+length/4-thick/4, thick/2+50, thick-bevel])
                cutout(a, thick, bevel);

                translate([-a/2-length/4+thick/4, thick/2+50, thick-bevel])
                cutout(a, thick, bevel);
            }
        }
        bevel_rod(width, thick, bevel);
        translate([0, depth/2 - thick/2, 0])
        bevel_rod(width, thick, bevel);
        translate([0, -depth/2 + thick/2, 0])
        bevel_rod(width, thick, bevel);
    }

    layer(width, depth, height, thick, gap, bevel);
    translate([0, 0, thick*2-1])
    rotate([180, 0, 90])
    layer(width, depth, height, thick, gap, bevel);
}

module links(x, y)
{
    //w=1000; d=1000; h=500; t=100; g=20;
    w=600; d=600; h=500; t=100; g=20; b=25;

    for (xx=[0:x-1]) {
        for (yy=[0:y-1]) {
            translate([(t+g*2+w)*xx, (t+g*2+d)*yy, 0])
            intersection() {
                full_link(w,d,h,t,g,b);
                link_trim(w,d,h,t,b);
            }
        }
    }

    for (xx=[0:x-2]) {
        for (yy=[0:y-2]) {
            translate([w/2+t/2+g+(t+g*2+w)*xx, d/2+t/2+g+(t+g*2+d)*yy, 0])
            intersection() {
                full_link(w,d,h,t,g,b);
                link_trim(w,d,h,t,b);
            }
        }
    }


    *translate([w/2+t, d/2+t, 0])
    rotate([0, 0, 90])
    full_link(w,d,h,t,g);
}

module forViewing()
{
    links(5,5);
//    w=600; d=600; h=500; t=100; g=20; b=30;
//    intersection() {
//        full_link(w,d,h,t,g,b);
//        link_trim(w,d,h,t,b);
//    }
}

module forPrinting()
{
    links(5, 5);
}

scale(ViewScale)
{
    forViewing();
}
