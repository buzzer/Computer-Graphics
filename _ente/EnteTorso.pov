#include "colors.inc"

camera {	perspective 	location < 0, 0, -10>	angle 30	look_at < 0.0, 0.0, 0.0>}light_source {	< 100, 100, 0>	rgb <1.000000, 1.000000, 1.000000>	shadowless}
global_settings {	ambient_light rgb <1.000000, 1.000000, 1.000000>}plane {y, -4 pigment{Gray} }
#declare dist = 0.7;
#declare TorsoLength=0.3;
blob {	threshold 1//	sphere { <0, 0, 0>, 1 strength 3//	}//	sphere { <-1*dist, 0.1, 0>, 1 strength 1.5//	}	sphere { <-0.5, 0.3, 0>, 0.2 strength 1}
	cylinder { <0, 0, 0.0>, <TorsoLength, 0, 0.0>, 1 strength 2}
	pigment{Yellow}}