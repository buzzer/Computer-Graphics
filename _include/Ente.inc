#include "colors.inc"
//#include "Koordinatensystem2.inc"

// Ducky colors
#declare F_Plastic=finish{ambient 0.2 diffuse 0.8 phong 1} // reflection{0,0.1 fresnel}}
#declare T_Bill=texture{pigment{Red} finish{F_Plastic}}
#declare T_Eye=texture{pigment{White} finish{F_Plastic}}
#declare T_Body=texture{pigment{rgb <0.8,0.75,0>} finish{F_Plastic}}
#declare T_Pupil=texture{pigment{Black} finish{F_Plastic}}

#include "DuckyTorso.inc" // Body without head and tail
#include "DuckyHead.inc" // Head without body

#declare DuckyScale150 = 1/150;
#declare DuckyAng = y*90; // Standard orientation

//========================KOPF
#declare Kopf = merge{
	object{DuckyHead} // Rechte Seite
	object{DuckyHead scale <-1,1,1>} // Linke Seite
    	scale DuckyScale150
    	rotate DuckyAng
}
//====================TORSO
#declare DuckyTorso2Side=merge{
	object{DuckyTorso}
	object{DuckyTorso scale <-1,1,1>}
    	scale DuckyScale150
    	rotate DuckyAng
}
// Optimized for scene duration of 20 sec!
//#declare KopfAngMax= 25;
//#declare KopfRollMax= 15;
//#declare KopfPitch = 0*KopfAngMax;
//#declare KopfRoll = KopfRollMax*sin(pi*40*clock);
//#declare KopfYaw = KopfAngMax*sin(pi*40*clock);
//#declare BuerzelPitch= KopfAngMax * abs(sin(pi*80*clock));
//#declare WingAngMax = 110;
//#declare WingRAngle= WingAngMax * abs(sin(pi*80*clock));
//#declare WingLAngle = WingRAngle;
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
	object{Kopf translate <-0.04,-0.4,0> scale <1.3,1.3,1.3> rotate <KopfRoll,KopfYaw,KopfPitch> }
	object{Wing rotate -y*WingRAngle translate z*-0.6 } // Right wing
	object{Wing rotate y*WingLAngle translate z*0.6 } // Left wing
	object{EntenBuerzel translate <-1, 0.3, 0>}
	object{DuckyTorso2Side scale <0.8,1,1>}
}
//object{EnteGanz}
