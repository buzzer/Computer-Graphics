#include "colors.inc"
//#include "Koordinatensystem2.inc"

#declare F_Plastic=finish{ambient 0 diffuse 1 phong 1} // reflection{0,0.1 fresnel}}
#declare T_Bill=texture{pigment{Red} finish{F_Plastic}}
#declare T_Eye=texture{pigment{White} finish{F_Plastic}}
#declare T_Body=texture{pigment{rgb <0.8,0.75,0>} finish{F_Plastic}}
#declare T_Pupil=texture{pigment{Black} finish{F_Plastic}}

#include "ducky.inc"

//camera {
//	angle 36
//	location <0 , 0 ,-10.0>
////       location <0 , 10 ,0.0>
////	location <10 , 0 ,0.0>
//	look_at <0,0,0>
//	rotate <0,clock*360,0>
//}

//light_source{ <500,500, -1000> White }
//light_source{ <-500,500, 1000> White }
//
//plane { <0.0, 1.0, 0.0>, -2.0 pigment {color Gray} }

//object{ Grid ( 0.5, 0.035, pigment{color rgb<1,1,1>*1.5} ) rotate<-90,0,0>}
//========================DUCKY
#declare Ducky= merge{
	object{Ducky} // Rechte Seite
	object{Ducky scale <-1,1,1>} // Linke Seite
    	scale 1/150
    	rotate y*90 //90 Degree: Nullposition
//    scale <1,1,0.5>
//    translate -y*1
}
//=====================KOPF
#declare KopfKugel=
sphere{0,1
	pigment{color Yellow transmit 0.5}
	scale 0.75
	translate <0.44,1.1,0>
}
#declare Kopf=
intersection{
	object{Ducky}
	object{KopfKugel}
}
//#declare KopfKugeloSchnabel =
//	sphere{<0.0,0.0,0> 2 pigment {color Red transmit 0.75} translate <0.9,1.5,0> scale <0.297,0.5,0.5> }
//#declare KopfSchnabel =
//intersection{
//	object{Kopf}
//	object{KopfKugeloSchnabel}
//	inverse
//}
//================SCHWKUGEL
#declare SchwKugel= sphere{<-0.2,-0.2,0>, 1.1	pigment{color Yellow transmit 0.5} }
//====================TORSO
#declare Torso=difference{
	object{Ducky}
	object{KopfKugel}
	scale <0.8,1,1>
}
#declare TorsoOBuerz= difference{
	object{Torso}
	object{SchwKugel inverse}	
}
//object{TorsoOBuerz}

#declare KopfAngMax= 25;
#declare KopfPitch = sin(clock * 2 *pi ) *KopfAngMax;
#declare KopfRoll = sin(clock * 4 * pi ) *KopfAngMax;
#declare KopfYaw = sin(clock *8*pi) *KopfAngMax;
#declare BuerzelPitch= sin(clock*8*pi)*KopfAngMax/2;

//====================BUERZEL
//#declare EntenBuerzel= intersection{
//	object{Torso}
//	object{SchwKugel inverse}
//	translate <1.15, -0.4, 0>
//	scale <1.5, 1.5, 1.2>
//	rotate <0,0,BuerzelPitch> // Wackle mit dem Schwanz
//	translate <-1.05, 0.35, 0>
//}
#declare EntenBuerzel= blob{
		threshold 1.2
		cylinder {	< 0, 0, 0>, < 0.0, 0.5, 0.0>, 0.5 strength 2 rotate z*35}
		cylinder {	< 0, 0, 0>, < 0.0, 0.5, 0.0>, 0.5 strength 2}
		cylinder {	< 0, 0, 0>, < 0.0, 0.5, 0.0>, 0.5 strength 2  rotate z*-35}
		texture{ T_Body }
		scale <1, 0.8, 0.5>
		scale 0.8
		translate <0, -0.3, 0>
		rotate <-90, -90, 0> 
		rotate z*-45
		rotate z*BuerzelPitch
}
//object{EntenBuerzel}

//object{Kopf}
//object{KopfKugel}
//sphere{<0.0,0.0,0> 2 pigment {color Red transmit 0.75} translate <0.9,1.5,0> scale <0.297,0.5,0.5> }
//object{KopfSchnabel translate x*2}
//object{Kopf scale 0.7 translate <0.4,0.8,0>}
//=======================WING
#declare Wing= blob{
		threshold 1
		cylinder {	< 0, 0, 0>, < 0.0, 0.5, 0.0>, 0.5 strength 2 rotate z*30}
		cylinder {	< 0, 0, 0>, < 0.0, 0.75, 0.0>, 0.5 strength 2}
		cylinder {	< 0, 0, 0>, < 0.0, 1, 0.0>, 0.5 strength 2  rotate z*-20}
		texture{ T_Body }
		rotate z*90 scale <0.5, 0.5, 0.3>
}
//====================KOMPLETT
#declare EnteGanz = merge{
	object{Kopf translate <-0.04,-0.4,0> scale <1.3,1.3,1.3> rotate <KopfRoll,KopfYaw,KopfPitch> }
	object{TorsoOBuerz}
	object{Wing rotate y*-90*(1+(sin(8*pi*clock)))/2 translate z*-0.5 } // Right wing
	object{Wing rotate y*90*(1+(sin(8*pi*clock)))/2 translate z*0.5 } // Left wing
	object{EntenBuerzel translate <-1, 0.3, 0>}
}
//object{EnteGanz}