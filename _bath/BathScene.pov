#include "toiletx01.inc"
#include "Ente.inc"
#include "tileWall.inc"

camera {
	perspective 
	location < -3, 7, -10>
	right x * 1
	up y * 3/4
	angle 110
	look_at < 2, 5, 0>
	rotate y*360*clock
}
light_source {	< -100, 100, -100> White }
plane {	<0.0, 1, 0.0>, 0.0	pigment {	rgb <0.524336, 0.523580, 0.549176> } }

object{MakeTileWall(30,20,2.5) translate <-10, 0, 0> } 
object{MakeTileWall(10,20,2.5) rotate y*90 translate <20, 0, 0>}
object{MakeTileWall(30,10,3.5) rotate x*90 translate <-10, 0, -10>}
object{toiletx01}
object{EnteGanz rotate y*45 translate <0, 5, -5>}
