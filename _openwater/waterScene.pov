#include "colors.inc"
#include "skies.inc"
#include "textures.inc"
#include "glass.inc"
#include "Ente.inc"
//#include "fastsky.inc"
//================POVRAY SPECIFIC======================
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
//================CAMERA==============================
camera {
	angle 36
//	location <0 , 1.0 ,-10.0>
	location <0,1,-10>
	look_at <DuckX,DuckY,DuckZ>
//	rotate   <0,-360*(clock+0.10),0>
//            aperture 2           // [0...N] larger is narrower depth of field (blurrier)
//            blur_samples 200        // number of rays per pixel for sampling
//            focal_point <0,0,0>    // point that is in focus <X,Y,Z>
//            confidence 0.95           // [0...<1] when to move on while sampling (smaller is less accurate)
//            variance 1/200            // [0...1] how precise to calculate (smaller is more accurate)
}
light_source{ LightPos White*0.8
//	#if(Photons)
//		photons {refraction off reflection on}
//	#end
}
light_source{
	<100,100,-100> White *0.8
	#if(Photons)
		photons {refraction off reflection on}
	#end	
}

#declare SkyCeiling =
sky_sphere{
	S_Cloud1 // Day sky
//	S_Cloud4 // Darker sky
      rotate  y*90*clock// Rotate around polaris.
}
#declare HorizontFog =
fog{ fog_type 2
	distance 85
	color rgb<1,0.99,0.9>
    	fog_offset 0.1
    	fog_alt  2
    	turbulence 0.2
}
#declare WaterTexture=  texture{ Green_Glass
              normal{
              	 ripples 0.3 // More regular, e.g. indoor
//              	 bumps 0.3 // Mor turbulenced, e.g. outdoor, but no dynamics!
                     scale 2
                     turbulence 0.75
//		        translate <DuckX, 0, DuckZ> // Dynamic take duck position
			 sine_wave phase -1/2*pi*clock  // Dynamic waves
		}
              finish{
              	 ambient 0.15
                     diffuse 0.65
                     reflection 0.9}
             }// end of texture
#declare WaterInterior = interior{I_Glass}
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
      photons { 
      		collect off
//		pass_through on
      }

}
//Ground
#declare Ground =
plane { y, -5 
	texture{ pigment{ color LightWood}
		normal {bumps 0.25
             		scale 0.05}
             finish {ambient 0.45
             		diffuse 0.55}
       }// end of texture
}
#declare Moon =
sphere {
	LightPos+z*41,
	80
//	pigment {Goldenrod}
	pigment{Orange}
	normal {wrinkles 180 scale 30}
	finish {
//		ambient <1,0.3,0>*0.8
		ambient 0.9
	 }
	photons { collect off }
}
//==================SCENE OBJECTS HERE==================
background {
		rgb <0.208116, 0.000000, 0.000000>
}
//sky_sphere{SkyCeiling}
//object{O_Cloud1} // Night sky
fog{HorizontFog}
object{Moon}
//object{Water}
merge{
	object{WaterOuter}
	object{WaterInner}
}
//object{Ground} // If water is not very deep
object{ EnteGanz rotate DuckRot translate <DuckX, DuckY+0.1, DuckZ> }
//object {Clouds scale 300} // distance above ground (y=0) to lowest parts of clouds

