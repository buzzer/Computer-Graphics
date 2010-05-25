//=========================================
// Broken egg shape and texture
// -----------------------------------------
// Made for Persistence of vision 3.6
//==========================================  
// Copyright 2003 Gilles Tran http://www.oyonale.com
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
global_settings{
    assumed_gamma 1
    radiosity{
        count 200 error_bound 0.1
        recursion_limit 3
        brightness 1
        normal on
    }
}
camera { location -z*40+y*15 direction z*2.3 look_at y*5}

#declare C_Sun=rgb<0.95,0.91,0.78>;
#declare C_Lum=C_Sun;
light_source {-z*100 color C_Lum*1.4 rotate x*70 rotate y*110
    area_light 3*x,3*z 10,10 jitter adaptive 3
}


//==============================================
// Egg
//==============================================
#declare C_Egg=C_Sun*0.8+<0.2,0.0,0.0>;
#declare T_Egg=texture{
    pigment{
        bozo
        pigment_map{
            [0 C_Egg]
            [0.5 C_Egg]
        }
    }
    normal{granite 0.1 scale 1/20}
    finish {ambient 0.05 diffuse 1 specular 0.1 roughness 0.1 }
}
#declare Egg=sphere{0,7.5 scale <0.65,0.98,0.65>}

#declare EggInt=sphere{0,7.45 scale <0.65,0.98,0.65>}

#declare EggHole=prism {
    linear_spline
    conic_sweep 
    0,   8,  21,
    <-2.2 ,0>,<-3.1,  2.05>,<-2.1,1.9>,<-1.85,3.12>,<-1.12, 3.25>,<0.2,  4.5>,<-0.12,  3.17>,
    < 2.32, 3.22>,<1.07, 2.471>,<3.01,  1.21>,<1.51,0.22>,<3.11,-0.875>,<1.29,-1.23>,
    <2.11,-1.54>,<0.81,-1.32>,<-0.412,-3.12>,<-1.21,-2.05>,<-0.899,-4.21>,<-2.05,-2.61>,
    <-4.33,-2.12>,<-2.2 ,0>
    scale <0.25,1,0.25>
}                        


#declare EggBroken=difference{
   object{Egg}
   object{EggHole}
   object{EggInt}
   texture{T_Egg}
}

object{EggBroken rotate z*80 rotate -y*135 translate y*5.5}
plane{y,0 texture{pigment{White} finish{ambient 0 diffuse 1}}}