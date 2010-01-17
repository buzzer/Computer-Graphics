#include "colors.inc"
#include "skies.inc"
#include "textures.inc"
#include "glass.inc"
#include "Ente.inc"

//================SCENE CONSTANTS====================
// Entenposition
#declare DuckX = 0;
#declare DuckY = 0;
#declare DuckZ = 0;
#declare DuckRot = 0;//180*clock;

camera {
	angle 36
	location <0 , 1.0 ,-10.0>
	look_at <0,0,0>
//	rotate   <0,-360*(clock+0.10),0>
//            aperture 2           // [0...N] larger is narrower depth of field (blurrier)
//            blur_samples 200        // number of rays per pixel for sampling
//            focal_point <0,0,0>    // point that is in focus <X,Y,Z>
//            confidence 0.95           // [0...<1] when to move on while sampling (smaller is less accurate)
//            variance 1/200            // [0...1] how precise to calculate (smaller is more accurate)
}
light_source{<500,500, -1000> White}

#declare SkyCeiling =
sky_sphere{
	S_Cloud1
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

//Water
#declare Water =
plane{y, 0
      texture{ Green_Glass
              normal{
              	 ripples 0.3 // More regular, e.g. indoor
//              	 bumps 0.3 // Mor turbulenced, e.g. outdoor
                     scale 0.25
                     turbulence 0.75
		        translate <DuckX, 0, DuckZ> // Dynamic take duck position
			 sine_wave phase -1/4*pi*clock  // Dynamic waves
		}
              finish{
              	 ambient 0.15
                     diffuse 0.65
                     reflection 0.3}
             }// end of texture
     interior{I_Glass}
     }// end of plane 2

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
//==================SCENE OBJECTS HERE==================
sky_sphere{SkyCeiling}
fog{HorizontFog}
object{Water}
object{Ground}
object{ EnteGanz rotate DuckRot translate <DuckX, DuckY, DuckZ> }


