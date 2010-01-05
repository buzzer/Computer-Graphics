#include "toiletx01.inc"
#include "Ente.inc"
#include "tileWall.inc"

// Room geometry
#declare RoomHeight = 20;
#declare RoomWidth = 30;
#declare RoomDepth = 20;
// Room walls
#declare TileScaleWall = 2.5;
#declare TileScaleFloor = 3.5;
// Ducky
// Entenposition
#declare DuckX = 22-10*clock;
#declare DuckY = 4;
#declare DuckZ = -4;
//==================INCLUDE OBJECTS HERE=================
#include "bathCamera.inc"
camera{BathCamera}
light_source {	< 0, 100, -100> White }
#include "bathtub.inc" // Has to be included after Ducky position declaration for normals!
#include "roomSteam.inc" // Needs Room geometry declarations
#include "roomWalls.inc" // Needs Room geometry declarations
#include "bathShelf.inc"
#include "tubFiller.inc"
//==================DEFINE OBJECTS HERE==================
object{RoomWalls}
#declare ToiletWidth = 6; // Approximated !!!
object{toiletx01 translate x*ToiletWidth*1.5 }
object{EnteGanz rotate y*180 translate <DuckX, DuckY, DuckZ>}

object{Bathtub translate <(RoomWidth-TubWidth), 0, 0>}
object{BathShelf scale 5 rotate y*90 translate <RoomWidth, 0, -RoomDepth*2/3>}

object{tub_filler scale 0.4 rotate y*180 translate <RoomWidth*13/18, 6.5, 0>}

// Steam
//object{Steam}
