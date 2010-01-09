//==========================================
// Furniture (used in "The thin wall")            
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
//#declare HQOn=0; // turn high-quality radiosity on
//global_settings{
//            radiosity{
//            nearest_count 4      // CHANGE range from 3 to 10
//            #if (HQOn=1) // high-quality radiosity
//                count 200             // CHANGE range from 20 to 150
//                error_bound 0.05        // CHANGE - range from 1 to 3 - should correspond with pretrace_end
//            #else // standard radiosity
//                count 100             // CHANGE range from 20 to 150
//                error_bound 1        // CHANGE - range from 1 to 3 - should correspond with pretrace_end
//            #end    
//            recursion_limit 2    // CHANGE
//            low_error_factor 1  // leave this
//            gray_threshold 0.1   // leave this
//            minimum_reuse 0.015  // leave this
//            brightness 1         // leave this
//            adc_bailout 0.01/2   // CHANGE - use adc_bailo        
//            normal on
//        }
//}        

//#declare PdV=<4, 1.8, -5>;
//camera{
    //location PdV
    //direction z*2.3
    //right     4*x/3
    //look_at   <1, 1,  0>
//}               
//light_source{<-10,10,-10>*10 color White}
//box{<-3,-1,-4>,<3,0,0> texture{pigment{White} finish{ambient 0 diffuse 1}}}
//box{<-3,-1,0>,<3,3,1> texture{pigment{Tan} finish{ambient 0 diffuse 1}}}

//============================                     
// Furniture
//============================                     
#declare T_Furniture=texture{pigment{White} finish{ambient 0 diffuse 1 specular 0.5 roughness 0.08}}
//============================                     
// Drawer face
//============================                     
#macro DrawerFace(xDF,yDF)
    #local eDF=0.005;
    #local eDF2=0.02;
    #local eDF3=eDF2-eDF;
    #local sDF=xDF/17; //0.05;
    #local sDF2=eDF; //0.01;
//    #local xDF=0.4;
    #local xDF0=xDF-4*eDF;
    #local xDF1=xDF0-2*sDF;
    #local xDF2=xDF1-2*eDF2;
    #local xDF3=xDF1-2*(eDF+sDF2);
    #local xDF4=xDF3-2*eDF2;
//    #local yDF=0.7;
    #local yDF0=yDF-4*eDF;
    #local yDF1=yDF0-2*sDF;
    #local yDF2=yDF1-2*eDF2;
    #local yDF3=yDF1-2*(eDF+sDF2);
    #local yDF4=yDF3-2*eDF2;
    #local zDF=0.02;
    #local zDF0=zDF-eDF;
    union{
        box{<0,0,-zDF0>,<xDF,yDF,0>}
        union{
            cylinder{0,y*yDF0,eDF translate <2*eDF,2*eDF,0>}
            cylinder{0,y*yDF0,eDF translate <xDF-2*eDF,2*eDF,0>}
            cylinder{0,x*xDF0,eDF translate <2*eDF,2*eDF,0>}
            cylinder{0,x*xDF0,eDF translate <2*eDF,yDF-2*eDF,0>}
            sphere{0,eDF translate <2*eDF,2*eDF,0>}
            sphere{0,eDF translate <xDF-2*eDF,2*eDF,0>}
            sphere{0,eDF translate <2*eDF,yDF-2*eDF,0>}
            sphere{0,eDF translate <xDF-2*eDF,yDF-2*eDF,0>}
            union{
                box{<0,0,-eDF>,<xDF0,sDF,0>}
                box{<0,0,-eDF>,<xDF0,sDF,0> scale <1,-1,1> translate y*yDF0}
                box{<0,0,-eDF>,<sDF,yDF0-2*sDF,0> translate y*sDF}
                box{<0,0,-eDF>,<sDF,yDF0-2*sDF,0> translate y*sDF scale <-1,1,1> translate x*xDF0}
                union{
                    #local InnerAngle1=union{
                        difference{
                            box{<-eDF-eDF2,0,0>,<0,eDF,eDF+eDF2>}
                            cylinder{-y*eDF,2*y*eDF,eDF2}
                        }
                        difference{
                            torus{eDF2,eDF}
                            plane{z,0}
                            plane{x,0 inverse}
                        }
                        rotate x*-90
                    }
                    cylinder{0,x*xDF2,eDF translate x*eDF2}
                    cylinder{0,x*xDF2,eDF translate <eDF2,yDF1,0>}
                    cylinder{0,y*yDF2,eDF translate y*eDF2}
                    cylinder{0,y*yDF2,eDF translate <xDF1,eDF2,0>}
                    object{InnerAngle1 translate <eDF2,yDF1-eDF2,0>}
                    object{InnerAngle1 scale <-1,1,1> translate <xDF1-eDF2,yDF1-eDF2,0>}
                    object{InnerAngle1 scale <1,-1,1> translate <eDF2,eDF2,0>}
                    object{InnerAngle1 scale <-1,-1,1> translate <xDF1-eDF2,eDF2,0>}
                    
                    union{
                        #local InnerAngle2=difference{
                            union{
                                torus{eDF3,eDF}
                                cylinder{0,y*eDF,eDF3}
                            }
                            plane{z,0}
                            plane{x,0 inverse}
                            rotate x*-90
                        }
                        box{<0,0,-eDF>,<eDF3,yDF4,0> translate <eDF,eDF2,0>}                      
                        box{<0,0,-eDF>,<eDF3,yDF4,0> scale <-1,1,1> translate <xDF3-eDF,eDF2,0>}
                        box{<0,0,-eDF>,<xDF4,eDF3,0> translate <eDF2,eDF,0>}
                        box{<0,0,-eDF>,<xDF4,eDF3,0> scale <1,-1,1> translate <eDF2,yDF3-eDF,0>}
                        box{<0,0,-eDF>,<xDF4,yDF4,0> translate <eDF2,eDF2,0>}
                        cylinder{0,y*yDF4,eDF translate <eDF,eDF2,0>}
                        cylinder{0,y*yDF4,eDF translate <xDF3-eDF,eDF2,0>}
                        cylinder{0,x*xDF4,eDF translate <eDF2,eDF,0>}
                        cylinder{0,x*xDF4,eDF translate <eDF2,yDF3-eDF,0>}
                        object{InnerAngle2 translate <eDF2,yDF3-eDF2,0>}
                        object{InnerAngle2 scale <-1,1,1> translate <xDF3-eDF2,yDF3-eDF2,0>}
                        object{InnerAngle2 scale <1,-1,1> translate <eDF2,eDF2,0>}
                        object{InnerAngle2 scale <-1,-1,1> translate <xDF3-eDF2,eDF2,0>}
                        translate <eDF+sDF2,eDF+sDF2,0>
                    }
                    translate <sDF,sDF,0>
                }
                translate <2*eDF,2*eDF,0>
            }
            translate -z*zDF0
        }
    }
#end


//============================                     
// Button
//============================                     
#declare ButtonDrawer1=union{
    union{
        sphere{0,0.02}
        sphere{0,0.015 translate -z*0.008}
        scale <0.9,1,0.6>
        translate -z*0.04
    }
    cylinder{0,-z*0.04,0.015}
}

//============================                     
// Chest with drawers
//============================                     
#declare xBD1=0.35;
#declare xB1=0.8;
#declare zB1=0.35;
#declare yB1a=0.1;
#declare yB1b=0.02;
#declare yB1=0.8;
#declare yB1d=yB1-yB1a-yB1b;
#declare yDrawer1=yB1d/4;
#declare eB1=0.01;
#declare Drawer1=union{
    object{DrawerFace(xBD1,yDrawer1)}
    difference{
        box{<eB1,eB1*0.5,0>,<xBD1-eB1,yDrawer1-eB1,zB1-eB1>}
        box{<eB1*2,eB1,eB1>,<xBD1-eB1*2,yDrawer1,zB1-eB1*2>}
    }        
    object{ButtonDrawer1 translate <xBD1/2,yDrawer1/2,0>}
    scale <1,0.95,1>
    translate -z*eB1
}                           
#declare Chest1=union{
    box{<0,0,-zB1>,<xB1,yB1a,0>} // bottom
    union{ // sides bottom
        cylinder{0,y*yB1a,eB1*0.5 translate x*eB1*0.5 scale <1,1,1> translate x*0.002}
        cylinder{0,y*yB1a,eB1*0.5 translate -x*eB1*0.5 scale <1,1,1> translate x*(xB1-0.002)}
        translate -z*zB1
    }
    union{ // drawer part
        box{<0,0,-zB1>,<eB1,yB1-yB1a,0>}
        box{<0,0,-zB1-eB1>,<eB1,yB1-yB1a,0> translate x*xBD1}
        box{<0,0,-zB1>,<eB1,yB1-yB1a,0> scale <-1,1,1> translate x*xB1}
        union{
            box{<0,0,-zB1-eB1>,<xB1,yB1b,0>}
            cylinder{0,x,1 translate y scale <xB1,yB1b*0.5,eB1> translate -z*(zB1+eB1)}
            translate y*(yB1-yB1a-yB1b)
        }
        translate y*yB1a
    }
    union{ // drawers
        object{Drawer1 translate -z*0.00 rotate x*-0.5 rotate y*1}        
        object{Drawer1 translate y*yDrawer1 translate -z*0.0 rotate x*-1 rotate -y*0.5}
        object{Drawer1 translate y*yDrawer1*2 translate -z*0.00 rotate x*-1 rotate y*1.5}
        object{Drawer1 translate y*yDrawer1*3 translate -z*0.0 rotate x*-0.5 rotate y*0.5}        
        translate <0,yB1a,-zB1>
    }                                                    
    union{
        object{DrawerFace(xB1-xBD1-eB1,yB1d)}
        object{ButtonDrawer1 translate <xB1-xBD1-0.025,yB1d*0.5,0>}
        rotate y*1 
        scale <-1,1,1>
        translate <xB1,yB1a,-zB1>
    }
    texture{T_Furniture}
}       
//============================                     
// Wardrobe
//============================                     
#declare xB3=0.55;
#declare zB3=0.41;
#declare yB3a=0.1;
#declare yB3b=0.02;
#declare yB3c=0.8;
#declare yB3d=yB3c-yB3a-yB3b;
#declare yDrawer3=yB3d/5;
#declare yB3d=1.3;
#declare yB3=yB3c+yB3d;
#declare eB3=0.01;
#declare ButtonDrawer3=union{
    union{
        sphere{0,0.02}
        sphere{0,0.015 translate -z*0.008}
        scale <0.9,1,0.6>
        translate -z*0.04
    }
    cylinder{0,-z*0.04,0.015}
}
#declare Drawer3=union{
    object{DrawerFace(xB3,yDrawer3)}
    difference{
        box{<eB3,eB3*0.5,0>,<xB3-eB3,yDrawer3-eB3,zB3-eB3>}
        box{<eB3*2,eB3,eB3>,<xB3-eB3*2,yDrawer3,zB3-eB3*2>}
    }        
    object{ButtonDrawer3 translate <xB3/2,yDrawer3/2,0>}
    scale <1,0.95,1>
    translate -z*eB3
}                           

#declare Wardrobe=union{
    box{<0,0,-zB3>,<xB3,yB3a,0>}
    union{
        cylinder{0,y*yB3a,eB3*0.5 translate x*eB3*0.5 scale <1,1,1> translate x*0.002}
        cylinder{0,y*yB3a,eB3*0.5 translate -x*eB3*0.5 scale <1,1,1> translate x*(xB3-0.002)}
        translate -z*zB3
    }
    union{
        box{<0,0,-zB3>,<eB3,yB3c-yB3a,0>}
        box{<0,0,-zB3>,<eB3,yB3c-yB3a,0> scale <-1,1,1> translate x*xB3}
        union{
            box{<0,0,-zB3-eB3>,<xB3,yB3b,0>}
            cylinder{0,x,1 translate y scale <xB3,yB3b*0.5,eB3> translate -z*(zB3+eB3)}
            translate y*(yB3c-yB3a-yB3b)
        }
        translate y*yB3a
    }
    union{              
        object{Drawer3 translate -z*0.008 rotate x*-0.5 rotate y*1}        
        object{Drawer3 translate y*yDrawer3 translate -z*0.01 rotate x*-1 rotate -y*0.5}
        object{Drawer3 translate y*yDrawer3*2 translate -z*0.05 rotate x*-5 rotate y*2.5}
        object{Drawer3 translate y*yDrawer3*3 translate -z*0.0 rotate x*-0.5 rotate y*0.5}        
        object{Drawer3 translate y*yDrawer3*4 translate -z*0.005 rotate x*-0.1 rotate -y*2}        
        translate <0,yB3a,-zB3>
    }
    union{
        box{<0,0,-zB3>,<eB3,yB3d,0>}
        box{<0,0,-zB3>,<eB3,yB3d,0> scale <-1,1,1> translate x*xB3}
        box{<0,0,-zB3*0.9>,<xB3,eB3,0> scale <1,-1,1> translate y*yB3d*0.25}
        box{<0,0,-zB3*0.9>,<xB3,eB3,0> scale <1,-1,1> translate y*yB3d*0.5}
        box{<0,0,-zB3*0.9>,<xB3,eB3,0> scale <1,-1,1> translate y*yB3d*0.75}
        box{<0,0,-zB3>,<xB3,eB3,0> scale <1,-1,1> translate y*yB3d}
        union{
            object{DrawerFace(xB3,yB3d)}
            object{ButtonDrawer3 translate <xB3-0.03,yB3d*0.5,0>}
            rotate y*2 translate -z*zB3
        }
        
        translate y*yB3c
    }                     
    texture{T_Furniture}
}       

//============================                     
// Slatted chest
//============================                     
#declare xB4=0.6;
#declare xBD4=xB4/2;
#declare zB4=0.16;
#declare zBD4=0.015;
#declare eB4=0.015;
#declare zB41=zB4-zBD4;     
#declare yB4=0.567;
#declare eBD4=0.05;
#declare ButtonChest4=blob{
        threshold 0.6        
        sphere{0,0.04,1 scale <1,1,0.7> translate -z*0.03}
        sphere{0,0.015,-1 translate -z*0.009 scale <1,1,0.7> translate -z*0.03}
        cylinder{0,-z*0.03,0.015,1}
        texture{T_Gold_1C}
}   
#declare T_Chest4=texture{
    pigment{rgb<1,0.9,0.95>}
    finish{ambient 0 diffuse 1 specular 0.8 roughness 0.1}
}

#declare Chest2=union{
    difference{
        box{<0,0,-zB4>,<xB4,yB4,0>}
        box{<eB4,eB4,-zB4-eB4>,<xB4-eB4,yB4-eB4,-eB4>}
    }        
    #declare DoorB4=union{
        #declare rd=seed(0);
        box{<0,0,-zBD4>,<xBD4,eBD4,0>}
        box{<0,0,-zBD4>,<xBD4,eBD4,0> scale <1,-1,1> translate y*yB4}
        box{<0,0,-zBD4>,<eBD4,yB4,0> translate -z*0.00001}
        box{<0,0,-zBD4>,<eBD4,yB4,0> translate -z*0.00001 scale <-1,1,1> translate x*xBD4}
        object{ButtonChest4 translate <xBD4-eBD4*0.5,yB4*0.5,-zBD4>}
        #declare xBD41=xBD4-2*eBD4;
        #declare yBD41=yB4-2*eBD4;
        #declare i=0;
        #declare n=23;
        #declare eBS4=0.005;
        #declare yBS4=yBD41/n;
        #declare Slat4=box{<0,0,0>,<xBD41,yBS4,eBS4>}
        union{
            #while (i<n)
                object{Slat4 rotate x*(10+(0.5-rand(rd))*3) translate <0,i*yBD41/n,-zBD4*0.9>
                    texture{T_Chest4 translate 5*<rand(rd),rand(rd),1>}
                }
                #declare i=i+1;
            #end
            translate <eBD4,eBD4,0>
        }
        scale <0.97,1,1>
        
    }
    object{DoorB4 rotate y*1 translate -z*zB41}
    object{DoorB4 scale <-1,1,1> rotate -y*0.5 translate <xB4,0,-zB41>}
    texture{T_Chest4}
} 
//==========================================
// Objects
//==========================================
//union{
    //object{Wardrobe}
    //object{Chest1 translate x*0.7}
    //object{Chest2 translate x translate y*1.3}
    //translate -z*0.02
//}
