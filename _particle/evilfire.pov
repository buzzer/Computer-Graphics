// Rune's Particle System
// Sample animation scene file
// 
// Suggested command line settings (for 25 frames per second):
// +kff25 +kc
// 
// Note: The first frame parses very slow, but the next are much faster.
//       This is due to the cyclic animation, where particle calculations
//       have to be tracked quite a bit back in time.
   
   #macro Symbol(W)
      union {
         torus {1, W}
         cylinder {z, vrotate(z,2/5*360*y), W rotate 0/5*360*y}
         cylinder {z, vrotate(z,2/5*360*y), W rotate 1/5*360*y}
         cylinder {z, vrotate(z,2/5*360*y), W rotate 2/5*360*y}
         cylinder {z, vrotate(z,2/5*360*y), W rotate 3/5*360*y}
         cylinder {z, vrotate(z,2/5*360*y), W rotate 4/5*360*y}
         pigment {rgb 0.2}
         normal {granite 0.5 scale 0.5}
         translate 0.2*y
         scale 24
      }
   #end
   
   object {Symbol(0.04)}
   
// Include particle system include file
// ************************************
   
   #include "particle.inc"
   
// Clock settings
// **************
   
   #declare particle_start  = 0.0;
   #declare particle_end    = 1.0;
   #declare particle_cyclic = on;
   #declare particle_steps  = 100;
   
// General particle settings
// *************************
   
   #declare particle_frequency = 2000;
   #declare particle_life      = 0.7;
   #declare particle_lifeturb  = 0.4;
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
   #macro particle_emitturb (Clock) 0.0     #end
   #macro particle_emitobj  (Clock) object {Symbol(0.03) rotate 1/5*360*z rotate 360*Clock*y*0 rotate -1/5*360*z} #end
   #macro particle_emitobjn (Clock) 0.1     #end
   
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
   #declare fire_color      = <0.85,0.40,0.15>;
   #declare fire_intensity  = 1.5;
   #declare fire_highlight  = 2.0;
   #declare fire_samples    = 1;
   #declare fire_turbulence = 0.7;
   #declare fire_size       = 1.0;
   #declare fire_stretch    = 0.1;
   
   fire_create("fire")
   
// Scene setup
// ***********
   
   camera {
      location <10,100,-100>
      angle 22
      look_at <-8,4,0>
   }
   
   global_settings {max_trace_level 50 ambient_light 0}
   
   sky_sphere {
      pigment {
         cylindrical rotate 90*x poly_wave 2
         color_map {[0.0, rgb 0.0][1.0, rgb 0.0]}
      }
   }
   
   light_source {
      <-0, 90,-30>, rgb 0.3
      spotlight
      point_at <0,0,0>
      radius 0
      falloff 20
   }
   light_source {5*y, red 0.5 shadowless fade_power 2 fade_distance 25}
   
   plane {
      y, 0
      pigment {
         marble turbulence 1 scale 10
         color_map {
            [0.0, rgb <0.90,0.85,0.80>]
            [0.8, rgb <0.80,0.60,0.40>]
         }
      }
      normal {marble 1.0 turbulence 1 scale 10}
   }
   