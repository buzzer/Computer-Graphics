#include "toiletx01.inc"
#include "Ente.inc"
#include "tileWall.inc"

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

object{MakeTileWall(10,10,2) translate x*-5} 
object{toiletx01}
object{EnteGanz rotate y*45 translate <0, 5, -5>}
