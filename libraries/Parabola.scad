//parabola(40, 10, 1, 10);
//rotate([0,0,45])
//parabolic_arch (40, 10, 1, 10);
//rotate([0,0,135])

//arch(40,10,10,2,1);
//rotate([0,0,90])

//arch2(40,10,10,2,1);

//Creates a filled parabola, using mirrored endpoints.
//d: The distance between the two mirrored endpoints at the base of the parabola.
//roundness: How "rounded" the parabola is.
//h: The height of the parabola's vertex.
//thickness: The thickness of the parabolic section.
module parabola(d, h, roundness, thickness)
{
    r=d*(roundness+1)/2;
    
    distance=sqrt(pow(r,2)-pow((d/2),2));//The distance between the cone's axis and the chord between the two points.
    if(distance!=0)
    {
        run=r-distance; //Assuming a line from the cone's vertex through the parabola's vertex, the horizontal distance underneath the segment between the vertex and the base.
     //The slope of the cone.
        slope=h/run;
        height=r*slope; //The height of the cone.
        section_height=h+thickness*slope+2;
        intersection()
        {
            translate([-distance,0,0])
            cylinder(r1=r, r2=0, h=height);
            
            translate([0,0,section_height/2])
            cube([thickness, d+run*2, section_height], center=true);
        }
    }
    else
    {
        intersection()
        {
            cylinder(r1=d/2, r2=0, h=h);
            
            translate([0,0,h/2+1])
            cube([thickness, d, h+2], center=true);
        }
    }
}

module multi_parabola(d, h, roundness, thickness, resolution)
{
    slice_width=thickness/resolution;
    left_hand=-thickness/2;
    for(i=[0:resolution])
    {
        translate([left_hand+slice_width*i,0,0])
        parabola(d, h, roundness, slice_width+1);
    }
}

module parabolic_arch(d,h,roundness, thickness)
{
    if(roundness==0)
    {
        hull()
        intersection()
        {
            union()
            {
                translate([thickness/2,0,0])
                cylinder(r1=d/2, r2=0, h=h);
                translate([-thickness/2,0,0])
                cylinder(r1=d/2, r2=0, h=h);
            }
            translate([0,0,h/2+1])
            cube([thickness, d, h+2], center=true);
        }
    }
    else
    {
        r=d*(roundness+1)/2;
        distance=sqrt(pow(r,2)-pow(d/2,2));
        cone_offset=distance+thickness/2;
        run=r-distance;
        slope=h/run;
        height=r*slope;
        hull()
        intersection()
        {
            union()
            {
                translate([cone_offset,0,0])
                cylinder(r1=r,r2=0,h=height);
                translate([-cone_offset,0,0])
                cylinder(r1=r, r2=0, h=height);
            }
            translate([0,0,h/2+1])
            cube([thickness, d, h+2], center=true);
        }
    }
}

module arch2(d, h, t0, t1, resolution)
{
    steps=d/resolution;
    thick_step=(t0-t1)/steps;
    for(i=[-steps/2:steps/2])
    {
        thickness=thick_step*abs(i)+t1;
        hyp_thickness=thickness/sqrt(2);
        y=i*resolution;
        z=zpos(y,d,h);
        translate([0,y,z])
        rotate([atan(z/y)+45,0,0])
        cube([thickness,hyp_thickness,hyp_thickness], center=true);
    }
}

module arch(d, h, t0, t1, resolution)
{
    steps=(d-t0/2)/resolution;
    thick_step=(t0-t1)/steps;
    for(i=[-steps/2:steps/2])
    {
        thickness=thick_step*abs(i)+t1;
        y=i*resolution;
        z=zpos(y,d-t0,h-t1/2);
        translate([0,y,z])
        rotate([atan(z/y),0,0])
        cube([thickness,thickness,thickness], center=true);
    }
}

function zpos(x, width, height)=height*(1-pow(abs(x/(width/2)), 2));
