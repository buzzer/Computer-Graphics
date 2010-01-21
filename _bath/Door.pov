//#include "colors.inc"
//#include "textures.inc"
#include "bathDoor.inc"

camera {
	perspective 
	location < 0.0, 2, -10>
	angle 60
	look_at < 0.0, 2.0, 0.0>
//	rotate y*90
}
light_source {
	< 100, 100, -100>
	rgb <1.000000, 1.000000, 1.000000>
	shadowless
}
background {
	rgb <1.000000, 0.999908, 1.000000>
}

object{BathDoor}