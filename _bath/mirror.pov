//==========================================
// Bathroom mirror with lamps and a spray bottle
// -----------------------------------------
// Unit is meter
// -----------------------------------------
// Made for Persistence of vision 3.6
//==========================================  
// Copyright 2000-2004 Gilles Tran http://www.oyonale.com
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
#include "colors.inc"
#include "textures.inc"
#include "metals.inc"
global_settings{
    assumed_gamma 1
    radiosity{
        recursion_limit 2
    }
}

camera{
    location  <1.5, 1.6, -2>
    direction z*1.5
    right     4*x/3
    look_at   <0, 1.6,  0>
}               
box{<-2,0,-3>,<2,3,0>
    texture{pigment{rgb<1,0.98,0.96>} normal{agate 0.02 scale 0.1} finish{ambient 0 diffuse 1}}
}

//============================                     
// Spray bottle
//============================                     
#declare Spray=union{
    #declare rSpray=5.2/2;
    #declare rSpray2=2.6/2;
    #declare rSpray3=0.8;
    #declare ySpray=17;
    #declare ySpray2=1.5;
    #declare eSpray=0.02;
    torus{rSpray,eSpray texture{T_Chrome_3C}}
    cylinder{0,y*ySpray,rSpray}
    union{
        torus{rSpray,0.1 translate y*ySpray}
        sphere{0,rSpray scale <1,0.5,1> translate y*ySpray}
        texture{T_Chrome_3C}
    }
    union{         
        torus{rSpray2,eSpray translate y*eSpray}
        cylinder{0,y*ySpray2*0.3,rSpray2}
        difference{
            cylinder{0,y*ySpray2,rSpray3}
            cylinder{-z*rSpray3*2,z*rSpray3*2,rSpray3 scale <1,0.5,1> translate y*ySpray2}
        }
        translate y*(ySpray+rSpray*0.45)
        texture{pigment{Black}finish{ambient 0 diffuse 1 specular 1 roughness 0.01}}
    }
    texture{       
        pigment{   
            spiral2 2 
            turbulence 0.02                   
            rotate x*30
            scale 2
            color_map{[0.5 White][0.5 Red]} 
        }
        finish{ambient 0 diffuse 1 specular 1 roughness 0.001}
    }
    translate y*eSpray
    
    scale 0.015
}                        
//============================                     
// Lamps
//============================                     
#macro Lamp(eEL)
    #local i=0;
    #local n=20;
    #local rEL=0.008;
    #local zEL=0.013;
    #local aEL=0;
    #local posEL=<0,0,0>;
    #local EL=union{
        cylinder{0,z*zEL,rEL}
        torus{rEL,rEL*0.2 rotate x*90 scale <1,1,3>}
    }
    #local LampPost=union{
        #while (i<n)
            object{EL rotate x*aEL translate posEL}
            #local posEL=posEL+z*zEL*cos(radians(aEL))-y*zEL*sin(radians(aEL));
            #local aEL=aEL+eEL;
            #local i=i+1;
        #end
        object{Bulb rotate x*aEL translate posEL no_shadow}
    }
    union{
        light_source{
            posEL color C_Lamp*30 fade_power 2 fade_distance 0.15
                area_light 0.1*x,0.1*y 10,10 jitter adaptive 2
        }
        object{LampPost}
    } 
#end                        

//============================                     
// Bulb
//============================                     
#declare Bulb=merge{
        difference{sphere{0,1} plane{y,0 inverse}}
        difference{sphere{0,1} plane{y,0} scale <1,3,1>}
        translate y
        scale 0.035
        rotate x*90
        texture{
            pigment{White}
            finish{ambient 2 diffuse 1}
        }
}
//============================                     
// Miroir
//============================                     

#declare C_Lamp=rgb<245,210,138>/255;
#declare xM=0.45;
#declare eM=0.02;
#declare eSM=0.02;
#declare sM=0.2;
#declare yM=0.98;
#declare yM1=yM-sM;
#declare zM=0.156;
#declare yLM=0.06;
#declare zLM=0.05;
#declare eLM=0.01;
#declare T_Mirror0=texture{
    pigment{bozo color_map{[0.5 White][0.6 Red*0.2]}}
    finish{ambient 0 diffuse 1}
}
#declare T_Mirror1=texture{
    pigment{SeaGreen*0.01}
    finish{ambient 0 diffuse 0 reflection 0.9}
}
#declare T_Mirror=texture{
    pigment_pattern{
        gradient y
        turbulence 0.2
        lambda 3
    }
    texture_map{
        [0 pigment_pattern{granite} texture_map{[0.05 T_Mirror0][0.06 T_Mirror1]} scale 0.05]
        [0.9 T_Mirror1]
        [1 T_Mirror1]
    }
    scale yM*1.1
}

#declare T_MirrorFrame=texture{pigment{White}finish{ambient 0 diffuse 1 specular 1 roughness 0.08}}
#declare Mirror=union{        
    union{ // Mirror
        box{<-xM,0,-eM>,<xM,sM,0>}
        union{
            box{<0,0,-eM>,<sM-eM*0.5,yM1,0> translate -x*xM}
            box{<0,0,-eM>,<sM-eM*0.5,yM1,0> translate -x*xM scale <-1,1,1>}
            box{<-xM+sM,0,-eM>,<xM-sM,yM1,0>}
            translate y*sM
        }
        texture{T_Mirror}
    }                 
    // Frame and shelves
    union{
        union{ // First shelf
            difference{    
                union{ 
                    box{<-xM,-eSM,-zM>,<xM,0,0>}
                    cylinder{-xM*x,x*xM,eSM*0.5 translate <0,-eSM*0.5,-zM>}
                }
                cylinder{-y*eSM*2,y*eSM,zM translate -z*zM}
            }
            union{
              difference{torus{zM,eSM*0.5} plane{z,0}}
              sphere{0,eSM*0.5 translate -x*zM}
              sphere{0,eSM*0.5 translate x*zM}
              translate <0,-eSM*0.5,-zM>
            }
/* // replace by your own objects
            object{Flacon9 rotate y*12 translate <-xM*0.45,0,-zM*0.70>}
            object{Flacon10 rotate y*12 translate <-xM*0.62,0,-zM*0.75>}
            object{Flacon11 rotate y*12 translate <-xM*0.9,0,-zM*0.62>}
            object{Brush4 rotate -x*90 scale 0.15 rotate y*30 translate <xM*0.5,0.007,-zM*0.25>}
            object{SoapHolder rotate -y*15 translate <xM*0.55,0,-zM*0.72>}
            object{Soap rotate -y*32 translate <xM*0.84,0,-zM*0.85>}
*/
            translate -z*0.0025
        }
        union{ // Second shelf             
            box{<-xM,-eSM,-zM>,<xM,0,0>}
            cylinder{-xM*x,x*xM,eSM*0.5 translate <0,-eSM*0.5,-zM>}

            object{Spray rotate y*30 translate <-xM+0.3,0,-zM*0.75>}
/* // replace by your own objects
            object{Flacon8 rotate -y*30 translate <-xM*0.6,0,-zM*0.62>}
            object{ToothPaste rotate y*220 translate <-xM*0.5,0,-zM*0.75>}
            object{Coupe rotate y*-31 translate <-xM*0.1,0,-zM*0.75>}
            object{LipStick translate <xM*0.1,0,-zM*0.9>}
            object{LipStick rotate -x*90 translate y*0.01 rotate y*21 translate <xM*0.15,0,-zM*0.8>}
            object{LipStick2 translate <xM*0.17,0,-zM*0.6>}
            object{Flacon6 rotate y*30 translate <xM*0.3,0,-zM*0.6>}
            object{Flacon7 scale <1,1.2,1> rotate -y*80 translate <xM*0.6,0,-zM*0.5>}
            object{Flacon5 rotate -y*80 translate <xM*0.8,0,-zM*0.65>}
*/
            translate y*sM
            translate -z*0.0025
        }                                  
        // Side shelves
        union{
            #declare MirrorSmallShelf=union{
                box{<0,-eSM,-zM>,<sM,0,0>}
                cylinder{0,x*sM,eSM*0.5 translate <0,-eSM*0.5,-zM>}
            }
            object{MirrorSmallShelf translate <-xM,yM1/3,0>}
            object{MirrorSmallShelf translate <-xM,2*yM1/3,0>}
            object{MirrorSmallShelf translate <-xM,yM1/3,0> scale <-1,1,1>}
            object{MirrorSmallShelf translate <-xM,2*yM1/3,0> scale <-1,1,1>}
/* // replace by your own objects
            union{
                object{Flacon2a translate <-0.05,0,0.02>}
                object{Flacon2b translate <0.06,0,-0.01>}
                translate <-xM+sM*0.5,yM1/3,-zM*0.5>
            }
            object{Pot translate <xM-sM*0.4,yM1/3,-zM*0.6>}
            union{
                object{Flacon1 rotate y*80 translate <0.06,0,-0.06>}
                translate <xM-sM*0.5,2*yM1/3,-zM*0.5>            
            }                                         
            union{
                object{Flacon3b translate <0.03,0,-0.07>}
                object{Flacon4 translate <-0.06,0,0.03>}
                object{Flacon3b translate x*0.06}
                translate <-xM+sM*0.3,2*yM1/3,-zM*0.4>
            }
*/
            translate y*sM
            translate -z*0.0025
        }
        // Frame
        box{<-xM-0.001,0,-eM+0.001>,<xM+0.001,yM+0.001,0.001>}
        // Lights
        union{
            difference{
                box{<-xM,0,-zLM>,<xM,yLM,0>}
                union{
                    cylinder{-0.1*x,x*0.1,0.004 translate -0.01*z}
                    cylinder{-0.1*x,x*0.1,0.004 translate 0.01*z}
                    translate <xM,yLM*0.55,-zLM*0.55>
                }
            }    
            // Plug
            union{            
                difference{
                    cylinder{-x*0.02,x*0.008,zLM*0.42}
                    cylinder{-x*0.01,x*0.02,zLM*0.37}
                }        
                union{
                    cylinder{0,x*0.005,0.004}
                    sphere{x*0.005,0.004}
                    texture{T_Gold_2C}
                    translate -y*0.01
                }
                translate <xM,yLM*0.5,-zLM*0.55>
            }
            union{
                box{<-xM+eLM,eLM,-eLM>,<xM-eLM,yLM-eLM,0>}
                cylinder{-x*(xM-eLM),x*(xM-eLM),eLM translate y*eLM}
                cylinder{-x*(xM-eLM),x*(xM-eLM),eLM translate y*(yLM-eLM)}
                cylinder{y*eLM,y*(yLM-eLM),eLM translate -x*(xM-eLM)}
                cylinder{y*eLM,y*(yLM-eLM),eLM translate x*(xM-eLM)}
                sphere{0,eLM translate <xM-eLM,eLM,0>}
                sphere{0,eLM translate <-xM+eLM,eLM,0>}
                sphere{0,eLM translate <xM-eLM,yLM-eLM,0>}
                sphere{0,eLM translate <-xM+eLM,yLM-eLM,0>}
                translate -zLM*z
            }
            object{Lamp(4) rotate y*180 translate <-0.3,yLM*0.5,-zLM>}
            object{Lamp(3.5) rotate y*180 translate <0.3,yLM*0.5,-zLM>}
            translate y*yM
        }
        texture{T_MirrorFrame}
    }
}                 


//============================                     
// Object
//============================                     
object{Mirror translate y*1.1}

