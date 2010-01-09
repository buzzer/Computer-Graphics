#include "colors.inc"
//#include "Koordinatensystem2.inc"

#declare F_Plastic=finish{ambient 0.1 diffuse 1 phong 1} // reflection{0,0.1 fresnel}}
#declare T_Bill=texture{pigment{Red} finish{F_Plastic}}
#declare T_Eye=texture{pigment{White} finish{F_Plastic}}
#declare T_Body=texture{pigment{rgb <0.8,0.75,0>} finish{F_Plastic}}
#declare T_Pupil=texture{pigment{Black} finish{F_Plastic}}

#include "ducky.inc"

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
//	pigment{color Yellow transmit 0.5}
	scale 0.75
	translate <0.44,1.1,0>
}
#declare Kopf=
difference{
	object{Ducky}
	object{KopfKugel inverse}
}
//================SCHWKUGEL
#declare SchwKugel= sphere{<-0.2,-0.2,0>, 1.2
//	pigment{color Yellow transmit 0.5}
}
//====================TORSO
#declare Torso= //merge{
difference{
	object{Ducky}
	object{KopfKugel}
	object{SchwKugel inverse}	
//	bounded_by { object{SchwKugel} }
//	clipped_by { bounded_by }
}
//object{KopfKugel pigment {Yellow transmit 0.5} }
//}

#declare KopfAngMax= 25;
#declare KopfRollMax= 15;
#declare KopfPitch = 0*KopfAngMax;
#declare KopfRoll = KopfRollMax*sin(pi*5*clock);
#declare KopfYaw = KopfAngMax*sin(pi*5*clock);
#declare BuerzelPitch= KopfAngMax * abs(sin(pi*10*clock));
#declare WingAngMax = 110;
#declare WingRAngle= WingAngMax * abs(sin(pi*10*clock));
#declare WingLAngle = WingRAngle;

//====================BUERZEL
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
//	object{Kopf translate <-0.04,-0.4,0> scale <1.3,1.3,1.3> rotate <KopfRoll,KopfYaw,KopfPitch> }
//	object{Wing rotate -y*WingRAngle translate z*-0.6 } // Right wing
//	object{Wing rotate y*WingLAngle translate z*0.6 } // Left wing
//	object{EntenBuerzel translate <-1, 0.3, 0>}
	object{Torso scale <0.8,1,1> }
}
//object{EnteGanz}