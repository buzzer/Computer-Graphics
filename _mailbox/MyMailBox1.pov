 // POV-Ray 3.6 Scene File "MyMailBox1"
// author:  Maryam Reza
// Date: Dec 2009
//---------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"  


#declare POST_WIDTH = 1.5;
#declare POST_HEIGHT = 10.0;
#declare MB_WIDTH = 3.0;
#declare MB_LENGTH = 6.0;
#declare MB_HEIGHT = 3.0;
                          
#if (version < 3.7) global_settings{ assumed_gamma 1.2 } #end
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
                          



//Lightsource---------------------------------------------
light_source { <10.0, 0.0, 25.0> color White }
//light_source{ <1000,1000,-1500> color White}
light_source { <0.0, 0.0, POST_HEIGHT+0.95*MB_HEIGHT> Gray50 }



//camera-------------------------------------------------
camera {
// location <7.0, 7.0, 13.0>
 location <7.0+50*abs(sin(pi*clock)), 7.0, 13.0>
 rotate z*360*clock
 sky z
 look_at <0.0, 0.0, POST_HEIGHT+MB_HEIGHT/2>
 
}


 
                 
//sky------------------------------------------
plane{z,2.109 
       texture{pigment{Bright_Blue_Sky quick_color Blue scale 3.5 translate<8,0,10>}
	       finish {ambient 1 diffuse 0} }      
       scale 10000}

       

//see----------------------------- 

background { color SkyBlue }
plane {
 z,0
 color YellowGreen
 finish {ambient 1000 diffuse 10000}
}

plane {<0, 3.0, 26>, -4.8
   texture {
      pigment {
         color rgb <0,0.8,3.4024>
         
      }
   }
   finish {ambient 0.6 diffuse 0.22}
   scale 2008 
}  
     

      
      
//ground1----------------------------------------
plane{z, 0.6
      texture{pigment{color rgb<0,1,0.03>}
              normal {bumps 0.013 scale .015}
              finish {ambient 0.3 diffuse 0.65 phong 0.1}}
 } 
 
 
 //ground2----------------------------------------
plane{ <0.04, 0.6 , 38 >, -9
      texture{pigment{color rgb<0.5,0.5,0.7>}
              normal {bumps 0.013 scale .015}
              finish {ambient 1.1 diffuse 0.65 phong 0.1}}
 }  




//mailbox construction--------------------------------------------

box {
 < -POST_WIDTH/2.0, -POST_WIDTH/2.0, 0.0 >,
 < POST_WIDTH/2.0, POST_WIDTH/2.0, POST_HEIGHT >
 pigment { DMFWood4 }
}
#declare mb_side = polygon { 5,
 < 0.0, -MB_LENGTH/2.0, 0.0 >,
 < 0.0, MB_LENGTH/2.0, 0.0 >,
 < 0.0, MB_LENGTH/2.0, MB_HEIGHT/2.0 >,
 < 0.0, -MB_LENGTH/2.0, MB_HEIGHT/2.0 >,
 < 0.0, -MB_LENGTH/2.0, 0.0 >
}
#declare mb_bottom = polygon { 5,
 < -MB_WIDTH/2.0, -MB_LENGTH/2.0, 0.0 >,
 < MB_WIDTH/2.0, -MB_LENGTH/2.0, 0.0 >,
 < MB_WIDTH/2.0, MB_LENGTH/2.0, 0.0 >,
 < -MB_WIDTH/2.0, MB_LENGTH/2.0, 0.0 >,
 < -MB_WIDTH/2.0, -MB_LENGTH/2.0, 0.0 >
}
#declare mb_end = union {
polygon { 5,
 < -MB_WIDTH/2.0, 0.0, 0.0 >,
 < MB_WIDTH/2.0, 0.0, 0.0 >,
 < MB_WIDTH/2.0, 0.0, MB_HEIGHT/2.0 >,
 < -MB_WIDTH/2.0, 0.0, MB_HEIGHT/2.0 >,
 < -MB_WIDTH/2.0, 0.0, 0.0 >
}
disc {
 < 0.0, 0.0, MB_HEIGHT/2.0 >, y, MB_HEIGHT/2.0
}
}
#declare mb_top = intersection {
 box {
  < -2,-1, 0 >
  < 2, 1, 2 >
  pigment { color  green 1.0 blue 1.0
        filter 1.0 }
 }
 
 Cylinder_Y
 scale <MB_WIDTH/2.0, MB_LENGTH/2.0, MB_WIDTH/2.0>
}
global_settings { max_trace_level 20 }
#declare STAFF_HEIGHT = 3.0;
#declare STAFF_WIDTH = 0.30;
#declare FLAG_HEIGHT = 1.0;
#declare FLAG_WIDTH = 1.5;

declare mb_flag = polygon { 7,
 < 0.0, 0.0, 0.0 >,
 < 0.0, -STAFF_HEIGHT, 0.0 >,
 < 0.0, -STAFF_HEIGHT, -FLAG_WIDTH+STAFF_WIDTH >,
 < 0.0, -STAFF_HEIGHT+FLAG_HEIGHT,
        -FLAG_WIDTH+STAFF_WIDTH >,
 < 0.0, -STAFF_HEIGHT+FLAG_HEIGHT, -STAFF_WIDTH >,
 < 0.0, 0.0, -STAFF_WIDTH >,
 < 0.0, 0.0, 0.0 >
 pigment { color Red }
 finish { ambient 0.85 }
 
}

#declare sign = union {
text { ttf "timrom.ttf" "  Reza" 0.0, 0.0
 pigment { Red }
 finish {
  ambient 1000
  diffuse 2000
 }
 translate <0.32, 0.175, 0.0>
}
polygon { 5,
 < 0.0, 0.0, 0.0 >,
 < 3.0, 0.0, 0.0 >,
 < 3.0, 1.0, 0.0 >,
 < 0.0, 1.0, 0.0 >,
 < 0.0, 0.0, 0.0 >
 pigment { White }
}
}
union {
 object { mb_bottom }
 object {
  mb_side translate < -MB_WIDTH/2.0, 0.0, 0.0>
 }
 object {
  mb_side translate < MB_WIDTH/2.0, 0.0, 0.0>
 }
 object {
  mb_end
  translate < 0.0, -0.5*MB_LENGTH, 0.0 >
 }
 object {
  mb_end
  rotate < -90.0*clock, 0.0, 0.0 > // open the mailbox<<<<<<
  translate < 0.0, 0.475*MB_LENGTH, 0.0 >
 }
object {
  mb_top
  translate < 0.0, 0.0, MB_HEIGHT/2.0 >
 }
 object {
  sign
  scale 0.9
  rotate <90, 0, -90>
  translate <0, 1.5, MB_HEIGHT>
 }
 object {
  mb_flag // rotate the flag-----------
  rotate <-90*clock, 0.0, 0.0>
  translate < 0.01+MB_WIDTH/2.0, MB_LENGTH/2.95,
        MB_HEIGHT/2.25 >
 }
 texture {
  pigment { color Silver }
  normal { bumps 0.1 scale 10 }
  finish {
   ambient 0.2   
   brilliance 6.0
   reflection 0.5   

  }
 }
 translate < 0.0, 0.0, POST_HEIGHT>
} //end of mailbox



//palm material construction--------------------------------------

#declare  Palm_Material =
material{
 texture{//pigment{color rgbf<0.7,1.0,0.1,0.3>}
        pigment{color rgb<0.7,1.0,0.1>}
        normal {bumps 0.25 scale <1,0.5,0.002>}
        finish { ambient 0.4 diffuse 0.5 reflection 0.1 phong 0.7 }    
        }//--------
// interior{ caustics 0.2} 
  }
#declare Oleaf =  sphere { <1, 0, 1.732> 2.01 
                          clipped_by{sphere {<1,0,-1.732>,2 scale<1,0.03,0.5> }}
                          scale<1,1.35,1>} //-------------------

//#declare Zufall0 = seed (1000);
#declare Zufall1 = seed (1021);
#declare Zufall2 = seed (1022);
#declare Zufall3 = seed (1023);
              
#macro Palm_Head(Number_of_arms)
 union{

#local Cno =Number_of_arms; 
#local Cn =0; 
 #while (Cn <Cno)

  #local ScFactor=5; //lo
  #local Xrot =Cn/Cno*50/2;
  #local Yrot =Cn*360*3/5+4;   
  
  #local Xp =0;
  #local Yp =-Cn/25;
  #local Zp =0;

  // loop for the fingers of one palm leaf
  #local Cto = 30+Cn*2;// number of single leaf fingers
  #local Ct =0; 
  #while (Ct < Cto)
   #local Xrot =Xrot+1.5+Ct/Cto*1.75*(Cn*0.5+1);// this reduces leafes to stronger curves
   #local Yrot =Yrot;
   union{
     cylinder {<0,-0.05,0>,<0,1.05,0>, 0.3*(1-Ct/Cto)+0.05  scale<0.7,0.9,0.4>}
     #if ( Ct/2 = int(Ct/2) )
     object { Oleaf scale ScFactor*<sin((15+155*Ct/Cto)*pi/180), 1, sin((15+155*Ct/Cto)*pi/180)>
                    rotate  z*Ct/Cto*50 -3*(0.5-rand(Zufall3))         }
     #else
     object { Oleaf scale<-1,1,1> 
                    scale ScFactor*<sin((15+155*Ct/Cto)*pi/180), 1, sin((15+155*Ct/Cto)*pi/180)>
                    rotate z*-Ct/Cto*50 -3*(0.5-rand(Zufall3))         }
     #end
     scale 1.5*<0.75,1,1>*(1+Cn*0.015) //increases scale for last
     rotate <Xrot,Yrot,0> translate <Xp,Yp,Zp>
     }// end of union
    #local Xp =Xp+sin(Xrot*pi/180)*sin(Yrot*pi/180);
    #local Yp =Yp+cos(Xrot*pi/180)               ;
    #local Zp =Zp+sin(Xrot*pi/180)*cos(Yrot*pi/180);
  #local Ct = Ct+1; #end
 #local Cn = Cn+1; #end
scale 0.035
material{Palm_Material}
}#end // end of Palm_Head

//---------------------------------------------- 

#macro Palme(SegD, Height, Nr_of_arms)
#local SegH = 0.10;  
#local SegScale =  1+Height/10;  // scale of the segments depending from Height!
#local EndNr = int(Height/SegH); // end
#local Palm_Height = EndNr*SegH;

#local Segment = 
difference{
cone{<0,-0.05,0>,0.05,<0,SegH      ,0>,SegD }
cone{<0,2*SegH/3,0>,0.05,<0,SegH+0.001,0>,SegD }
     scale <1,1,1> rotate<0,0,0> translate<0,0,0>
     texture{pigment{color LightWood}
             normal {bumps 1.0 scale<0.005,0.2,0.005>}
             finish {ambient 0.45 diffuse 0.55 phong 0.1}}}
#local High = 0;
#local Nr = 0;     // start

union{
#while (Nr< EndNr)  
   #local ScaleY = (1-0.15*rand(Zufall1));
   #local ScaleT = (0.5+0.15*cos(pi*High/(Palm_Height)));
   object{Segment
          scale <ScaleT,ScaleY,ScaleT>*SegScale 
          rotate<20*(0.5-rand(Zufall2)),80*(0.5-rand(Zufall3)),0> 
          translate<7/EndNr*(-0.15+0.15*cos(pi*High/(1.2*Palm_Height)))
                    ,High,0>} 
 #local High= High+0.1*ScaleY*SegScale;
 #local Nr = Nr + 1;  // next Nr

 #if (Nr = EndNr)

  object{Palm_Head(Nr_of_arms) 
         scale 1+Height/7 
         translate<7/EndNr*(-0.15+0.15*cos(pi*High/(1.2*Palm_Height))) ,High,0>} 
 #end 
 
#end // --------------- end of loop 
 }// end of union
#end // of Palme macro ----------  



//palm Positions left to right 1,2,3,4,5,6 ------------------------------------------------------------------------------

object{Palme (0.20,  1.0,  14)  rotate<100,0,0> translate<-14.5,0,13>}
object{Palme (0.20,  1.0,  14)  rotate<100,0,0> translate<3,0,13>}  
object{Palme (0.20,  1.0,  14)  rotate<100,0,0> translate<-3,0,13>}
object{Palme (0.20,  1.0,  14)  rotate<100,0,0> translate<-8,0,13>} 
object{Palme (0.20,  1.0,  14)  rotate<100,0,0> translate<-19.5,0,13>} 
object{Palme (0.20,  1.0,  14)  rotate<100,0,0> translate<4.6,-1,13.1>} 




    
//Hause construction---------------------------------------------------

// roof textures-------------------

#declare RoofTrans = <-1.25,0,0>;// to regulate the start of the roof brics
#declare Roof1 = texture{
   pigment{gradient x 
           color_map{[0.00 color rgb<1,1,1>*0.3 ]
                     [0.90 color rgb<1,1,1>*0.3 ]
                     [0.95 color rgb<1,1,1>*0.0 ]
                     [1.00 color rgb<1,1,1>*0.3 ]
                    }
           scale < 1, 1, 1>*0.38  quick_color  Scarlet*1.25}
   normal { bumps 0.3 scale 0.015} 
   finish { phong 1}
   translate RoofTrans}

#declare Roof2 = texture{
   Roof1  
   finish { ambient 0.15 diffuse 0.85 phong 1}}

// --------------------------------------------------- these macros are used in macro roof(...)
#macro Roof_quarter (RoofAngle, RoofLen, RoofWide, ROver, RRoofCyl, RoofCylDistance)
 #local RoofSteep = sqrt( pow(RoofLen,2)+ pow(RoofLen*tan(radians(RoofAngle)),2) );
 intersection{
 // a box with cylinders 
 union{
  box {<-ROver,0,-ROver>,< RoofSteep,0.01,RoofWide+ROver> texture{Roof2}}
   #declare Nr = 0;     // Startwert
   #declare EndNr = (RoofWide+2*ROver)/RoofCylDistance; // Endwert
   #while (Nr< EndNr) 
   cylinder {<-RoofOver-0.01,0,0>,<RoofSteep,0,0>, RRoofCyl texture{Roof1}
             translate<0,0,-RoofOver+Nr*RoofCylDistance>} 
   #declare Nr = Nr + 1;    // next Nr
   #end // --------------- end of the loop 
  rotate<0,0,RoofAngle>}//---------- end of union ......
 //cut off by diagonal planes:
 plane{<1,0,0>, 0  rotate<0, 45,0>  texture{Roof1}}
 plane{<1,0,0>, 0  rotate<0,-45,0> translate<0,0,RoofWide> texture{Roof1}}
 
 bounded_by{box {<-RoofOver         ,-RRoofCyl ,-RoofOver>,
                 < RoofLen+RoofSteep, RRoofCyl ,RoofWide+2*RoofOver>}
                 rotate<0,0,RoofAngle> }
 }//end of intersection
#end // end of macro

// ------------------------------------------------------------------------------------
#macro RoofHeight(Len,Angle)  
 Len*tan(radians(Angle)) 
#end
// ------------------------------------------------------------------------------------
#macro RoofDiag (ROver, RoofLen, RoofAngle, RoofCyl_R)          
 #local RoofXOver =  ROver*cos(radians(RoofAngle));
 #local RoofYOver =  ROver*sin(radians(RoofAngle));
  cylinder{<-RoofXOver,-RoofYOver,-RoofXOver>,
            <RoofLen,RoofHeight(RoofLen,RoofAngle),RoofLen>,1.2*RoofCyl_R 
           texture{Roof1 rotate<0,-45,RoofAngle>}}
#end // end of macro

// ------------------------------------------------------------------------------------------------- macro roof(...) -----------
#macro Roof (Roof_Angle1,Roof_Len_X11,Roof_Len_X12,Roof_WideZ11,Roof_WideZ12,Roof_Over,R_Cyl,Cyl_D)
 union{
 object{ Roof_quarter(Roof_Angle1,Roof_Len_X11,Roof_WideZ11,Roof_Over,R_Cyl,Cyl_D)                translate<        0.00,0,0.00>}
 object{ Roof_quarter(Roof_Angle1,Roof_Len_X11,Roof_WideZ11,Roof_Over,R_Cyl,Cyl_D) scale<-1,1,1>  translate<Roof_WideZ12,0,0.00>}
 object{ Roof_quarter(Roof_Angle1,Roof_Len_X12,Roof_WideZ12,Roof_Over,R_Cyl,Cyl_D) rotate<0, 90,0>translate<0.00,0,Roof_WideZ11>}
 object{ Roof_quarter(Roof_Angle1,Roof_Len_X12,Roof_WideZ12,Roof_Over,R_Cyl,Cyl_D) rotate<0,-90,0>translate<Roof_WideZ12,0,0.00>}
 union{
  object{ RoofDiag (Roof_Over, Roof_Len_X11, Roof_Angle1, R_Cyl)                 translate<           0,0,0>} 
  object{ RoofDiag (Roof_Over, Roof_Len_X11, Roof_Angle1, R_Cyl) rotate<0,-90,0> translate<Roof_WideZ12,0,0>} 
  object{ RoofDiag (Roof_Over, Roof_Len_X11, Roof_Angle1, R_Cyl) rotate<0,180,0> translate<Roof_WideZ12,0,Roof_WideZ11>} 
  object{ RoofDiag (Roof_Over, Roof_Len_X11, Roof_Angle1, R_Cyl) rotate<0, 90,0> translate<           0,0,Roof_WideZ11>} 

  cylinder{<0,0,0>,<0,0,Roof_WideZ11-Roof_WideZ12 >,1.2*R_Cyl 
           translate <Roof_Len_X11,RoofHeight(Roof_Len_X11,Roof_Angle1), Roof_Len_X12> 
           texture{Roof1 rotate<0,90,0>}}
 translate<0,0.05,0>}
} #end // of macro    ------------------------------------------------


// --------------------------------------------------------------------------------------------
#declare RoofAngle1  = 35; // main
// --------------------------------------------------------------------------------------------
#declare RoofOver = 0.50;
// --------------------------------------------------------------------------------------------
// dimensions of the roof quarters:
// the long quarter:
#declare RoofLen_X11 = 4.00;// base length of the roof in x-direction  
#declare RoofWideZ11 =10.00;// base length of the roof in z-direction
// the triangular quarter:
#declare RoofLen_X12 = 4.00;// base length of the roof in x-direction
#declare RoofWideZ12 = 8.00;// base length of the roof in z-direction
// --------------------------------------------------------------------------------------------
#declare RCyl = 0.075;
#declare CylD = 0.20;
// --------------------------------------------------------------------------------------------
#declare Walls_Height = 4.00;

// --------------------------------------------------------------------------------------------
union{
box {<0,0,0>,< RoofWideZ12, Walls_Height, RoofWideZ11> 
     texture{pigment{color White}
             finish {ambient 0.45 diffuse 0.55 phong 0.5}}}

object{ Roof (RoofAngle1,RoofLen_X11,RoofLen_X12, RoofWideZ11,RoofWideZ12, RoofOver,RCyl,CylD) 
        translate<0,Walls_Height,0>}

translate<-35,4,2>
//translate<-30,10,9>
rotate<90,4,0> }                                                                                    

// ----------------------------------------------------------------------------                                                                                     
                                     
                                                                                                
//Canoe construction ---------------------------------------------------------- 
#declare Canoe_outside=
sphere {<0,0,0>,1 scale <3,1.5,1> rotate<0,0,0> translate<0,0.5,0> }

#declare Canoe =
union{
intersection{
 object{ Canoe_outside }
 object{ Canoe_outside scale <0.98,0.95,0.94>  inverse}
 sphere {<0,0,0>,1 scale <2.5,1,20> rotate<0,0,0> translate<0,1.3,0>  inverse}
       texture{ pigment{ color White*1.1}
                finish { phong 1}}
 } // end of outside structure of the canoe

 intersection{  // Wanna sit down in my canoe ???
  object{ Canoe_outside
          texture{ pigment{ color White*1.1}
                   finish { phong 1}}}
 union{
  box {<-0.20,0,-1>,<0.20,0.05,1> rotate<0,0,  0> translate< 0.0,0.21,0>}
  box {<-0.20,0,-1>,<0.20,0.05,1> rotate<0,0,-10> translate<-2.0,0.40,0>}
  box {<-0.20,0,-1>,<0.20,0.05,1> rotate<0,0, 10> translate< 2.0,0.40,0>}
  texture{ pigment{ color MediumWood}
           finish { phong 1}}
  }// end of inside union
 }
 }//end of  inside intersection 
 
 
 //Canoe Positions------------------------------------------------------------------------------ 
#declare Canoe_Position1 = transform {   rotate< 50, -3,10> translate<3,-4.6,12>}                     
 
 object{ Canoe transform Canoe_Position1}


