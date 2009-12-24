#include "colors.inc"
#include "tileWall.inc"

light_source {
	< 100, 100, -100>
	color White
//	shadowless
}
camera {
	location < 1, 2, -2>
	angle 110
	look_at < 1.5, 1.5, 0>
}
//background { White }
//===============
object{ MakeTileWall(3,3,1) } 
sphere {	0, 0.3 
	pigment {Green}
	translate <1,1.5,-1>
}
