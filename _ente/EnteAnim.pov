#include "Ente.inc"
//#include "Koordinatensystem2.inc"

camera {
	angle 20
	location <0 , 0 ,-10.0>
//       location <0 , 10 ,0.0>
//	location <10 , 0 ,0.0>
	look_at <0,0,0>
//	rotate y*0
	rotate <0,clock*360,0>
}

light_source{ <500,500, -1000> White }
//light_source{ <-500,500, 1000> White }

plane { <0.0, 1.0, 0.0>, -2.0 pigment {color Gray} }

//object{ Grid ( 0.5, 0.035, pigment{color rgb<1,1,1>*1.5} ) rotate<-90,0,0>}

object{EnteGanz
//	rotate y*360*clock
	rotate y*90
	rotate x*-50
	no_shadow
}
//object{ Ducky
//	scale <0.8,1,1>
//	no_shadow
//	rotate y*90
//	rotate x*-50	
//}
