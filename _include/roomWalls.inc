#include "tileWall.inc"

#declare RoomWalls =
union {
	object{MakeTileWall(RoomWidth ,RoomHeight, TileScaleWall) translate <0, 0, 0> } // Background
	object{MakeTileWall(RoomDepth,RoomHeight,TileScaleWall) rotate y*90 translate <RoomWidth, 0, 0>} // Right
	object{MakeTileWall(RoomWidth,RoomDepth,TileScaleFloor) rotate x*90 translate < 0, 0, -RoomDepth>} // Floor
}