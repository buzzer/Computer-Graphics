#include "toiletx01.inc"
#include "Ente.inc"
#include "tileWall.inc"

// Room geometry
#declare RoomHeight = 10;
#declare RoomWidth = 30;
#declare RoomDepth = 15;
// Room walls
#declare TileScaleWall = 2.5;
#declare TileScaleFloor = 3.5;
// Ducky
// Entenposition
#declare DuckX = 27-10*clock;
#declare DuckY = 4;
#declare DuckZ = -4;

#include "bathtub.inc"

camera {
	perspective 
	location < RoomWidth*1/3, RoomHeight, -RoomDepth> // Vorne links
//	location <RoomWidth*0.97, RoomHeight*2/3, -RoomDepth*0.03> // Ecke hinten rechts
	right x * 1
	up y * 3/4
//	angle 110
	angle 60
	look_at < RoomWidth, RoomHeight*1/3, -RoomDepth*1/3> // Hinten rechts
//	look_at < RoomWidth*5/6, RoomHeight*1/3, -RoomDepth*1/3> // Wanne vorne links
//	rotate y*360*clock
}
light_source {	< 0, 100, -100> White }

//object{MakeTileWall(RoomWidth ,RoomHeight, TileScaleWall) translate <0, 0, 0> } // Background
//object{MakeTileWall(RoomDepth,RoomHeight,TileScaleWall) rotate y*90 translate <RoomWidth, 0, 0>} // Right
//object{MakeTileWall(RoomWidth,RoomDepth,TileScaleFloor) rotate x*90 translate < 0, 0, -RoomDepth>} // Floor

#declare ToiletWidth = 6; // Approximated !!!
//object{toiletx01 translate x*ToiletWidth*2 }
object{EnteGanz rotate y*180 translate <DuckX, DuckY, DuckZ>}

#declare TubWidth = 15; // Taken from bathtub.inc !!!
object{Bathtub translate x*(RoomWidth-TubWidth)}

