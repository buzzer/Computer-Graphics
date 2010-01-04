#include "toiletx01.inc"
#include "Ente.inc"
#include "tileWall.inc"
#include "bathtub.inc"

camera {
	perspective 
	location < 0, 9, -10>
	right x * 1
	up y * 3/4
	angle 110
//	angle 60
	look_at < 8, 5, -2>
	rotate y*360*clock
}
light_source {	< -100, 100, -100> White }

// Room walls
object{MakeTileWall(30,20,2.5) translate <-10, 0, 0> } 
object{MakeTileWall(10,20,2.5) rotate y*90 translate <20, 0, 0>}
object{MakeTileWall(30,10,3.5) rotate x*90 translate <-10, 0, -10>}

object{toiletx01}
object{EnteGanz rotate y*240 translate <12, 4, -4>}
object{Bathtub}

