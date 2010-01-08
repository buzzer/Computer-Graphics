#include "tileWall.inc"

#declare WallBack =
	object{MakeTileWall(RoomWidth ,RoomHeight, TileScaleWall) translate <0, 0, 0> } // Background
#declare WallRight =
	object{MakeTileWall(RoomDepth,RoomHeight,TileScaleWall) rotate y*90 translate <RoomWidth, 0, 0>} // Right
#declare WallCeiling =
	box { < 0, 0, 0>, < RoomWidth, 0, -RoomDepth>
		pigment{rgb 0.7}
		finish {
			ambient rgb 0.8
		}
	}
	
#declare RoomWalls =
union {
	object{MakeTileWall(RoomWidth,RoomDepth,TileScaleFloor) rotate x*90 translate < 0, 0, -RoomDepth>} // Floor
	object{WallBack}
	object{WallBack rotate y*180 translate <RoomWidth, 0, -RoomDepth>}
	object{WallRight}
	object{WallRight rotate y*180 translate <RoomWidth, 0, -RoomDepth>}
	object{WallCeiling translate y*RoomHeight}
}