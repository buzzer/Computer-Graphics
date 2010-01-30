// Flooding scene
// Length shall be 5 sec.
//================POVRAY SPECIFIC======================
#include "ScenesGlobals.inc"
//================SCENE EFFECTS=======================
#declare EffCamWave = off; // Make intro wave disturbance, camera
#declare EffWaterHose = off; // Let the tub filler produce water
#declare EffSteamDist = off; // Fill the room with fine steam with disturbance
//================ROOM CONSTANTS=====================
// Room geometry
#declare RoomHeight = 20;
#declare RoomWidth = 30;
#declare RoomDepth = 20;
//Tub Filler
#declare TubFilY = 6.5;
#declare TubFillerPos = <RoomWidth*13/18, TubFilY, 0>;
#declare TubFillerOpening = TubFillerPos - < 0, 0.4, 2.2>;
// Water
#declare WaterHeight = 3/4*RoomHeight*clock;
#declare WaterDefault = 4;
// Ducky
// Entenposition
#declare DuckY = WaterDefault;
// Room walls
#declare TileScaleWall = 2.5;
#declare TileScaleFloor = 3.5;
//================SCENE CONSTANTS====================//Used in include files!
// Ducky movement
#declare KopfAngMax= 25;
#declare KopfRollMax= 15;
#declare KopfPitch = 0*KopfAngMax;
#declare KopfRoll = KopfRollMax*sin(pi*10*clock);
#declare KopfYaw = KopfAngMax*sin(pi*10*clock);
#declare BuerzelPitch = KopfAngMax * abs(sin(pi*20*clock));
#declare WingAngMax = 110;
#declare WingRAngle = WingAngMax * abs(sin(pi*20*clock));
#declare WingLAngle = WingRAngle;
#declare TubWaterPhase = 5*pi*clock; // Optimized for 10 sec per scene
#declare CamKugelRotFreq = 360*10*clock; // Optimal for 10 sec per scene
#declare CamKugY = 3+RoomHeight-((RoomHeight-2)*clock);
#declare HelferleinY = 2+RoomHeight-(3+(RoomHeight-2)*clock);
//==================INCLUDE FILES HERE=================
#include "toiletx01.inc"
#include "Ente.inc"
#include "tileWall.inc"
#include "bathCamera02.inc"
camera{BathCamera}
light_source {	< RoomWidth/2, RoomHeight-1, -RoomDepth/2> White*0.6 }
#include "tubwater.inc" // Has to be included before bathtub.inc!
#include "bathtub.inc" // Has to be included after Ducky position declaration for normals!
#if (EffSteamDist)
#include "roomSteam.inc" // Needs Room geometry declarations
#end
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
#include "duckySpline02.inc"
#include "helferleinSitting.inc"
#include "kugel.inc"
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
// Bath tub
object{Bathtub translate <(RoomWidth-TubWidth), 0, 0>}
#if (CamKugY > TubFilY)
#declare BTubFilRot = 0;
#else
#declare BTubFilRot = -45;
#end

object{tub_filler  scale 0.4	 rotate y*180 rotate x*BTubFilRot translate TubFillerPos }
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
//=======================OTHER OBJECTS========================
object{ CamKugel scale 0.2 translate <RoomWidth*13/18, CamKugY, -2.2> }
object{ helferlein rotate y*-90 scale 1 translate <RoomWidth*13/18, HelferleinY, -3> }
