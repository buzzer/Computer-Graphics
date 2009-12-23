#include "tiles.inc"
#include "transforms.inc"

// Make a wall covered with tiles
// @param Weight, Height, TileScale
// Based on square tiles
#macro MakeTileWall(Weight, Height, TileScale)
	#local Depth = 0.1;
	#local TileGap = 0.1;
	#local TileDepth = 0.05;
	#local Row = 0;
	#local Col = 0;
	#local TCntWeight = ceil(Weight / (TileScale + TileGap)); // get the tile count horizontal
	#local TCntHeight = ceil(Height / (TileScale + TileGap)); // get the tile count vertical
	#debug concat("Tile weight count: ", str(TCntWeight, 5, 2), "\n")
	#debug concat("Tile height count: ", str(TCntHeight, 5, 2), "\n")
	union{
		box { < 0, 0, 0>, < Weight, Height, Depth> pigment {Gray} }
		#while( Col < TCntWeight )
			#while( Row < TCntHeight )
				object { RoundedTile
					rotate x*-90 scale TileScale
					translate <(TileGap/2)*Col+TileScale*Col, (TileGap/2)*Row+TileScale*Row, TileDepth>
				}
				#local Row = Row + 1;
				#debug concat("Row: ", str(Row,2,0), "\n")
			#end
			#debug concat("Col: ", str(Row,2,0), "\n")
			#local Col = Col + 1;
			#debug concat("Col: ", str(Row,2,0), "\n")
		#end
//		object { SquareTile rotate x*-90 scale .9 translate <.05, 0, .05> }
	}
#end
