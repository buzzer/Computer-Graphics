
#include "colors.inc"
#include "tiles.inc"

light_source {
	< 10, 10, -10>
	color White *2
//	shadowless
}
camera {
	location < -2, 1, -5>
	angle 30
	look_at < 0, 1, 0>
}

//===============
plane {z, 0 pigment {Gray}}
object {RoundedTile rotate x*-90 scale .9 translate <.05,1,.05>}
object {SquareTile rotate x*-90 scale .9 translate <.05,0,.05> }
sphere {	0, 0.3 
	pigment {Green}
	translate <1,1.5,-1>
}
