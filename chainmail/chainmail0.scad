ViewScale = [0.0254, 0.0254, 0.0254];

module full_link(width, depth, height, thick, gap)
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

module links(x, y)
{
    //w=1000; d=1000; h=500; t=100; g=20;
    w=600; d=600; h=500; t=100; g=20;

    for (xx=[0:x-1]) {
        for (yy=[0:y-1]) {
            translate([(t+g*2+w)*xx, (t+g*2+d)*yy, 0])
            full_link(w,d,h,t,g);
        }
    }

    for (xx=[0:x-2]) {
        for (yy=[0:y-2]) {
            translate([w/2+t/2+g+(t+g*2+w)*xx, d/2+t/2+g+(t+g*2+d)*yy, 0])
            full_link(w,d,h,t,g);
        }
    }


    *translate([w/2+t, d/2+t, 0])
    rotate([0, 0, 90])
    full_link(w,d,h,t,g);
}

module forViewing()
{
    links(5, 5);
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
