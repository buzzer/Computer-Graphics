// Open Water scene duration shall be 20 sec!
//================POVRAY GLOBALS======================
#include "ScenesGlobals.inc"
//================PHOTONS CONTROL====================
#declare DuckZStart = -10;
#declare DuckZ = DuckZStart+clock*60; // ca. 200 frames
#declare Photons = off;
#if(DuckZ > -10)
	#if(DuckZ < 5)
		#declare Photons = on;
	#end
#end
global_settings {
	max_trace_level 10
	#if(Photons)
		photons {
			spacing 0.005
	//	      jitter 0.5
		}
	#end
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
#declare DuckRot = <0,-90,0>;//180*clock;
// Light: Sync light with moon/sun
#declare LightPos = <0,40,1000>;//<500,500, -1000>;
// Ducky movement
#declare KopfAngMax = 25;
#declare KopfRollMax = 15;
#declare KopfPitch = 0*KopfAngMax;
#declare KopfRoll = KopfRollMax*sin(pi*20*clock);
#declare KopfYaw = KopfAngMax*sin(pi*20*clock);
#declare BuerzelPitch = KopfAngMax * abs(sin(pi*40*clock));
#declare WingAngMax = 110;
#declare WingRAngle = WingAngMax * abs(sin(pi*40*clock));
#declare WingLAngle = WingRAngle;
#declare CamKugelRotFreq = 360*20*clock; // Optimal for 20 sec per scene
// Water
#declare WaterPhase = -10*pi*clock; // Optimized for 20 sec per scene
//=================INCLUDE FILES=======================
#include "colors.inc"
#include "skies.inc"
#include "textures.inc"
#include "glass.inc"
#include "Ente.inc"
//#include "fastsky.inc"
#include "helferleinSitting.inc"
#include "kugel.inc"
//=================SEA WATER==========================
#declare WaterTexture =
texture{ Green_Glass
	normal{
       	ripples 0.3 // More regular, e.g. indoor
//           bumps 0.3 // Mor turbulenced, e.g. outdoor, but no dynamics!
             scale 2
             turbulence 0.75
		sine_wave phase WaterPhase  // Dynamic waves
		translate -z*100 // Normal should not be visible
	}
       finish{
       	ambient 0.00
             diffuse 0.65
             reflection 0.9
	}
}// end of texture
#declare WaterInterior = interior{I_Glass}
//================CAMERA==============================
#declare CamDefaultY = 1;
#declare CamX = 0;
#declare CamY = CamDefaultY + 1.5*(1/DuckZStart *DuckZ);
#declare CamZ = -10;
camera {
	angle 36
	#if (DuckZ < 0)
		location <CamX, CamY ,CamZ>
		look_at <DuckX, DuckY, 0>
	#else
		location <CamX, CamDefaultY, CamZ>
		look_at <DuckX,DuckY,DuckZ>
	#end
	rotate y*CamAngle
}
//=================LIGHT SOURCES======================
#declare Moon =
sphere {0, 	80
	pigment{Orange}
//	normal { wrinkles 180 scale 30}
	finish { 	ambient 20 }
	photons { collect off }
	scale x*1.2
}
light_source{ LightPos White*2
//	#if(Photons)
//		photons {refraction off reflection on}
//	#end
	looks_like {object{Moon}}
}
light_source{ // Only used for caustics from behind
//	<0,100,-500> White *0.1
	<CamX, CamY, CamZ> White *0.1
	#if(Photons)
		photons {refraction off reflection on}
	#end
	rotate y*CamAngle	
}
//==================HORIZONT========================
#declare HorizontFog =
fog{ fog_type 2
	distance 85
//	color rgb<1,0.99,0.9>
//	color rgb <0.687648, 0.692653, 0.443503>
//	rgb <0.646250, 0.351247, 0.174563>
	rgb <0.677562, 0.407568, 0.195331>
	fog_offset 0.1
    	fog_alt  8
    	turbulence 0.2
//	turbulence 1000
//	omega 0.5
//	lambda 0.2*100
//	octaves 6
//	turb_depth 0.5
}
//====================WATER COMPONENTS============
//Water
#declare Water =
difference {
	plane{y, 0
	     texture{WaterTexture}
	     interior{WaterInterior}
	}// end of plane 2
	plane {y, -1.1	pigment{Black} } // Darker
}
#declare WaterInner=
box{
	<DuckX-2.00001,-1.00001,DuckZ+2.00001>, <DuckX+2.00001,0.00002,DuckZ-2.00001>
	texture{WaterTexture }// end of texture
	interior{WaterInterior}
	PhotonBlock()
}
#declare WaterOuter=
difference{
	object{Water}
	box{ <DuckX-2,-1,DuckZ+2>, <DuckX+2,0.00001,DuckZ-2>
		     texture{WaterTexture}
		     interior{WaterInterior}
	}
      photons { collect off }
}
//==================SCENE OBJECTS HERE==================
background {
//	rgb <0.208116, 0.000000, 0.000000>
//	rgb <0.157534, 0.079240, 0.201770>
//	rgb <0.080110, 0.000000, 0.200977>
//	rgb <0.748928, 0.357305, 0.068376>
//	rgb <0.874998, 0.526329, 0.252247>
//	rgb <0.194903, 0.465370, 0.539498>
//	rgb <0.084459, 0.201663, 0.233783>
//	rgb <0.025971, 0.062058, 0.071931>
//	rgb <0.000000, 0.015442, 0.017975>
	rgb <0.009369, 0.031022, 0.035950>
}
//sky_sphere{SkyCeiling}
//object{O_Cloud1} // Night sky
fog{HorizontFog}
//object{Water}
merge{ // Mandatory merge to not see gaps into water
	object{WaterOuter}
	object{WaterInner}
}
//object {Clouds scale 300} // distance above ground (y=0) to lowest parts of clouds
object{ EnteGanz rotate DuckRot translate <DuckX, DuckY+0.1, DuckZ> }
//======================OTHER OBJECTS=====================
object{ helferlein rotate y*90 scale 1 translate <DuckX, DuckY-0.4, DuckZ-0.8> }
object{ CamKugel scale 0.2 translate <DuckX-2, DuckY+2, DuckZ-3> }