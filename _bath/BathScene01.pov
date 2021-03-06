// Scene duration shall be 20 sec!
//================POVRAY SPECIFIC======================
#include "ScenesGlobals.inc"
//================SCENE EFFECTS=======================
#declare EffCamWave = off; // Make intro wave disturbance, camera
#declare EffWaterHose = on; // Let the tub filler produce water
#declare EffSteamDist = off; // Fill the room with fine steam with disturbance
//================SCENE CONSTANTS====================
// Room geometry
#declare RoomHeight = 20;
#declare RoomWidth = 30;
#declare RoomDepth = 20;
// Room walls
#declare TileScaleWall = 2.5;
#declare TileScaleFloor = 3.5;
// Water
#declare WaterDefault = 4;
// Ducky
// Entenposition, defined by spline
#declare DuckY = WaterDefault;
//#declare DuckX = 27-11*clock;
//#declare DuckY = 4;
//#declare DuckZ = -4;
//#declare DuckRot = 180*clock;
// Ducky movement, optimized for scene duration of 20 sec
#declare KopfAngMax= 25;
#declare KopfRollMax= 15;
#declare KopfPitch = 0*KopfAngMax;
#declare KopfRoll = KopfRollMax*sin(pi*40*clock);
#declare KopfYaw = KopfAngMax*sin(pi*40*clock);
#declare BuerzelPitch= KopfAngMax * abs(sin(pi*80*clock));
#declare WingAngMax = 110;
#declare WingRAngle= WingAngMax * abs(sin(pi*80*clock));
#declare WingLAngle = WingRAngle;
//Tub Filler
#declare TubFillerPos = <RoomWidth*13/18, 6.5, 0>;
#declare TubFillerOpening = TubFillerPos - < 0, 0.4, 2.2>;
#declare TubWaterPhase = 20*pi*clock; // Optimized for 20 sec per scene
//==================INCLUDE FILES HERE=================
#include "toiletx01.inc"
#include "Ente.inc"
#include "tileWall.inc"
#include "bathCamera01.inc"
camera{BathCamera}
light_source {	< RoomWidth/2, RoomHeight-1, -RoomDepth/2> White*0.6 }
#include "tubwater.inc"
#include "bathtub.inc" // Has to be included after Ducky position declaration for normals!
#include "roomSteam.inc" // Needs Room geometry declarations
#include "roomWalls.inc" // Needs Room geometry declarations
#include "bathShelf.inc"
#include "tubFiller.inc"
#include "washTub.inc"
#include "bathDoor.inc"
#if (EffWaterHose)
#include "tubHose.inc" // Hose particles
#end
#include "furniture.inc"
#include "mirror.inc"
#include "transforms.inc"
#include "duckySpline01.inc"
//==================SCENE OBJECTS HERE==================
object{RoomWalls}
object{BathDoor scale <3,3.5,1> rotate y*-90 translate z*-4/5*RoomDepth }
#declare ToiletWidth = 6; // Approximated !!!
object{toiletx01 translate <1/4*RoomWidth, 0, 0> }
// Ducky
//object{EnteGanz rotate y*(180-DuckRot) translate <DuckX, DuckY, DuckZ>}
object{EnteGanz rotate y*-90
  Spline_Trans (DuckySpline, clock*NumDuckyPos, ViewAxis, YawAdvance, RollAdvance)
}

object{Bathtub translate <(RoomWidth-TubWidth), 0, 0>}
object{tub_filler  scale 0.4	 rotate y*180 translate TubFillerPos }
object{FillerKnob scale 2  translate TubFillerPos-x*2}
object{FillerKnob scale 2  translate TubFillerPos+x*2}

// Steam
#if (EffSteamDist) 	object{Steam} #end
// Furniture
object{BathShelf scale 5 rotate y*-90 translate <0, 0, -RoomDepth*0.3>}
object{Wardrobe scale 8 rotate y*180 translate <RoomWidth-1, 0, -0.97*RoomDepth> }
object{Chest1 scale 8 rotate y*180 translate <RoomWidth*3/4, 0, -0.97*RoomDepth> }
object{Chest2 scale 10 translate <1/6*RoomWidth, 1/2*RoomHeight, 0> }
// Mirror
object{Mirror scale 7 rotate y*180 translate <0.3*RoomWidth, 0.5*RoomHeight, -0.99*RoomDepth>}
object{Washtub scale 2 rotate y*180 translate <0.3*RoomWidth, 0.4*RoomHeight, -RoomDepth>}
object{tub_filler  scale 0.3	 translate <0.3*RoomWidth, 0.45*RoomHeight, -RoomDepth> }
object{FillerKnob scale 2 rotate y*180 translate <0.25*RoomWidth, 0.45*RoomHeight, -RoomDepth>}
object{FillerKnob scale 2 rotate y*180 translate <0.35*RoomWidth, 0.45*RoomHeight, -RoomDepth>}
