//==========================================
// Toothbrush, toothpaste, soap and soapholder
// -----------------------------------------
// Made for Persistence of vision 3.6
//==========================================  
// Copyright 2001-2004 Gilles Tran http://www.oyonale.com
// -----------------------------------------
// This work is licensed under the Creative Commons Attribution License. 
// To view a copy of this license, visit http://creativecommons.org/licenses/by/2.0/ 
// or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.
// You are free:
// - to copy, distribute, display, and perform the work
// - to make derivative works
// - to make commercial use of the work
// Under the following conditions:
// - Attribution. You must give the original author credit.
// - For any reuse or distribution, you must make clear to others the license terms of this work.
// - Any of these conditions can be waived if you get permission from the copyright holder.
// Your fair use and other rights are in no way affected by the above. 
//==========================================  
// The toothpaste object is also provided as a sPatch object
//==========================================

#include "colors.inc"
#include "textures.inc"
#include "metals.inc"
global_settings{
    radiosity{
        count 300 error_bound 0.1 
        recursion_limit 2
    }
    assumed_gamma 1
    max_trace_level 20
}
camera{
    location  <0, 0.3, -0.6>
    direction z*2.3
    right     4*x/3
    look_at   <0, 0.14,  -0.1>
}               
background{rgb<0.6,0.78,0.96>*0.4}
light_source{
    <-20,40,-10>*10 
    color White
//    area_light 3*x,3*z, 5,5 jitter adaptive 1
}
plane{y,0 texture{pigment{rgb<1,0.98,0.96>} finish{ambient 0 diffuse 0.8}}}

//============================                     
// Tootbrush
//============================                     
#declare ToothBrush=union{
    blob{
        threshold 0.6
        sphere{0,1,1 scale <0.9,0.5,1.8>*1.7 translate z*1.8 rotate -x*10 translate z*-1.8 translate z*16}
        sphere{0,1,1 scale <0.6,0.5,8>*1.7 translate z*8}
        sphere{0,1,-1 scale <0.6,0.5,1>*1.7 translate z*12 translate x}
        sphere{0,1,-1 scale <0.6,0.5,1>*1.7 translate z*12 translate -x}
    }                       
    
    union{ // Hair
        #declare i=0;
        #declare dPoil=0.23;
        #declare Poil=cone{0,0.06,y,0.07}
        #while (i<12)
            object{Poil translate <dPoil*(0.5+0.5*sin(pi*i/12)),0,dPoil*i*1.05>}
            object{Poil translate <dPoil*(1.5+0.8*sin(pi*i/12)),0,dPoil*i>}
            object{Poil translate <-dPoil*(0.5+0.5*sin(pi*i/12)),0,dPoil*i*1.05>}
            object{Poil translate <-dPoil*(1.5+0.8*sin(pi*i/12)),0,dPoil*i>}
            #declare i=i+1;
        #end
        translate y*0.3
        translate -z*i*dPoil/2
        rotate -x*10
        translate z*15.9
        texture{pigment{White}finish{ambient 0.2 diffuse 1}}
    }
    scale 0.01
    rotate -x*90
}                                

#declare ToothBrush1=object{ToothBrush texture{pigment{rgb <1,0.2,0.1>*0.8} finish{ambient 0 diffuse 1 specular 0.8 roughness 0.03}}}
#declare ToothBrush2=object{ToothBrush texture{pigment {rgb <0.05859, 0.79609, 1>*0.8} finish{ambient 0 diffuse 1 specular 0.8 roughness 0.03}}}

//============================                     
// Cup with toothbrushes
//============================                     
#declare Coupe =union{
    lathe{
    	cubic_spline
    	20,	<0.012214,0.546558>,	<0.021374,0.555718>,	<0.109922,0.641214>,	<0.186257,0.729762>,	<0.320607,0.919073>,	<0.360301,0.989301>,	<0.412209,0.995408>,	<0.384728,0.946553>,	<0.341981,0.894646>,	<0.277859,0.809151>,	<0.189311,0.680908>,	<0.122136,0.592359>,	<0.076335,0.525184>,	<0.036641,0.424422>,	<0.036641,0.329767>,	<0.073282,0.213738>,	<0.164883,0.112976>,	<0.320607,0.012214>,	<0.024427,0.000000>,	<0.006107,-0.018320>
        sturm
        texture{       
            pigment{   
                gradient y
                pigment_map{
                    [0.45 spiral1 10 turbulence 0.02 color_map{[0.5 White][0.5 Black]} rotate x*90]
                    [0.47 color Black]
                    [0.48 color rgb <0.4,1,0.8>]
                }
            }
            finish{ambient 0 diffuse 1 specular 1 roughness 0.001 reflection 0.1}
        }
        scale 0.14
    }
    object{ToothBrush1 rotate x*35 translate y*0.07}
    object{ToothBrush2 rotate y*180 rotate x*35 translate y*0.07 rotate y*-41.3}
}

//============================                     
// Toothpaste
//============================                     

#declare default_texture = texture{pigment{image_map{png "tubemap"}} finish{ambient 0 diffuse 1 specular 1 roughness 0.01 reflection 0.1}}
#declare Mmaterial_1 = texture{default_texture}
#include "tube_o.inc" #declare ToothPaste=object{ object_1 translate <0,0.069155,0> scale 17.5*0.5/0.348750 scale 0.01}

//============================                     
// Soap and soap holder
//============================                     
#declare rPS=0.33;
#declare xPS=5;
#declare zPS=3.25;
#declare rPS2=1;
#declare rPS3=0.15;
#declare rPS4=0.7;
#declare rPS5=1.5;
#declare xPS2=xPS-rPS4-0.3;
#declare zPS2=zPS-rPS4;
#declare xPS3=3;
#declare xPS4=4;
#declare xPS5=1.4;
#declare ybPS=2;
#declare aPS=20;
#declare aPS2=30;
#declare AnglePS=difference{
    torus{rPS2,rPS}
    plane{z,0}
    plane{x,0}
}
#declare AnglePS2=union{
    difference{
        torus{rPS2,rPS3 rotate x*90}
        plane{x,0}
        plane{y,0 rotate -z*aPS inverse}
    }
    cylinder{0,y*ybPS,rPS3 translate <rPS2,0,0> rotate -z*aPS}
    
}
#declare yBarrePS=union{
    cylinder{-xPS5*x*1.4,0,rPS}
    difference{
        torus{rPS5,rPS rotate x*90}
        plane{x,0}
        translate y*rPS5        
    }
    cylinder{-xPS5*x,0,rPS translate y*rPS5*2}
    union{
        difference{
            torus{rPS2,rPS rotate x*90}
            plane{x,0 inverse}
            plane{y,0 rotate z*aPS2 inverse}
            translate y*rPS2
        }
        union{
            sphere{0,rPS*1.4 translate -(xPS4+rPS*1.2)*x}
            cylinder{-xPS4*x,0,rPS}
            translate -y*rPS2
            rotate -z*(90-aPS2)
            translate y*rPS2
        }
        translate <-xPS5,rPS5*2,0>
    }
}
#declare xBarrePS=union{
    cylinder{-xPS2*x,xPS2*x,rPS3}
    object{AnglePS2 translate <xPS2,rPS2,0>}
    object{AnglePS2 translate <xPS2,rPS2,0> scale <-1,1,1>}
}
#declare zBarrePS=union{
    cylinder{-zPS2*z,zPS2*z,rPS3}
    object{AnglePS2 rotate y*-90 translate <0,rPS2,zPS2>}
    object{AnglePS2 rotate y*-90 translate <0,rPS2,zPS2> scale <1,1,-1>}
}                     
#declare Soap=superellipsoid{<0.4,0.4> scale <xPS,2,zPS> translate y*2 scale 0.8
    hollow
    texture{
        pigment{rgbf<0.3,1,0.6,1>}
        finish{ambient 0 diffuse 1 specular 0.02 roughness 0.1}
    }
    interior{
        media{
            scattering{1,rgb <0.3,1,0.6>*80}
        }
    }
}
#declare SoapHolder=union{
    union{
        union{
            cylinder{-x*xPS,x*xPS,rPS translate z*(zPS+rPS2)}
            cylinder{-x*xPS,x*xPS,rPS translate -z*(zPS+rPS2)}
            cylinder{-z*zPS,z*zPS,rPS translate x*(xPS+rPS2)}
            cylinder{-z*zPS,z*zPS,rPS translate -x*(xPS+rPS2)}
            object{AnglePS translate <xPS,0,zPS>}
            object{AnglePS translate <xPS,0,zPS> scale <-1,1,1>}
            object{AnglePS translate <xPS,0,zPS> scale <1,1,-1>}
            object{AnglePS translate <xPS,0,zPS> scale <-1,1,-1>}
            translate y*2
        }
        union{
            object{xBarrePS translate z*(zPS-2*zPS/3)}
            object{xBarrePS translate z*(zPS-2*zPS/3) scale <1,1,-1>}
            translate -y*rPS3*2
        }   
        union{                                
            #declare i=1;
            #while (i<6)
                object{zBarrePS translate  -x*xPS+x*i*2*xPS/6}
                #declare i=i+1;
            #end
        }                 
        object{Soap rotate y*20 translate <0.7,-0.1,0.4>}
        translate y*5.5
    }
    union{             
        torus{4,rPS translate y*rPS}
        union{
            object{yBarrePS translate -2.2*x}
            object{yBarrePS translate -2.2*x scale <-1,1,1>}
            sphere{0,rPS*1.4 translate y*rPS5}
            translate y*3*rPS
        }
    }
    texture{
        pigment{rgb <1,0.9,0.8>} 
        finish{ambient 0 diffuse 0.8 brilliance 5 metallic specular 1 roughness 1/200 
            reflection{0.2, 0.9}
        }
        
    }
    scale 0.01
}                                                   
//==========================================
// Objects
//==========================================
object{Coupe rotate y*60 translate <0.06,0,0>}
object{ToothPaste rotate y*40 translate <-0.07,0,0>}
object{SoapHolder rotate y*10 translate <-0.1,0,0.13>}
