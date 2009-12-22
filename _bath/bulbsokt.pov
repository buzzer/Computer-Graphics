// Persistence of Vision Ray Tracer Scene Description File
// File: bulbsokt.pov
// Vers: 3.1
// Desc: Item in "Household fixtures" series
// Date: 7OCT2000
// Auth: James R. Wilson jwilson6@twcny.rr.com
//
// A standard light bulb and a porcelain socket
// Scale: decimal inches

#version 3.1;

#include "colors.inc"
#include "metals.inc"
#include "textures.inc"

global_settings {
    assumed_gamma 1.0
    }

// ----------------------------------------

#declare Base_Texture = 
texture {
    pigment { White*0.002 }
    finish {
        phong 0.7
        reflection 0.45
        brilliance 6
        roughness 0.7
    }
}


#declare R1 = 1+3/16;  // bulb radius
#declare R2 = 0.5625;  // neck radius
#declare h  = 2.3-R1;  // neck height
#declare R3 = (2*h*R1+h*h+R2*R2)/(2*(R1-R2));
#declare s  = (R1*(R2+R3))/(R1+R3);   // radius at tangent to the sphere

// bulb
#declare Bulb =
union {
    merge {
        sphere { <0,0,0>, R1 }
        difference {
            cylinder { <0,-(R1+h),0>, <0, 0,0>, s }
            torus { R2+R3, R3 translate <0, -(R1+h), 0> }
            }
        cylinder { <0,-(R1+h),0>, <0,0.1-(R1+h),0>, R2 pigment { White }}
        texture {
            pigment { rgbt <1,0.9,0.9,0.7> } 
            finish { phong 0.8 reflection 0.45}
            }
        }

    }
       
// screw base, not needed if the bulb is in the socket
// (a small cheat, the "threads" are not spiral)
#declare Screw_Base =
union {
    lathe {
        linear_spline // linear_spline | quadratic_spline | cubic_spline
        25, // number of points
        <0.58, 0.0>, 
        <0.53, -0.07>, 
        <0.53, -0.10>, 
        <0.44, -0.13>, 
        <0.44, -0.16>, 
        <0.49, -0.19>, 
        <0.49, -0.22>, 
        <0.475,-0.25>, 
        <0.44, -0.28>, 
        <0.44, -0.31>, 
        <0.49, -0.34>, 
        <0.49, -0.37>, 
        <0.475,-0.40>, 
        <0.44, -0.43>, 
        <0.44, -0.46>, 
        <0.49, -0.49>, 
        <0.49, -0.52>, 
        <0.475,-0.55>, 
        <0.44, -0.58>, 
        <0.44, -0.61>,
        <0.475,-0.64>,
        <0.49, -0.67>, 
        <0.49, -0.70>, 
        <0.325,-0.82>, 
        <0.0,  -0.82> 
        translate <0,-(R1+h),0>
        texture { Base_Texture }
        }

    cone { <0, -0.82,0>, 0.325, <0, -0.92, 0>, 0.175
        translate <0,-(R1+h),0>
        pigment { Black }
        }

    cylinder { <0, -0.92, 0>, <0, -0.945, 0>, 0.175
        translate <0,-(R1+h),0>
        pigment { Black }
        }
 
    cylinder { <0, -0.945, 0>, <0, -0.95, 0>, 0.175
        translate <0,-(R1+h),0>
        pigment { Copper }
        }
 
    cylinder { <0, -0.95, 0>, <0, -0.98, 0>, 0.075
        translate <0,-(R1+h),0>
        pigment { Copper }
        }
    }
  

#macro LightBulb(On)
    object { Bulb }
    #if(On)
        light_source {
        < 0, 0, 0> // light's position
        color red 1.0  green 1.0  blue 0.1  // light's color
        }
    #end
#end


// Porcelain socket 
#declare Socket=
union {
    lathe {
        linear_spline
        12, // number of points
        <1.75, 0.5>, 
        <1.45, 0.5>, 
        <1.096, 0.646>, 
        <0.95, 1.0>, 
        <0.95, 1.2>, 
        <0.75, 1.2>, 
        <0.75, 1.7>, 
        <0.95, 1.7>, 
        <0.95, 1.9>, 
        <R2, 1.9>, 
        <R2, 0.5>,
        <0.0, 0.5>
        }
    torus { 1.75, 0.5 }
    torus { 0.95, 0.1 translate<0, 1.8,0> }
    torus { 0.95, 0.2 translate<0, 0.99,0> }
    texture { pigment { White }  finish { phong 0.85 } }
    translate <0,-(R1+h+1.9),0> 
    }
            
#macro Light(On, Sock)
union {
    LightBulb(On)
    #if(Sock)
        object { Socket }
    #else
        object { Screw_Base }
    #end
    }
#end
//--------------------------------------------------------------
// sample demo

// please note partial shadowing of the socket by its own flanges
camera {
    location  <0.0,  3.5, -10.0>
    direction 1.5*z
    right     4/3*x
    look_at   <0.0, -1,  0.0>
    }

plane { y, -(R1+h+1.9) pigment { Green*0.4 }}


Light(on, yes /* socket*/ )     

object { Light(off, no) rotate 45*x translate <-5,0,10>}     

// The socket default position is with respect to the center of the bulb so
// it will be properly aligned and located if it is rotated and translated 
// the same amounts as the bulb.

object { Socket translate <-5,0,10>}

object { Light(on, yes) translate < 5,0,10> }     

















