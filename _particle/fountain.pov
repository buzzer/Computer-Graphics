// Rune's Particle System
// Sample animation scene file
// 
// Suggested command line settings (for 25 frames per second):
// +kff25 +kc
// 
// Note: The first frame parses very slow, but the next are much faster.
//       This is due to the cyclic animation, where particle calculations
//       have to be tracked quite a bit back in time.


// Demo scene with (somewhat) realistic units.
// 
// In this scene I have tried to use realistic units for everything. Still, the
// simulation seems to be going too fast, but it might just be me. It is
// supposed to look right, since the gravity etc. are based on real-life values.
// 
// 1 distance unit = 1 metre
//    1 clock unit = 1 second
//         gravity = 9.8 m/s/s
//            drag = 0.25 *
// 
// I read about the terminal velocity for water drops, and from that I could
// calculate the drag value.
// 
// terminal velocity of water drops (in metres per second):
// 6.26 = sqrt(gravity/drag) = sqrt(9.8/0.25)
   
   #declare WaterTex = 2; // 1 = solid (fast), 2 = transparent (slow)
   
   camera {
      location < 2.0, 2.0,-6.0>
      angle 35
      look_at  <-0.3, 1.1, 0.0>
   }
   
   global_settings {max_trace_level 200}
   background {rgb 1}
   
   light_source {<+0.0,1.7,+4.9>*1.25, color 1 fade_power 2 fade_distance 2.5}
   light_source {<+0.0,1.7,-4.9>*1.25, color 1 fade_power 2 fade_distance 2.5}
   light_source {<+2.9,1.7,+2.0>*1.25, color 1 fade_power 2 fade_distance 2.5}
   light_source {<+2.9,1.7,-2.0>*1.25, color 1 fade_power 2 fade_distance 2.5}
   light_source {<-2.9,1.7,+2.0>*1.25, color 1 fade_power 2 fade_distance 2.5}
   light_source {<-2.9,1.7,-2.0>*1.25, color 1 fade_power 2 fade_distance 2.5}
   
   // Room
   box {
      -1, 1 scale <3.75,3,6.25>
      pigment {rgb <0.9,0.9,0.8>}
      inverse
   }
   plane {
      y, 0
      texture {
         pigment {checker rgb <0.45,0.45,0.35> rgb <0.50,0.50,0.40>}
         normal {
            boxed 1 scale 0.5 translate 0.5*<1,0,1>
            warp {repeat x} warp {repeat z}
            slope_map {[0.0,<0,1>][0.05,<1,0>]}
         }
         finish {phong 0.5}
         scale 0.5 translate 0.25*<1,0,1>
      }
   }
   
   #declare Env =
   union {
      difference {
         box {<-1.25,0.0,-1.25>, <1.25,0.5,1.25>}
         box {<-0.95,0.1,-0.95>, <0.95,1.0,0.95>}
      }
      box {<-0.4,0,-0.4>, <0.4,1.0,0.4>}
      sphere {0, 1 scale <0.35,0.15,0.35> translate 1.0*y}
      pigment {rgb <0.85,0.78,0.70>}
      finish {phong 0.5}
   }
   object {Env}
   
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
   
   #declare particle_frequency = 500;
   #declare particle_life      = 2.0;
   #declare particle_lifeturb  = 0.0;
   #declare particle_seed      = 123;
   //#declare particle_maxnumber = 100;
   
// Environment settings
// ********************
   
   #declare particle_drag      = 0.25;
   #declare particle_transfer  = 0.0;
   
   #macro particle_gravity  (Clock,Point) -9.8*y  #end
   #macro particle_wind     (Clock,Point) <0,0,0> #end
   
// Emitter settings
// ****************
   
   #macro particle_emitter  (Clock) <0,1.1,0> #end
   #macro particle_emitting (Clock) on      #end
   #macro particle_emitvect (Clock) 5*y     #end
   #macro particle_emitturb (Clock) 0.3     #end
   #macro particle_emitobj  (Clock) object{sphere {0, 0.05}} #end
   #macro particle_emitobjn (Clock) 0.0     #end
   
// Collision settings
// ******************
   
   #declare particle_blockobj     = object {Env}
   #declare particle_bounce       = 0.2;
   #declare particle_bounceturb   = 0.3;
   #declare particle_friction     = 0.4;
   #declare particle_bounceoffset = 0.01;
   #declare KillObj = plane {y,0.3}
   #macro particle_killobj (Clock) KillObj #end
   
// Particle element macro (optional)
// *********************************
   
   #include "water.inc"
   
// These settings are constant in this example, so they can
// be #declared outside of the particle_element macro.
   #declare water_blob     = yes;
   #declare water_size     = 0.02;
   #declare water_sizeturb = 0.0;
   #declare water_stretch  = 0.05;
   #declare water_falloff  = 0.0;
   #declare water_strength = 1.5;
   
   #macro particle_element ()
//    Do things with the particle data here. Available data:
//    p_id,        p_random,    p_location,  p_direction, p_life,
//    p_age,       p_birth,     p_state,     p_rotate
      water_element()
   #end
   
// Call particle system
// ********************
   
   union {
      
      blob {
         threshold 1
         particle_system ("fountain")
      }
      
      #include "functions.inc"
      
      height_field {
         function 50, 50 {f_noise3d(x*40,y*40,z*40+10*clock)*(1-clock)+f_noise3d(x*40,y*40,z*40+10*clock-10)*clock}
         smooth
         translate -0.5 scale <2.4,0.05,2.4> translate 0.45*y
      }
      
      #if (WaterTex=1) pigment {color rgb 2}  #end
      #if (WaterTex=2) pigment {color rgbf 1} #end
      finish {reflection {0.1,0.9 fresnel} conserve_energy phong 1 phong_size 20}
      interior {ior 1.33}
   }
   