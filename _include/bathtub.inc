// Needs following include used before: #include "tubwater.inc"

// Bathtub
#declare TubDepth=9;
#declare TubWidth=17;
#declare TubHeight=5;
#declare TubScale=2;
#declare TubInnerDepth=1;
#declare TubOuter =
	box { < 0.01, 0, 0.01-TubDepth>,
		 < TubWidth, TubHeight, 0> }
#declare TubInner = 
	box { < TubInnerDepth, 0.1, -TubDepth+TubInnerDepth>,
		 < TubWidth-TubInnerDepth, TubHeight+0.001, -TubInnerDepth> }
#declare TubWall =
difference {
	object{TubOuter}
	object{TubInner}
	pigment {White}
	finish {reflection .1 ambient .2 diffuse .9}
}
#declare Bathtub =
union {
	object{MakeTileWall(TubWidth,TubHeight, TubScale) translate <0,0,-TubDepth> }
	object{MakeTileWall(TubDepth, TubHeight, TubScale) rotate y*90 }
	object{TubWall}
	difference{
		object{Water translate y*TubHeight*0.8}
		object{TubInner inverse}
	}
}
