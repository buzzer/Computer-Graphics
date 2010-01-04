#include "tubwater.inc"

// Bathtub
#declare TubDepth=8;
#declare TubWidth=13;
#declare TubHeight=5;
#declare TubScale=2;
#declare TubXShift=4;
object{MakeTileWall(TubWidth,TubHeight, TubScale) translate <TubXShift,0,-TubDepth> }
object{MakeTileWall(TubDepth, TubHeight, TubScale) rotate y*90 translate <TubXShift,0,0>}
#declare TubInnerDepth=1;
#declare TubOuter =
	box { < 0.01, 0, 0.01-TubDepth>, < TubWidth, TubHeight, 0> }
#declare TubInner = 
	box { < TubInnerDepth, 0.1, -TubDepth+TubInnerDepth>, < TubWidth-TubInnerDepth, TubHeight+0.001, -TubInnerDepth> }
#declare TubWall =
difference {
	object{TubOuter}
	object{TubInner}
	pigment {White}
	finish {reflection .5 ambient .2 diffuse .9}
}
#declare Bathtub =
union {
	object{TubWall translate x*TubXShift}
	difference{
		object{Water translate y*TubHeight*0.8}
		object{TubInner translate x*TubXShift inverse}
	}
}
