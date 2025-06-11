$fn=100;
use <gears/gears.scad>

//---------------------------------------------------------------
//DISPLAY OPTIONS
//---------------------------------------------------------------
split=0; // disasemble gearbox
//---------------------------------------------------------------
show_carrier_top=1;        // display gearbox carrier top part with sun gear
show_carrier_bottom=1;     // display gearbox carrier bottom part 
show_planets=1;            // display gearbox planets
show_ring_gear=1;          // display ring gear
show_motor_gear=1;         // display motor gear
show_motor_mount=0;        // display motor mounting base
show_distancer=0;          // display distancer
show_nema=0;               // display nema17
//---------------------------------------------------------------
//PARAMETERS
//---------------------------------------------------------------
//PLANET GEAR
PLANETS_N=3;
PLANET_GEAR_N=9;            // planet gear tooth count
PLANET_GEAR_H=4.7;          // planet gear height
PLANET_GEAR_ID=6.0;         // planet gear mountig hole inner diameter
PLANET_GEAR_ID_CLR=0.2;     // planet gear mounting shaft/pilar clearance 
PLANET_GEAR_DIST_H=0.4;     // height of top and bottom planet gear distancer
PLANET_GEAR_DIST_D=7.5;     // diameter of top and bottom planet gear distancer
PLANET_GEAR_R_CLR=0.4;      // radial clearance - clearance around planet gear
PLANET_GEAR_A_CLR=0.3;      // axial clearance - clearance along vertical axis
//SUN GEAR
SUN_GEAR_N=9;               // sun gear tooth count
SUN_GEAR_H=5.3;             // sun gear height
SUN_GEAR_ID=5.5;            // sun gear shaft/hole diameter
SUN_GEAR_DIST_H=2.1;        // height of bottom sun gear distancer/support
SUN_GEAR_DIST_D=13.9;       // diameter of bottom sun gear distancer/support
//RING GEAR
RING_GEAR_N=27;             // ring gear tooth count
RING_GEAR_H=5;              // ring gear height/tickness
//GEARBOX
GEARBOX_SHAPE=2;            // 0-square shape, 1-circular, 2-octagonal
GEARBOX_H=9;                // gearbox height
GEARBOX_OD=52-10;              // gearbox outter diameter/width
GEAR_PREASURE_ANGLE=20;     // gear preasure angle
GEAR_HELIX_ANGLE=0;         // gear helix angle
GEAR_MODUL=1.25;            // gear module
// gear clearance can be adjusted in gear.scad
//CARRIER
CARRIER_CLR=0.2;            // spacing/clearance between ring gear and planets carrier 
CARRIER_TP_RATIO=0.41;      // ratio between height of top and bottom carrier part
CARRIER_HOLE_N=PLANETS_N;   // number of carrier mounting holes
CARRIER_HOLE_D=3.3;         // carrier mounting holes outter diameter
CARRIER_BOLT_CLR=1.35;      // carrier mounting holes clearance (for bolt head)
CARRIER_BOLT_DEPTH=2;       // carrier mounting holes clearance depth
CARRIER_NUT_SIZE=5.5;       // carrier mounting hex nut size
CARRIER_NUT_DEPTH=2;        // carrier mounting hex nut depth
//MOTOR
MOTOR_BASE_H=10;            // motor base for gearbox mounting height
MOTOR_MOUNT_H=7.5;          // motor gear mount height 
MOTOR_MOUNT_OD=20;          // motor gear mount outter diameter
MOTOR_MOUNT_ID=5.2;         // motor gear mount inner diameter
MOTOR_GEAR_N=SUN_GEAR_N;    // motor gear tooth count
MOTOR_GEAR_H=SUN_GEAR_H;    // motor gear height/tickness
MOTOR_GEAR_DIST_H=SUN_GEAR_DIST_H; // motor gear distancer/support height
MOTOR_GEAR_DIST_D=SUN_GEAR_DIST_D; // motor gear distancer/support diameter
MOTOR_GEAR_R_CLR=0.4;       // gearbox clearance around motor/sun gear
//MOUNT
MOUNTING_HOLE_N=2;          // number of mounting holes
MOUNTING_HOLE_P=22;         // position of the gearbox mounting holes
MOUNTING_HOLE_ID=3.3;       // gearbox mounting holes inner diameter
MOUNTING_HOLE_OD=10;         // gearbox mounting holes outter diameter
MOUNTING_BOLT_CLR=1.35;     // gearbox mounting holes clearance (for bolt head)
MOUNTING_BOLT_DEPTH=3;      // gearbox mounting holes clearance depth
MOUNTING_NUT_SIZE=5.5;      // gearbox mounting hex nut size
MOUNTING_NUT_DEPTH=3;       // gearbox mounting hex nut depth
MOUNTING_NUT_TICKESS=2.5;   // gearbox mounting hex nut tickness
//DISTANCER
DISTANCER_H=1;              // distancer between individual geaboxes
//---------------------------------------------------------------
//CALCULATED PARAMETERS
//---------------------------------------------------------------
// total gear motor height includim mount and distancer
h_motor_gear=MOTOR_MOUNT_H+MOTOR_GEAR_DIST_H+MOTOR_GEAR_H; 
// carrier top and bottom part heights (planet mount)
h_top=CARRIER_TP_RATIO*GEARBOX_H;       
h_bottom=GEARBOX_H-h_top;   
// total planet gear height including distancer and axial clearance
h_planet=2*PLANET_GEAR_DIST_H+PLANET_GEAR_H+PLANET_GEAR_A_CLR; 
// planet gear position ofset
ofst=(GEARBOX_H-h_planet)/2;
// tickness of ring gear top and bottom plate (support)
d=(GEARBOX_H-RING_GEAR_H)/2;
// ring gear outter and inner diameter
ring_gear_od=getOD(RING_GEAR_N,GEAR_MODUL);
ring_gear_id=getID(RING_GEAR_N,GEAR_MODUL);
// diameter of the planet gear mounting shaft/pilar
planet_mount_d=PLANET_GEAR_ID-2*PLANET_GEAR_ID_CLR; 
// position of the planet gear
planet_gear_p=GEAR_MODUL*(RING_GEAR_N-PLANET_GEAR_N)/2; 
// position of the top/bottom carrier mountig holes
carrier_hole_p=planet_gear_p;          
//---------------------------------------------------------------
//COLORS
//---------------------------------------------------------------
color1=[0,0.8,0];        //GREEN
color2=[0.25,0.25,0.25]; //DARK
//---------------------------------------------------------------
//NEMA17
//---------------------------------------------------------------
if(show_nema)
{
    n_offset = split ? -10 : 0;
    translate([0,0,n_offset])
    {    
        translate([-4,0,1.5])
        color(color2)
        import("Nema17.stl");
    }
}
//---------------------------------------------------------------
//PLANETS
//---------------------------------------------------------------
if(show_planets)
{
    p_offset = split ? (h_motor_gear+h_bottom+GEARBOX_H+MOTOR_BASE_H+25) : MOTOR_BASE_H;
    translate([0,0,p_offset])
    {
        for(i=[0:(PLANETS_N-1)])
        {
            color(color1)
            rotate(a=i*(360/PLANETS_N),v=[0,0,1])
            {
                //distancer
                translate([-planet_gear_p,0.0,GEARBOX_H/2+PLANET_GEAR_H/2])
                difference()
                {
                    translate([0,0,-0.1])   
                    cylinder(r=PLANET_GEAR_DIST_D/2,h=PLANET_GEAR_DIST_H+0.1);
                    translate([0,0,-0.2])
                    cylinder(r=PLANET_GEAR_ID/2,h=PLANET_GEAR_DIST_H+0.3);
                }
                //gear
                translate([-planet_gear_p,0,GEARBOX_H/2-PLANET_GEAR_H/2])
                spur_gear (
                    modul=GEAR_MODUL, 
                    tooth_number=PLANET_GEAR_N, 
                    width=PLANET_GEAR_H, 
                    bore=PLANET_GEAR_ID, 
                    pressure_angle=GEAR_PREASURE_ANGLE,   
                    helix_angle=GEAR_HELIX_ANGLE, 
                    optimized=true
                    ); 
            }
        }

    }
}
//--------------------------------------------------------
//CARRIER BOTTOM PART
//--------------------------------------------------------
if(show_carrier_bottom)
{
    b_offset = split ? (h_motor_gear+MOTOR_BASE_H+10) : MOTOR_BASE_H;
    translate([0,0,b_offset])
    {
        difference()
        {
            //base
            color(color2)
            translate([-0,-0,0])
            cylinder(r=ring_gear_id/2-CARRIER_CLR,h=h_bottom);
            translate([-0,-0,-0.1])
            cylinder(r=MOTOR_GEAR_DIST_D/2+MOTOR_GEAR_R_CLR,h=h_bottom+0.2);
            //holes and nuts
            for(i=[0:(PLANETS_N-1)])
            {
                rotate(a=i*(360/PLANETS_N),v=[0,0,1])
                translate([-planet_gear_p,0,ofst])
                cylinder(r=getOD(PLANET_GEAR_N,GEAR_MODUL)/2-1+PLANET_GEAR_R_CLR,h=h_bottom-ofst+0.1);
            }
            for(i=[0:(CARRIER_HOLE_N-1)])
            { 
                rotate(a=i*(360/CARRIER_HOLE_N),v=[0,0,1])
                rotate(a=(360/CARRIER_HOLE_N/2),v=[0,0,1])
                translate([-carrier_hole_p,-0,0])
                {
                    translate([-0,-0,-1])
                    cylinder(r=CARRIER_HOLE_D/2,h=15); 
                    rotate(a=30,v=[0,0,1])
                    translate([-0,-0,CARRIER_NUT_DEPTH/2-0.1])
                    fhex(CARRIER_NUT_SIZE,CARRIER_NUT_DEPTH+0.1);
                }
            }
        }
        //planet mounts/pilars
        for(i=[0:(PLANETS_N-1)])
        {
            color(color2)
            rotate(a=i*(360/PLANETS_N),v=[0,0,1])
            translate([-planet_gear_p,-0,ofst])
            {
                cylinder(r=planet_mount_d/2,h=GEARBOX_H-ofst); 
                translate([-0,-0,-0.1])  
                cylinder(r=PLANET_GEAR_DIST_D/2,h=PLANET_GEAR_DIST_H+0.1); 
            }
        }

    }
}
//--------------------------------------------------------    
//CARRIER TOP PART        
//--------------------------------------------------------
if(show_carrier_top)
{
    t_offset = split ? (h_motor_gear+h_bottom+GEARBOX_H+h_planet+MOTOR_BASE_H+30) : MOTOR_BASE_H;
    translate([0,0,t_offset])
    {

        //top gear
        color(color2)
        translate([0,0,GEARBOX_H+SUN_GEAR_DIST_H])
        spur_gear (
            modul=GEAR_MODUL, 
            tooth_number=SUN_GEAR_N, 
            width=SUN_GEAR_H, 
            bore=SUN_GEAR_ID, 
            pressure_angle=GEAR_PREASURE_ANGLE,   
            helix_angle=GEAR_HELIX_ANGLE, 
            optimized=true
            ); 
        //top mount  
        translate([-0,-0,h_bottom])
        difference()
        {
            color(color2)
            union()
            {
                translate([-0,-0,0])
                cylinder(r=ring_gear_id/2-CARRIER_CLR,h=h_top);
                
                translate([0,-0,h_top])
                cylinder(r=SUN_GEAR_DIST_D/2,h=SUN_GEAR_DIST_H+0.025);
            
                translate([0,-0,h_top])
                cylinder(r=PLANET_GEAR_ID/2+0.1,h=SUN_GEAR_H+SUN_GEAR_DIST_H);
            }
            //shaft hole
            cylinder(r=SUN_GEAR_ID/2,h=h_top+SUN_GEAR_DIST_H+SUN_GEAR_H+0.1);
            
            translate([0,-0,-0.1])
            cylinder(r=MOTOR_GEAR_DIST_D/2+MOTOR_GEAR_R_CLR,h=h_top-ofst+0.1);   
      
            for(i=[0:(PLANETS_N-1)])
            {
                rotate(a=i*(360/PLANETS_N),v=[0,0,1])
                translate([-planet_gear_p,-0,-0.1])
                cylinder(r=planet_mount_d/2+0.1,h=h_top+0.2);
                
                rotate(a=i*(360/PLANETS_N),v=[0,0,1])
                translate([-planet_gear_p,-0,-0.1])
                cylinder(r=getOD(PLANET_GEAR_N,GEAR_MODUL)/2-1+PLANET_GEAR_R_CLR,h=h_top-ofst+0.1);
            }
            for(i=[0:(CARRIER_HOLE_N-1)])
            {
                rotate(a=i*(360/CARRIER_HOLE_N),v=[0,0,1])
                rotate(a=(360/CARRIER_HOLE_N/2),v=[0,0,1])
                translate([-carrier_hole_p,-0,0])
                {
                    translate([-0,-0,-0.1])
                    cylinder(r=CARRIER_HOLE_D/2,h=h_top+0.2); 
                    rotate(a=30,v=[0,0,1])
                    translate([-0,-0,h_top-CARRIER_BOLT_DEPTH+0.1])
                    cylinder(r=CARRIER_HOLE_D/2+CARRIER_BOLT_CLR,h=CARRIER_BOLT_DEPTH+0.1); 
                }
            }
       
        }
    }
}
//--------------------------------------------------------
//RING GEAR
//--------------------------------------------------------

if(show_ring_gear)
{
    i_offset = split ? (h_motor_gear+h_bottom+MOTOR_BASE_H+20) : MOTOR_BASE_H;
    translate([0,0,i_offset])
    {
        difference()
        {
            union()
            {
                translate([0,0,d])
                {          
                    color(color1)
                    ring_gear (
                        modul=GEAR_MODUL, 
                        tooth_number=RING_GEAR_N, 
                        width=RING_GEAR_H, 
                        rim_width=1, 
                        pressure_angle=GEAR_PREASURE_ANGLE, 
                        helix_angle=GEAR_HELIX_ANGLE
                        );
                    color(color1)
                    difference()
                    {
                        union()
                        {
                            if(GEARBOX_SHAPE==0)
                                rounded_cube( GEARBOX_OD, GEARBOX_OD, RING_GEAR_H, 6);
                            else if (GEARBOX_SHAPE==1) 
                                cylinder(r=GEARBOX_OD/2,h=RING_GEAR_H);
                            else
                                rounded_octagon(GEARBOX_OD,6,RING_GEAR_H);
            
                            rotate(a=(360/4/MOUNTING_HOLE_N),v=[0,0,1])
                            for(i=[0:(2*MOUNTING_HOLE_N-1)])
                            {
                                rotate(a=i*(360/2/MOUNTING_HOLE_N),v=[0,0,1])
                                translate([0,MOUNTING_HOLE_P,-d])
                                cylinder(r=MOUNTING_HOLE_OD/2,h=GEARBOX_H);        
                            }
                        }
                        
                        translate([0,0,-0.1])
                        cylinder(r=ring_gear_od/2-0.1,h=RING_GEAR_H+0.2);       
                    }
                }
                color(color1)
                translate([0,0,GEARBOX_H-d-0.005])
                difference()
                {
                    if(GEARBOX_SHAPE==0)
                        rounded_cube( GEARBOX_OD, GEARBOX_OD, d, 6);
                    else if (GEARBOX_SHAPE==1)
                        cylinder(r=GEARBOX_OD/2,h=d);   
                    else
                        rounded_octagon(GEARBOX_OD,6,d);
                    translate([0,0,-0.1])
                    cylinder(r=ring_gear_id/2,h=d+0.2);       
                }
                color(color1)
                difference()
                {
                    translate([0,0,0.005])
                    if(GEARBOX_SHAPE==0)
                        rounded_cube( GEARBOX_OD, GEARBOX_OD, d, 6);
                    else if (GEARBOX_SHAPE==1)
                        cylinder(r=GEARBOX_OD/2,h=d);   
                    else
                        rounded_octagon(GEARBOX_OD,6,d);
                    translate([0,0,-0.1])
                    cylinder(r=ring_gear_id/2,h=d+0.2);       
                }
            }
            rotate(a=(360/4/MOUNTING_HOLE_N),v=[0,0,1])
            {
                //mounting holes
                for(i=[0:(2*MOUNTING_HOLE_N-1)])
                {
                    rotate(a=i*(360/2/MOUNTING_HOLE_N),v=[0,0,1])
                    translate([0,MOUNTING_HOLE_P,-1])
                    cylinder(r=MOUNTING_HOLE_ID/2,h=GEARBOX_H+2);        
                }
                //hex nuts for mounting
                for(i=[0:(MOUNTING_HOLE_N-1)])
                {
                    rotate(a=i*(360/MOUNTING_HOLE_N),v=[0,0,1]) 
                    translate([0,MOUNTING_HOLE_P,0])
                    rotate(a=30,v=[0,0,1])
                    translate([0,0,(MOUNTING_NUT_DEPTH+1)/2-1])
                    fhex(MOUNTING_NUT_SIZE,MOUNTING_NUT_DEPTH+1);
                }
                //bolt head clearance
                for(i=[0:(MOUNTING_HOLE_N-1)])
                {
                    rotate(a=i*(360/MOUNTING_HOLE_N)+(360/2/MOUNTING_HOLE_N),v=[0,0,1]) 
                    translate([0,MOUNTING_HOLE_P,GEARBOX_H-MOUNTING_BOLT_DEPTH])
                    cylinder(r=MOUNTING_HOLE_ID/2+MOUNTING_BOLT_CLR,h=MOUNTING_BOLT_DEPTH+0.1);
                }  
            }
        }
    }
} 
//--------------------------------------------------------
//MOTOR GEAR
//--------------------------------------------------------
if(show_motor_gear)
{
    show_motor_gear=1;
    g_offset = split ? (MOTOR_BASE_H+5) : 2.5+MOTOR_BASE_H-10;
    translate([0,0,g_offset])
    {
        //top gear
        color(color2)
        translate([0,0,MOTOR_MOUNT_H+MOTOR_GEAR_DIST_H])
        {
            spur_gear (
                modul=GEAR_MODUL, 
                tooth_number=MOTOR_GEAR_N, 
                width=MOTOR_GEAR_H, 
                bore=MOTOR_MOUNT_ID, 
                pressure_angle=GEAR_PREASURE_ANGLE,   
                helix_angle=GEAR_HELIX_ANGLE, 
                optimized=true
                ); 
        }
        //top mount  
        difference()
        {
            color(color2)
            union()
            {
                //base
                translate([-0,-0,0])
                cylinder(r=MOTOR_MOUNT_OD/2,h=MOTOR_MOUNT_H);
                //gear distancer
                translate([0,-0,MOTOR_MOUNT_H-0.1])
                cylinder(r=MOTOR_GEAR_DIST_D/2,h=MOTOR_GEAR_DIST_H+0.125);
                //filling cylinder
                translate([0,-0,MOTOR_MOUNT_H])
                cylinder(r=PLANET_GEAR_ID/2+0.1,h=MOTOR_GEAR_H+MOTOR_GEAR_DIST_H);
            }            
            //shaft hole
            translate([0,0,-0.1])
            cylinder(r=MOTOR_MOUNT_ID/2,h=h_motor_gear+0.2);
            //nut isert slit
            translate([-MOUNTING_NUT_SIZE/2-0.05,MOTOR_MOUNT_ID/2+1.5,-0.1])
            cube([MOUNTING_NUT_SIZE+0.1,MOUNTING_NUT_TICKESS+0.1,MOTOR_MOUNT_H/2+3.7+0.1]);
            //bolt fixing hole
            translate([0,0,MOTOR_MOUNT_H/2])
            rotate(a=-90,v=[1,0,0])
            cylinder(r=MOUNTING_HOLE_ID/2,h=MOTOR_MOUNT_OD/2+0.1);     
        }
        
    }
}
//--------------------------------------------------------
//MOTOR MOUNT
//--------------------------------------------------------
if(show_motor_mount)
{
    m_offset = split ? 0 : 0;
    translate([0,0,m_offset])
    {
        difference()
        {
            union()
            {
                color(color2)
                difference()
                {
                    union()
                    {
                        if(GEARBOX_SHAPE==0)
                            rounded_cube( GEARBOX_OD, GEARBOX_OD, MOTOR_BASE_H, 6);
                        else if(GEARBOX_SHAPE==1)
                            cylinder(r=GEARBOX_OD/2,h=MOTOR_BASE_H);
                        else
                            rounded_octagon(GEARBOX_OD,6,MOTOR_BASE_H);
                        
                        rotate(a=(360/4/MOUNTING_HOLE_N),v=[0,0,1])
                        for(i=[0:(2*MOUNTING_HOLE_N-1)])
                        {
                            rotate(a=i*(360/2/MOUNTING_HOLE_N),v=[0,0,1])
                            translate([0,MOUNTING_HOLE_P,0])
                            cylinder(r=MOUNTING_HOLE_OD/2,h=MOTOR_BASE_H);        
                        }
                    }
                    
                    translate([0,0,-0.1])
                    cylinder(r=ring_gear_id/2,h=MOTOR_BASE_H+0.2);       
                } 
            }
            rotate(a=(360/4/MOUNTING_HOLE_N),v=[0,0,1])
            {
                //mounting holes
                for(i=[0:(2*MOUNTING_HOLE_N-1)])
                {
                    rotate(a=i*(360/MOUNTING_HOLE_N/2),v=[0,0,1])
                    translate([0,MOUNTING_HOLE_P,-1])
                    cylinder(r=MOUNTING_HOLE_ID/2,h=MOTOR_BASE_H+2);        
                }
                //hex nuts for mounting
                for(i=[0:(MOUNTING_HOLE_N-1)])
                {
                    rotate(a=i*(360/MOUNTING_HOLE_N),v=[0,0,1]) 
                    translate([0,MOUNTING_HOLE_P,0])
                    rotate(a=30,v=[0,0,1])
                    translate([0,0,(MOUNTING_NUT_DEPTH+1)/2-1])
                    fhex(MOUNTING_NUT_SIZE,MOUNTING_NUT_DEPTH+1);
                }
                //bolt head clearance
                for(i=[0:(MOUNTING_HOLE_N-1)])
                {
                    rotate(a=i*(360/MOUNTING_HOLE_N)+(360/MOUNTING_HOLE_N/2),v=[0,0,1]) 
                    translate([0,MOUNTING_HOLE_P,MOTOR_BASE_H-MOUNTING_BOLT_DEPTH])
                    cylinder(r=MOUNTING_HOLE_ID/2+MOUNTING_BOLT_CLR,h=MOUNTING_BOLT_DEPTH+0.1);
                }
            }
        }
    }
}
//--------------------------------------------------------
//DISTANCER
//--------------------------------------------------------
if(show_distancer)
{
    d_offset = split ? (h_motor_gear+h_bottom+GEARBOX_H+h_planet+MOTOR_BASE_H+h_top+SUN_GEAR_H+45) : MOTOR_BASE_H+GEARBOX_H;
    translate([0,0,d_offset])
    {
        difference()
        {
            union()
            {
                color(color2)
                difference()
                {
                    union()
                    {
                        if(GEARBOX_SHAPE==0)
                            rounded_cube( GEARBOX_OD, GEARBOX_OD, DISTANCER_H, 6);  
                        else if(GEARBOX_SHAPE==1)
                            cylinder(r=GEARBOX_OD/2,h=DISTANCER_H);
                        else    
                            rounded_octagon(GEARBOX_OD,6,DISTANCER_H);
                        
                        rotate(a=(360/4/MOUNTING_HOLE_N),v=[0,0,1])
                        for(i=[0:(2*MOUNTING_HOLE_N-1)])
                        {
                            rotate(a=i*(360/2/MOUNTING_HOLE_N),v=[0,0,1])
                            translate([0,MOUNTING_HOLE_P,0])
                            cylinder(r=MOUNTING_HOLE_OD/2,h=DISTANCER_H);        
                        }
                    }
                                    
                    translate([0,0,-0.1])
                    cylinder(r=ring_gear_id/2,h=DISTANCER_H+0.2);       
                } 
            }
            rotate(a=(360/4/MOUNTING_HOLE_N),v=[0,0,1])
            {
                //mounting holes
                for(i=[0:(2*MOUNTING_HOLE_N-1)])
                {
                    rotate(a=i*(360/MOUNTING_HOLE_N/2),v=[0,0,1])
                    translate([0,MOUNTING_HOLE_P,-1])
                    cylinder(r=MOUNTING_HOLE_ID/2,h=MOTOR_BASE_H+2);        
                } 
            }
        } 
    }
}
//--------------------------------------------------------
//hex module
//--------------------------------------------------------
module fhex(wid,height)
{
    hull()
    {
        cube([wid/1.7,wid,height],center = true);
        rotate([0,0,120])cube([wid/1.7,wid,height],center = true);
        rotate([0,0,240])cube([wid/1.7,wid,height],center = true);
    }
}
//--------------------------------------------------------
//rounded cube module
//--------------------------------------------------------
module rounded_cube( x, y, z, r)
{
    translate([-x/2+r,-y/2+r,0])
    linear_extrude(height=z)
    minkowski() 
    {
        square([x-2*r,y-2*r],true);
        translate([x/2-r,y/2-r,0])
        circle(r);

    }
}
//--------------------------------------------------------
//rounded octagon module
//--------------------------------------------------------
module rounded_octagon(width,radius,height)
{
    r=radius;
    w=width-2*radius;
    a=w/(1+sqrt(2));
    
    p1=[-w/2,-a/2];
    p2=[-w/2,+a/2];
    p3=[-w/2+a/sqrt(2),+a/2+a/sqrt(2)];
    p4=[+w/2-a/sqrt(2),+a/2+a/sqrt(2)];
    p5=[+w/2,+a/2];
    p6=[+w/2,-a/2];
    p7=[+w/2-a/sqrt(2),-a/2-a/sqrt(2)];
    p8=[-w/2+a/sqrt(2),-a/2-a/sqrt(2)];
    
    points=[p1,p2,p3,p4,p5,p6,p7,p8];
    linear_extrude(height=height)
    translate([w/2,a/2,5])
    minkowski() 
    {
        polygon(points);
        translate([-w/2,-a/2,0])
        circle(r);
    }
}
//--------------------------------------------------------
//Functions extracted from gears.scad
//--------------------------------------------------------
function getID(tooth_number,modul)=
    let(
        ha=(tooth_number>=20) ? 0.02*atan((tooth_number/15)/3.14159) : 0.6,
        d=modul*tooth_number
    )
    (d-2*modul*ha);    

function getOD(tooth_number,modul)=
    let(
        d = modul * tooth_number, 
        c = modul / 6,
        da = (modul <1)? d + (modul+c) * 2.2 : d + (modul+c) * 2
    )
    2*(da/2+1);
