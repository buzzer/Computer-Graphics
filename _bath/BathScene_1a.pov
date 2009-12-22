#include "toiletx01.inc"
#include "Ente.inc"

camera {
	perspective 
	location < -3, 7, -10>
	right x * 1
	up y * 3/4
	angle 90
	look_at < 0.0, 0.0, 0.0>
	rotate y*360*clock
}
light_source {
	< 100, 100, -100>
	rgb <1.000000, 1.000000, 1.000000> *2
}
plane {	<0.0, 1, 0.0>, 0.0	pigment {	rgb <0.524336, 0.523580, 0.549176> } }
plane {	<0.0, 0.0, -1>, 0	material {		texture { pigment {	rgb <0.574731, 0.579588, 0.571909> }			normal {	brick 0.5 //amount			}			finish {	reflection {	rgb <0.000000, 0.000000, 0.000000>}				diffuse 0.6				brilliance 1.0			}		}		interior { ior 1.3 }	}} 
object{toiletx01}
object{EnteGanz rotate y*45 translate <0, 5, -5>}
