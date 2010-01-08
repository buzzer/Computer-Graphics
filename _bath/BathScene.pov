//================POVRAY SPECIFIC======================
#if (version < 3.7) global_settings{ assumed_gamma 1.8 } #end
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//================SCENE EFFECTS=======================
#declare EffCamWave = false; // Make intro wave disturbance, camera
#declare EffWaterHose = true; // Let the tub filler produce water
#declare EffSteamDist = false; // Fill the room with fine steam with disturbance
//================SCENE CONSTANTS====================
// Room geometry
#declare RoomHeight = 20;
#declare RoomWidth = 30;
#declare RoomDepth = 20;
// Room walls
#declare TileScaleWall = 2.5;
#declare TileScaleFloor = 3.5;
// Ducky
// Entenposition
#declare DuckX = 27-11*clock;
#declare DuckY = 4;
#declare DuckZ = -4;
#declare DuckRot = 180*clock;
//Tub Filler
#declare TubFillerPos = <RoomWidth*13/18, 6.5, 0>;
#declare TubFillerOpening = TubFillerPos - < 0, 0.4, 2.2>;
//==================INCLUDE FILES HERE=================
#include "toiletx01.inc"
#include "Ente.inc"
#include "tileWall.inc"
#include "bathCamera.inc"
camera{BathCamera}
light_source {	< RoomWidth/2, RoomHeight-1, -RoomDepth/2> White*0.6 }
#include "bathtub.inc" // Has to be included after Ducky position declaration for normals!
#include "roomSteam.inc" // Needs Room geometry declarations
#include "roomWalls.inc" // Needs Room geometry declarations
#include "bathShelf.inc"
#include "tubFiller.inc"
#if (EffWaterHose)
	#include "tubHose.inc" // Hose particles
#end
#include "furniture.inc"
#include "mirror.inc"
//==================SCENE OBJECTS HERE==================
object{RoomWalls}
#declare ToiletWidth = 6; // Approximated !!!
object{toiletx01 translate <1/4*RoomWidth, 0, 0> }
object{EnteGanz rotate y*(180-DuckRot) translate <DuckX, DuckY, DuckZ>}

object{Bathtub translate <(RoomWidth-TubWidth), 0, 0>}
object{BathShelf scale 5 rotate y*90 translate <RoomWidth, 0, -RoomDepth*2/3>}

object{tub_filler  scale 0.4	 rotate y*180 translate TubFillerPos }

// Steam
#if (EffSteamDist) 	object{Steam} #end
// Furniture
object{Wardrobe scale 8 rotate y*180 translate <RoomWidth-1, 0, -RoomDepth> }
object{Chest1 scale 8 rotate y*180 translate <RoomWidth*6/8, 0, -RoomDepth> }
object{Chest2 scale 10 translate <1/6*RoomWidth, 1/2*RoomHeight, 0> }
// Mirror
object{Mirror scale 7 rotate y*180 translate <0.2*RoomWidth, 0.4*RoomHeight, -0.99*RoomDepth>}
