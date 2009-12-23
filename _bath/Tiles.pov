#include "colors.inc"
#include "tileWall.inc"

light_source {
	< 10, 10, -10>
	color White *2
//	shadowless
}
camera {
	location < 0, 2, -5>
	angle 90
	look_at < 2, 2, 0>
}
//===============
object{MakeTileWall(7,5,1) } 
sphere {	0, 0.3 
	pigment {Green}
	translate <1,1.5,-1>
}
