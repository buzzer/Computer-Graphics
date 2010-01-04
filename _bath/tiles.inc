/*
	From http://www.deakin.edu.au/~agoodman/povstuff.php
	
	All tiles are 1x.1x1, and are bounded by the box
	{<0,0,0>,<1,.1,1>}

	Here's a good way to do them:
	plane {y,0}
	object {xTile scale .9 translate <.05,0,.05>}
	as many as you need...
*/
#include "shapes.inc"
#include "textures.inc"

#declare TileTexture =
texture {
	pigment {color White}
//	finish {reflection .5 ambient .2 diffuse .04}
	finish {reflection .1 ambient .2 diffuse .8}
}

#declare SquareTile=
intersection {
	box {<0,0,0>,<10,1,10>}
	intersection {
		plane {-x,0 rotate -45*z translate -.5*x}
		plane {x,0 rotate 45*z translate 10.5*x}
		plane {-z,0 rotate 45*x translate -.5*z}
		plane {z,0 rotate -45*x translate 10.5*z}
	}
	texture{TileTexture}
	scale .1
	bounded_by {box {<0,0,0>,<1,.1,1>}}
}

#declare mdcRoundedCorner=
intersection {
	union {
		cylinder {<1,1,0>,<1,1,2>,1}
		box {<1,0,0>,<2,2,2>}
	}
	union {
		cylinder {<0,1,1>,<2,1,1>,1}
		box {<0,0,1>,<2,2,2>}
	}
	scale .5
}

#declare mdcTileTubeEdge=
union {
	object {mdcRoundedCorner}
	object {mdcRoundedCorner rotate y*90 translate z*10}
	object {mdcRoundedCorner rotate -y*90 translate x*10}
	object {mdcRoundedCorner rotate y*180 translate <10,0,10>}
	cylinder {<.99,.5,.5>,<9.01,.5,.5>,.5}
	cylinder {<.99,.5,9.5>,<9.01,.5,9.5>,.5}
	cylinder {<.5,.5,.99>,<.5,.5,9.01>,.5}
	cylinder {<9.5,.5,.99>,<9.5,.5,9.01>,.5}
}

#declare RoundedTile=
union {
	box {<0,0,0>,<10,.5,10>}
	box {<.5,0,.5>,<9.5,1,9.5>}
	object {mdcTileTubeEdge}
	texture{TileTexture}
	scale .1
	bounded_by {box {<0,0,0>,<1,.1,1>}}
}
