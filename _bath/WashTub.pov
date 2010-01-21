#include "washTub.inc"

camera {
	perspective 
	location < 0.0, 1, -5>
	angle 60
	look_at < 0.0, 0.0, 0.0>
	rotate y*45
}
light_source {
	< 100, 100, -100>
	rgb <1.000000, 1.000000, 1.000000>
	shadowless
}
background {
	rgb <1.000000, 1, 1.000000>
}

object{Washtub}