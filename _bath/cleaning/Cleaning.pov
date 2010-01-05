//==========================================
// Various cleaning stuff
// bottles, sponge, wash basin, shelves
// Unit is meter
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
#include "colors.inc"
#include "textures.inc"
#include "metals.inc"
#include "functions.inc"
camera{
    location  <-1, 1.8, -3>
    direction z*1.5
    right     x*image_width/image_height
    look_at   <0.1, 0.9,  0>
}               
//background{rgb<1,0.98,0.96>}
light_source{<-10,10,-10>*10 color White}
light_source{<-1, 1.9, -3> color White*0.4 shadowless}
union{
    box{<-2,-1,-2>,<3,0,1> texture{pigment{checker color Black,color rgb<1,0.98,0.96>} 
    normal{checker bump_size -0.05} 
    finish{ambient 0 diffuse 1 reflection 0.1} scale 0.3 rotate y*45}}
    box{<-2,-1,0>,<3,3,1> texture{pigment{rgb<1,0.98,0.96>} finish{ambient 0 diffuse 1}}}
}

//==========================================
// WC shelves
//==========================================
#declare T_WCShelf=texture{
    pigment{White*1.5}
    finish{ambient 0 diffuse 1 specular 1 roughness 0.001}
}
//==============================
// WC shelves
//==============================
#declare WCShelves=union{
    #declare xWC=0.75; // width
    #declare rWC=xWC*0.5; // corner radius
    #declare rWC3=0.07; // inner corner radius
    #declare zWC=0.27; // depth
    #declare yWC=1.84; // full height
    #declare yWC3=yWC-rWC; // height last shelf (3)
    #declare yWC1=0.93; // height first shelf (1)
    #declare yWC2=(yWC3-yWC1)*0.5+yWC1; // height middle shelf (2)
    #declare rWC1=0.008; // main spike radius
    #declare rWC2=0.005; // secondary spike raidus
    #declare rEWC=0.03; // radius shelf corner
    #declare xEWC=xWC-2*rEWC; // width shelf
    #declare zEWC=zWC-2*rEWC; // depth shelf
    
    #declare WCShelvesSide=union{ // side
        cylinder{0,y*yWC3,rWC1}
        union{
            sphere{y*(yWC3+0.015),rWC1}
            cylinder{0,y*(yWC3+0.015),rWC1}
            translate -z*zWC
        }
        cylinder{-z*zWC,0,rWC1 translate y*yWC1*0.33}
        cylinder{-z*zWC,0,rWC1 translate y*yWC1*0.67}
        union{ // rubber feet
            cylinder{0,y*0.01,rWC1*1.4}
            cylinder{0,y*0.01,rWC1*1.4 translate -z*zWC}
            texture{
                pigment{White*0.1}
                finish{ambient 0 diffuse 1}
            }
        }
    }
    #declare WCShelf=union{ // single shelf
        cylinder{-x*xEWC*0.5,x*xEWC*0.5,rWC1}
        cylinder{-x*xEWC*0.5,x*xEWC*0.5,rWC1 translate -z*zWC}
        cylinder{0,-z*zEWC,rWC1 translate -x*rWC-z*rEWC}
        cylinder{0,-z*zEWC,rWC1 translate x*rWC-z*rEWC}
        difference{torus{rEWC,rWC1} plane{z,0} plane{x,0 inverse} translate <-xEWC*0.5,0,-rEWC>}
        difference{torus{rEWC,rWC1} plane{z,0} plane{x,0 inverse} translate <-xEWC*0.5,0,-rEWC> scale <-1,1,1>}
        difference{torus{rEWC,rWC1} plane{z,0} plane{x,0 inverse} translate <-xEWC*0.5,0,-rEWC> scale <1,1,-1> translate -z*zWC}
        difference{torus{rEWC,rWC1} plane{z,0} plane{x,0 inverse} translate <-xEWC*0.5,0,-rEWC> scale <-1,1,1>scale <1,1,-1> translate -z*zWC}
        #declare n=15;
        #declare i=0;
        #while (i<=n)
            cylinder{0,-z*zWC,rWC2 translate -x*xEWC*0.5+i*x*xEWC/n}
            #declare i=i+1;
        #end
    }
    union{
        object{WCShelvesSide translate -x*rWC}
        object{WCShelvesSide translate x*rWC}
        object{WCShelf translate y*yWC1}
        object{WCShelf translate y*yWC2}
        object{WCShelf translate y*yWC3}
        
    }
    union{ // back top
        union{
            difference{torus{rWC,rWC1 rotate x*90}plane{y,0}}
            difference{torus{rWC3,rWC1 rotate x*90}plane{y,0}}
            union{
                difference{torus{(rWC-rWC3)*0.5,rWC2 rotate z*90}plane{z,0 inverse} translate y*(rWC3 + (rWC-rWC3)*0.5) rotate z*60}
                difference{torus{(rWC-rWC3)*0.5,rWC2 rotate z*90}plane{z,0 inverse} translate y*(rWC3 + (rWC-rWC3)*0.5) rotate z*30}
                difference{torus{(rWC-rWC3)*0.5,rWC2 rotate z*90}plane{z,0 inverse} translate y*(rWC3 + (rWC-rWC3)*0.5)}
                difference{torus{(rWC-rWC3)*0.5,rWC2 rotate z*90}plane{z,0 inverse} translate y*(rWC3 + (rWC-rWC3)*0.5) rotate -z*30}
                difference{torus{(rWC-rWC3)*0.5,rWC2 rotate z*90}plane{z,0 inverse} translate y*(rWC3 + (rWC-rWC3)*0.5) rotate -z*60}
                scale <1,1,0.5>
            }
            translate y*yWC3
        }
        union{
            cylinder{0,y*(yWC3-yWC1),rWC1 translate -x*rWC3}
            cylinder{0,y*(yWC3-yWC1),rWC1}
            cylinder{0,y*(yWC3-yWC1),rWC1 translate x*rWC3}
            translate y*yWC1
        }
    }
    texture{T_WCShelf}
}
//==========================================
// Toilet paper rolls
//==========================================
#declare PaperRoll=union{
    #declare yPaperRoll=0.1;
    #declare rPaperRoll=0.05;
    difference{
        isosurface{
            function{x*x+z*z-1+0.3*f_noise3d(x*2,y*2,z*2)}
            threshold 0
            contained_by{box{<-1,0,-1>,<1,1,1>}}
        }               
        cylinder{-y*0.1,y*1.1,0.45}
    }
    difference{cylinder{y*0.001,y*0.999,0.45}cylinder{-y*0.1,y*1.1,0.42} texture{pigment{White}finish{ambient 0 diffuse 1}}}
    scale <rPaperRoll,yPaperRoll,rPaperRoll>
}
#declare C_PaperRoll1=Pink*1.4;
#declare C_PaperRoll2=rgb <0.7,1,1>;
#declare T_PaperRoll1=texture{
    pigment{C_PaperRoll1}
    finish{ambient 0 diffuse 1}
}    
#declare T_PaperRoll2=texture{
    pigment{C_PaperRoll2}
    finish{ambient 0 diffuse 1}
}    
#declare T_PaperRoll3=texture{
    pigment{
        gradient y
        pigment_map{
            [0 wood turbulence 0.02 color_map{[0 C_PaperRoll1][1 C_PaperRoll1*0.5]} rotate x*90 scale 0.025]
            [0.0001 color C_PaperRoll1]
            [1 color C_PaperRoll1]
        }
    }        
    finish{ambient 0 diffuse 1}
    scale <rPaperRoll,yPaperRoll*1.1,rPaperRoll>
}    
#declare T_PaperRoll4=texture{
    pigment{
        gradient y
        pigment_map{
            [0 wood turbulence 0.02 color_map{[0 C_PaperRoll2][1 C_PaperRoll2*0.5]} rotate x*90 scale 0.025]
            [0.0001 color C_PaperRoll2]
            [1 color C_PaperRoll2]
        }
    }        
    finish{ambient 0 diffuse 1}
    scale <rPaperRoll,yPaperRoll*1.1,rPaperRoll>
}    

//==============================
// PaperRolls
//==============================
#declare PaperRoll1=object{PaperRoll texture{T_PaperRoll1}} // pink vertical
#declare PaperRoll2=object{PaperRoll texture{T_PaperRoll2}} // blue vertical
#declare PaperRoll3=object{PaperRoll texture{T_PaperRoll3} rotate x*90} // pink horizontal
#declare PaperRoll4=object{PaperRoll texture{T_PaperRoll4} rotate x*90} // blue horizontal

//==============================
// Bottle 1
//==============================
#declare WCBottle1=union{
    blob{
        threshold 0.6
        sphere{0,1,1 scale <2,1,1>}
        sphere{0,1,1 scale <2,1,1> translate y}
        sphere{0,1,1 scale <2,1,1> translate y*2}
        sphere{0,1,1 scale <2,1,1> translate y*3}
        sphere{0,1,1 scale <2,1,1> translate y*4}
        sphere{0,0.5,1 scale <2,1,1> translate y*4.5}
        cylinder{y*4.5,y*5,0.5,1}
    }    
    difference{
        cylinder{0,y,1}
        #declare i=0;
        #while (i<360)
            cylinder{y*0.1,y*0.9,0.05 translate x rotate y*i}
            #declare i=i+10;
        #end
        sphere{0,1 scale <1,0.2,1>*0.8 translate y}
        scale 0.5*<1,1,0.8> translate y*4.7
        texture{pigment{Red} finish{ambient 0 diffuse 1}}
    }
//    texture{pigment{rgb <0.75,0.9,1>} finish{ambient 0 diffuse 1 specular 0.001 roughness 0.02}}
    texture{pigment{image_map{png "bwcmap1" map_type 2}} finish{ambient 0 diffuse 1 specular 0.001 roughness 0.02} scale 5 rotate y*-80}
    clipped_by{cylinder{0,y*5.5,2}}
    scale 0.045*<1,1,1.4>
}    
//==============================
// Bottle 2
//==============================
#declare eBWC2=0.12;
#declare WCBottle2a=lathe{
	cubic_spline
	17,	
	<0.008685,0.996633>,	<0.013028,0.996633>,	<0.102052,0.998805>,	<0.115080,0.981434>,
	<0.117251,0.920637>,	<0.102052,0.903267>,	<0.097709,0.881554>,	<0.099880,0.848984>,
	<0.160677,0.701335>,	<0.225817,0.553685>,	<0.290956,0.406036>,	<0.308327,0.299641>,
	<0.299641,0.167191>,	<0.260558,0.082510>,	<0.156335,0.010857>,	<0.021713,0.000000>,	<0.002171,0.013028>
	sturm
}
#declare WCBottle2=union{
    difference{
        object{WCBottle2a}
        plane{z,-eBWC2}
        plane{z,eBWC2 inverse}
    }        
    union{
        difference{
            object{WCBottle2a}
            plane{z,-eBWC2 inverse}
            translate z*eBWC2
            scale <1,1,0.2>
            translate -z*eBWC2
        }        
        difference{
            object{WCBottle2a}
            plane{z,-eBWC2 inverse}
            translate z*eBWC2
            scale <1,1,0.2>
            translate -z*eBWC2
            scale <1,1,-1>
        }        
    }
    texture{
        gradient y
        texture_map{
//            [0.87 pigment{Yellow} finish{ambient 0 diffuse 1 specular 0.5 roughness 0.001}]
            [0.87 pigment{image_map{png "bwcmap2" map_type 0}}  finish{ambient 0 diffuse 1 specular 0.5 roughness 0.001 reflection 0.1} translate -x*0.5 scale 0.87*<0.8,1,1>]
            [0.87 pigment{White} finish{ambient 0 diffuse 1}]
        }
    }
    scale 0.19
}               
//==============================
// Bottle 3
//==============================
#declare WCBottle3a=lathe{
	cubic_spline
	19,
	<0.008906,0.997527>,	<0.028946,0.995301>,	<0.111331,0.999754>,	<0.115784,0.986394>,
	<0.118011,0.966355>,	<0.131371,0.852797>,	<0.109105,0.834984>,	<0.086838,0.828304>,
	<0.131371,0.810491>,	<0.140277,0.627908>,	<0.129144,0.483177>,	<0.122464,0.354033>,
	<0.120238,0.233795>,	<0.118011,0.129144>,	<0.118011,0.048986>,	<0.113558,0.015586>,
	<0.097971,0.002227>,	<0.022266,0.000000>,	<0.011133,0.000000>
	sturm
	texture{
	    gradient y
        texture_map{
            [0.845 pigment{image_map{png "bwcmap3a" map_type 2}}  finish{ambient 0 diffuse 1 specular 0.5 roughness 0.001 reflection 0.1} scale 0.845]
            [0.845 pigment{Orange} finish{ambient 0 diffuse 1 specular 0.5 roughness 0.001}]
        }
	}
    scale 0.213
}               
#declare WCBottle3b=lathe{
	cubic_spline
	19,
	<0.008906,0.997527>,	<0.028946,0.995301>,	<0.111331,0.999754>,	<0.115784,0.986394>,
	<0.118011,0.966355>,	<0.131371,0.852797>,	<0.109105,0.834984>,	<0.086838,0.828304>,
	<0.131371,0.810491>,	<0.140277,0.627908>,	<0.129144,0.483177>,	<0.122464,0.354033>,
	<0.120238,0.233795>,	<0.118011,0.129144>,	<0.118011,0.048986>,	<0.113558,0.015586>,
	<0.097971,0.002227>,	<0.022266,0.000000>,	<0.011133,0.000000>
	sturm
	texture{
	    gradient y
        texture_map{
            [0.845 pigment{image_map{png "bwcmap3b" map_type 2}}  finish{ambient 0 diffuse 1 specular 0.5 roughness 0.001 reflection 0.1} scale 0.845]
            [0.845 pigment{Orange} finish{ambient 0 diffuse 1 specular 0.5 roughness 0.001}]
        }
	}
    scale 0.213
}               
//==============================
// Bottle 4
//==============================
#declare eBWC4=0.07;
#declare WCBottle4a=lathe{
	cubic_spline
	23,
	<0.006564,0.995492>,	<0.013127,0.997680>,	<0.061261,0.997680>,	<0.061261,0.967049>,
	<0.061261,0.940795>,	<0.059073,0.927667>,	<0.039382,0.918916>,	<0.052509,0.912352>,
	<0.061261,0.899225>,	<0.078764,0.881721>,	<0.113771,0.842339>,	<0.142213,0.789830>,
	<0.150965,0.695750>,	<0.105019,0.566665>,	<0.102831,0.466022>,	<0.146589,0.312869>,
	<0.196911,0.190347>,	<0.214414,0.109395>,	<0.214414,0.056885>,	<0.185971,0.017503>,
	<0.148777,0.004376>,	<0.026255,0.000000>,	<0.004376,0.002188>
	sturm
}
#declare WCBottle4=union{
    difference{
        object{WCBottle4a}
        plane{z,-eBWC4}
        plane{z,eBWC4 inverse}
    }        
    union{
        difference{
            object{WCBottle4a}
            plane{z,-eBWC4 inverse}
            translate z*eBWC4
            scale <1,1,0.4>
            translate -z*eBWC4
        }        
        difference{
            object{WCBottle4a}
            plane{z,-eBWC4 inverse}
            translate z*eBWC4
            scale <1,1,0.4>
            translate -z*eBWC4
            scale <1,1,-1>
        }        
    }
    texture{
        gradient y
        
        texture_map{
            [0.92 pigment{image_map{png "bwcmap4" map_type 2}}  finish{ambient 0 diffuse 1 specular 0.5 roughness 0.001 reflection 0.1} scale 0.92 rotate y*157]
            [0.92 pigment{White} finish{ambient 0 diffuse 1}]
        }
        
    }
    scale 0.235
}               
//==============================
// Little box
//==============================
#declare xBWC=0.062;
#declare yBWC=0.043;
#declare WCBox=superellipsoid{
    <0.2,0.2>
    texture{pigment{spiral2 5 color_map{[0.5 White][0.5 SeaGreen]}} finish{ambient 0 diffuse 1} scale 0.7}
    translate y
    scale <xBWC*0.5,yBWC*0.5,xBWC*4/3>
}
//==============================
// Sponge
//==============================    
#declare fHole=function{pigment{bozo color_map{[0 White][0.3 White][0.7 White*0.4]} scale 0.05*<1,2,1>}}
#declare colSponge=rgb<1,1,0.41>;
#declare Sponge=isosurface{
    function{x*x+y*y+z*z-1+0.3*fHole(x,y,z).gray+0.4*f_noise3d(x*2,y*2,z*2)}
    threshold 0
    max_gradient 48
    contained_by{sphere{0,1.3}}
    texture{
        pigment{colSponge}
        finish{ambient 0 diffuse 1 specular 0.001 roughness 0.001}
    }
    rotate x*180
    translate y*0.7
    scale 0.15*<1,0.5,1>
}               
//==============================
// Basin
//==============================    
#declare Basin=lathe{
	cubic_spline
	17,
	<0.000000,0.100585>,	<0.017750,0.059168>,	<0.668598,0.065085>,	<0.846101,0.124253>,
	<0.869768,0.544345>,	<0.893436,0.662681>,	<0.952604,0.710015>,	<1.005855,0.727765>,
	<1.029522,0.686348>,	<1.011771,0.615346>,	<0.958520,0.639014>,	<0.923020,0.508844>,
	<0.917103,0.218921>,	<0.875685,0.041418>,	<0.692265,0.005917>,	<0.029584,0.000000>,
	<0.023667,-0.017750>
	scale 0.17
	texture{pigment{rgb<0.8,1,0.94>} finish{ambient 0 diffuse 1 specular 0.001 roughness 0.09}}
}
#declare colBasin1=rgb<0.3,0.5,1>;
#declare colBasin2=rgb<1,1,0.4>;
#declare colBasin3=rgb<1,0.4,0.3>;
#declare txtBasin1=texture{
    pigment{
        bozo             
        turbulence 1
        color_map{
            [0.3 colBasin1]
            [0.6 colBasin1*0.8]
        }
    }                              
    normal{bumps 0.1}
    finish{ambient 0 diffuse 1 specular 0.001 roughness 0.09}
    scale 0.2
}
#declare txtBasin2=texture{
    pigment{
        bozo             
        turbulence 1
        color_map{
            [0.3 colBasin2]
            [0.6 colBasin2*0.8]
        }
    }                              
    normal{bumps 0.1}
    finish{ambient 0 diffuse 1 specular 0.001 roughness 0.09}
    scale 0.2
}
#declare txtBasin3=texture{
    pigment{
        bozo             
        turbulence 1
        color_map{
            [0.3 colBasin3]
            [0.6 colBasin3*0.8]
        }
    }                              
    normal{bumps 0.1}
    finish{ambient 0 diffuse 1 specular 0.001 roughness 0.09}
    scale 0.2
}
#declare Basins=union{
    object{Basin texture{txtBasin1}}
    object{Basin texture{txtBasin2 translate 5} rotate z*-15 translate <-0.03,0.1,0>}
    object{Basin texture{txtBasin3 translate 10} rotate z*-5 rotate x*-10 translate <0.01,0.2,0>}
}

//==============================
// Shelves with all the objects
//==============================
union{
    object{WCShelves}
    // 1st shelf
    union{                                                          
        object{PaperRoll3 rotate z*90 translate y*(rPaperRoll-0.005) rotate -y*5 translate -x*rPaperRoll*5 translate z*0.075}
        object{PaperRoll3 rotate -z*40 translate y*(rPaperRoll-0.005) rotate -y*8 translate -x*rPaperRoll*3.1 translate z*0.09}
        object{PaperRoll3 rotate -z*10 translate y*(rPaperRoll+(2*rPaperRoll*cos(pi/6))-0.01) rotate -y*8 translate x*rPaperRoll*(-3.1-(5-3.1)*0.5) translate z*0.066}
        object{PaperRoll1 rotate y*10 translate -x*rPaperRoll*0.15 translate z*0.065}
        object{PaperRoll1 rotate -y*70 translate -x*rPaperRoll*1.15 translate z*0.165}
        
        object{PaperRoll4 rotate z*80 translate y*(rPaperRoll-0.005) rotate y*20 translate x*rPaperRoll*1.5 translate z*0.034}
        object{PaperRoll2 rotate y*120 translate x*rPaperRoll*3.8 translate z*0.07}
        object{PaperRoll2 rotate -y*90 translate x*rPaperRoll*5.7 translate z*0.08}
        object{PaperRoll4 rotate z*80 translate y*(rPaperRoll+yPaperRoll-0.005) rotate -y*47 translate x*rPaperRoll*5.5 translate z*0.055}
        translate <0,yWC1+rWC2,-zWC>
    }
    // 2nd shelf
    union{
        object{WCBottle4 rotate -y*31 rotate -z*6 translate <-rWC*0.85,0,-0.07>}
        object{WCBottle1 rotate -x*90 rotate y*13 translate <-rWC*0.6,0.04,0.1>}
        object{WCBottle3b rotate y*132 rotate z*30 translate <-rWC*0.45,0,0.165>}
        object{WCBottle3a rotate -y*92 rotate -z*3 translate <-rWC*0.4,0,0.065>}
        object{WCBottle3b rotate -y*12 rotate -z*0.2 translate <-rWC*0.21,0,-0.065>}
        object{WCBottle1 rotate y*43 rotate z*0.5 translate <rWC*0.05,0,-0.01>}
        object{WCBottle2 rotate -y*23 rotate z*5 translate <rWC*0.36,0,-0.035>}
        union{
            object{WCBox rotate y*12}
            object{WCBox rotate y*22 translate y*yBWC}
            object{WCBox rotate -y*32 translate y*yBWC*2}
            rotate y*21
            translate <rWC*0.8,0,-0.035>
        }
        translate <0,yWC2,-zWC*0.5>
    }
    // 3rd shelf
    union{               
        object{Sponge scale 0.7 rotate y*22 translate <-rWC*0.7,0,0.02>}
        object{Basins scale 0.8 rotate y*5  translate <rWC*0.6,rWC1,-0.02>}
        object{Sponge scale 0.7 rotate z*50 rotate y*-60 translate <rWC*0.8,0.2,0.02>}
        translate <0,yWC3,-zWC*0.7>
    }
    translate -z*0.05
}

