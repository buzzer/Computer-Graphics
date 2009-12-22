#include "toiletx01.inc"

camera {	perspective 	location < -3, 7, -10>	right x * 1	up y * 3/4	angle 90	look_at < 0.0, 0.0, 0.0>
	rotate y*360*clock}light_source {	< 100, 100, -100>	rgb <1.000000, 1.000000, 1.000000> *2	photons {	}	media_interaction off}
//light_source {//	< 0.0, 100, 100>//	rgb <1.000000, 1.000000, 1.000000>//	area_light <0.0, 5.0, 5.0>, <5.0, 0.0, 0.0>, 5, 5//	photons {//	}//	media_interaction off//}
object{toiletx01}