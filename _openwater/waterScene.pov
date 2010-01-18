#include "colors.inc"
#include "skies.inc"
#include "textures.inc"
#include "glass.inc"
#include "Ente.inc"
//#include "fastsky.inc"
//================POVRAY GLOBALS======================
#include "ScenesGlobals.inc"
#declare Photons = on;
global_settings {
	max_trace_level 10	
	photons {
		spacing 0.005
//	      jitter 0.5
	}
}
#macro PhotonBlock()
	#if(Photons)
		photons {
			target
			collect off
			reflection on
//			refraction on
		}
	#end
#end
//================SCENE CONSTANTS====================
// Camera and caustics angle
#declare CamAngle = 0; // 0 is looking to +z axis
// Entenposition
#declare DuckX = 0;
#declare DuckY = 0;
#declare DuckZ = 0+clock*40; // ca. 200 frames
#declare DuckRot = <0,-90,0>;//180*clock;
// Light: Sync light with moon/sun
#declare LightPos = <0,40,1000>;//<500,500, -1000>;
// Ducky movement
#declare KopfAngMax= 25;
#declare KopfRollMax= 15;
#declare KopfPitch = 0*KopfAngMax;
#declare KopfRoll = KopfRollMax*sin(pi*5*clock);
#declare KopfYaw = 0;//KopfAngMax*sin(pi*5*clock);
#declare BuerzelPitch= KopfAngMax * abs(sin(pi*5*clock));
#declare WingAngMax = 110;
#declare WingRAngle= WingAngMax * abs(sin(pi*5*clock));
#declare WingLAngle = WingRAngle;
// Water
#declare WaterTexture =
texture{ Green_Glass
	normal{
       	ripples 0.3 // More regular, e.g. indoor
//           bumps 0.3 // Mor turbulenced, e.g. outdoor, but no dynamics!
             scale 2
             turbulence 0.75
		sine_wave phase -1/2*pi*clock  // Dynamic waves
	}
       finish{
       	ambient 0.15
             diffuse 0.65
             reflection 0.9
	}
}// end of texture
#declare WaterInterior = interior{I_Glass}
//================CAMERA==============================
camera {
	angle 36
	location <0,1,-10>
	look_at <DuckX,DuckY,DuckZ>
	rotate y*CamAngle
}
//=================LIGHT SOURCES======================
#declare Moon =
sphere {0, 	80
	pigment{Orange}
	normal {wrinkles 180 scale 30}
	finish { 	ambient 0.9 }
	photons { collect off }
}
light_source{ LightPos White*2
	#if(Photons)
		photons {refraction off reflection on}
	#end
	looks_like {object{Moon}}
}
light_source{ // Only used for caustics from behind
	<0,800,-500> White *0.3
	#if(Photons)
		photons {refraction off reflection on}
	#end
	rotate y*CamAngle	
}
//==================HORIZONT========================
#declare SkyCeiling =
sky_sphere{
	S_Cloud1 // Day sky
//	S_Cloud4 // Darker sky
      rotate  y*90*clock// Rotate around polaris.
}
#declare HorizontFog =
fog{ fog_type 2
	distance 85
//	color rgb<1,0.99,0.9>
	color rgb <0.687648, 0.692653, 0.443503>	fog_offset 0.1
    	fog_alt  2
    	turbulence 0.2
}
//====================WATER COMPONENTS============
//Water
#declare Water =
plane{y, 0
     texture{WaterTexture}
     interior{WaterInterior}
}// end of plane 2
#declare WaterInner=
box{
	<DuckX-2.001,-1.001,DuckZ+2.001>, <DuckX+2.001,0.002,DuckZ-2.001>
	texture{WaterTexture }// end of texture
	interior{WaterInterior}
	PhotonBlock()
}
#declare WaterOuter=
difference{
	object{Water}
	box{ <DuckX-2,-1,DuckZ+2>, <DuckX+2,0.001,DuckZ-2>
		     texture{WaterTexture}
		     interior{WaterInterior}
	}
      photons { collect off }
}
//==================SCENE OBJECTS HERE==================
background {
//	rgb <0.208116, 0.000000, 0.000000>
//	rgb <0.157534, 0.079240, 0.201770>
	rgb <0.080110, 0.000000, 0.200977>}
//sky_sphere{SkyCeiling}
//object{O_Cloud1} // Night sky
fog{HorizontFog}
//object{Water}
merge{ // Mandatory merge to not see gaps into water
	object{WaterOuter}
	object{WaterInner}
}
object{ EnteGanz rotate DuckRot translate <DuckX, DuckY+0.1, DuckZ> }
//object {Clouds scale 300} // distance above ground (y=0) to lowest parts of clouds

