#include "colors.inc"
//#include "tiles.inc"
#include "tileWall"

light_source {
	< 10, 10, -10>
	color White *2
//	shadowless
}
camera {
	location < -2, 1, -5>
	angle 80
	look_at < 0, 1, 0>
}
//===============
object{MakeTileWall(10,10,1) } 
sphere {	0, 0.3 
	pigment {Green}
	translate <1,1.5,-1>
}
