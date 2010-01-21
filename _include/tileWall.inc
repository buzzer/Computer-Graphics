#include "tiles.inc"
#include "transforms.inc"

// Make a wall covered with tiles
// @param Weight, Height, TileScale
// Based on square tiles
#macro MakeTileWall (Weight, Height, TileScale)
  #local TileDepthScale = 0.5; // Scale Tile in depth
  #local TileDepth = (0.1*TileScale*TileDepthScale)/2; // Careful: value taken from tiles.inc
  #local TileGap = 2*TileDepth;
  #local WallDepth = TileDepth+0.001;
  #local Row = 0;
  #local Col = 0;
  #local TCntWeight = ceil(Weight / (TileScale + TileGap)); // get the tile count horizontal
  #local TCntHeight = ceil(Height / (TileScale + TileGap)); // get the tile count vertical
//  #debug concat("Tile weight count: ", str(TCntWeight, 5, 2), "\n")
//  #debug concat("Tile height count: ", str(TCntHeight, 5, 2), "\n")
  union{ // Putz with tiles
    difference{ // Chop the tiles
      union{ // Tiles
        #while( Col < TCntWeight )
          #while( Row < TCntHeight )
            //object { RoundedTile
            object { SquareTile
              rotate x*-90 scale <TileScale, TileScale, TileDepthScale*TileScale>
              translate <(TileGap/2)*(Col+1)+TileScale*Col, (TileGap/2)*(Row+1)+TileScale*Row, TileDepth>
            }
            #local Row = Row + 1;
          #end
          #local Row = 0;
          #local Col = Col + 1;
        #end
      }
      box { <0,0,2*TileDepth>, <Weight-(TileGap/2),Height-(TileGap/2),-2*TileDepth> inverse
        texture { pigment {color White}
          finish {reflection .5 ambient .2 diffuse 0.5}
      } }
    }
    box { < 0, 0, 0>, < Weight, Height, WallDepth>
      pigment {rgb <0.254032, 0.254032, 0.254032>} // Dark Gray
    } // Putz
  }
#end
