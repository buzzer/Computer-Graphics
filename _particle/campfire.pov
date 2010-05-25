// Rune's Particle System
// Sample animation scene file
// 
// Suggested command line settings (for 25 frames per second):
// +kff50 +kf2 +kc
   
   
// Include particle system include file
// ************************************
   
   #include "particle.inc"
   
// Clock settings
// **************
   
   #declare particle_start  = 0.0;
   #declare particle_end    = 2.0;
   #declare particle_cyclic = on;
   #declare particle_steps  = 100;
   
// General particle settings
// *************************
   
   #declare particle_frequency = 40;
   #declare particle_life      = 0.7;
   #declare particle_lifeturb  = 0.3;
   #declare particle_seed      = 123;
   //#declare particle_maxnumber = 100;
   
// Environment settings
// ********************
   
   #declare particle_drag      = 0.0;
   #declare particle_transfer  = 0.0;
   
   #macro particle_gravity  (Clock,Point) 40*y #end
   #macro particle_wind     (Clock,Point) <0,0,0> #end
   
// Emitter settings
// ****************
   
   #macro particle_emitter  (Clock) <0,0,0> #end
   #macro particle_emitting (Clock) on      #end
   #macro particle_emitvect (Clock) <0,0,0> #end
   #macro particle_emitturb (Clock) 1.5     #end
   #macro particle_emitobj  (Clock) sphere {0, 2.0 scale <1,0.1,1> translate 0.5*y} #end
   #macro particle_emitobjn (Clock) 0.0     #end
   
// Collision settings
// ******************
   
// (Collision settings not used)
   
// Call particle system
// ********************
   
   particle_system ("fire")
   
// Load system
// ***********
   
   #include "fire.inc"
   
   #declare fire_method     = 1;
   #declare fire_color      = <0.85,0.45,0.15>;
   #declare fire_intensity  = 2.0;
   #declare fire_highlight  = 2.0;
   #declare fire_samples    = 5;
   #declare fire_turbulence = 1.0;
   #declare fire_size       = 1.2;
   #declare fire_stretch    = 0.1;
   
   fire_create("fire")
   
// Scene setup
// ***********
   
   camera {
      location <0,7,-35>
      angle 35
      look_at <0,5,0>
   }
   
   global_settings {max_trace_level 50 ambient_light 0}
   
   sky_sphere {
      pigment {
         planar poly_wave 2
         color_map {[0.0, rgb 0][0.95, rgb <0.1,0.2,0.4>][1.0, rgb 0]}
      }
   }
   
   light_source {
      fire_center, color 0.25*fire_light*<1.0,0.7,0.4>
      fade_power 2 fade_distance 10
      area_light 5*x, 5*z, 5, 5 jitter adaptive 0 circular orient
   }
   light_source {
      <0,7,-35>, 1.0 shadowless
      fade_power 2 fade_distance 10
   }
   
// Ground
   plane {
      y, 0
      pigment {color <0.4,1.0,0.4>}
      normal {bumps 0.3 scale 0.3}
   }
   
// Those things you can sit on
   union {
      cylinder {0, 4*y, 3 translate <+1,0,+1>*10}
      cylinder {0, 4*y, 3 translate <-1,0,+1>*10}
      cylinder {0, 4*y, 3 translate <+1,0,-1>*10}
      cylinder {0, 4*y, 3 translate <-1,0,-1>*10}
      pigment {color <0.6,0.4,0.2>}
      normal {bumps scale <0.1,1,0.1>}
   }
   
// Stones around the fire
   union {
      sphere {5*x, 2 rotate 1/8*360*y}
      sphere {5*x, 2 rotate 2/8*360*y}
      sphere {5*x, 2 rotate 3/8*360*y}
      sphere {5*x, 2 rotate 4/8*360*y}
      sphere {5*x, 2 rotate 5/8*360*y}
      sphere {5*x, 2 rotate 6/8*360*y}
      sphere {5*x, 2 rotate 7/8*360*y}
      sphere {5*x, 2 rotate 8/8*360*y}
      pigment {color rgb 0.5}
      normal {bumps 1 scale 1}
   }
   