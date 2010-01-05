// Rune's Particle System
// Sample animation scene file
// 
// Suggested command line settings (for 25 frames per second):
// +kff150 -kc
   
   #include "lamp.inc"
   
   camera {
      location <-10,10,-30>
      look_at 5*y
      angle 30
   }
   
   global_settings {max_trace_level 200}
   
   light_source {
      < -3, 20, -7>, color 0.9
      spotlight point_at 5*y radius 10 falloff 60
   }
   light_source {
      <-10, 10,-30>, color 0.6 shadowless
      spotlight point_at 5*y radius  5 falloff 25
   }
   
   #declare Room =
   union {
      plane { y,  0}
      plane {-z, -5}
      plane {-x, -5}
      pigment {color <1.00,0.85,0.60>}
      normal {wrinkles 0.3 turbulence 1}
   }
   
   object {Room}
   
   #declare Location_Spline =
   spline {
      natural_spline
      0.00, < -2,0,  2>,
      0.10, < -2,0,  2>,
      0.11, < -2,0,  2>,
      0.20, < -2,5,  2>,
      0.30, < -2,5,  2>,
      0.40, < -4,5, -2>,
      0.55, <  2,5, -6>,
      0.65, < -2,6,-10>,
      0.75, < -2,6,-10>,
      1.00, <-32,9,-40>,
      1.25, <-62,9,-70>
   }
   #declare Rotation_Spline =
   spline {
      natural_spline
      0.00,  90*y,
      0.10,  90*y,
      0.11,  90*y,
      0.20, 110*y,
      0.30, 120*y,
      0.40, 200*y,
      0.55, 500*y,
      0.65, 590*y,
      0.75, 585*y,
      1.00, 585*y
   }
   
// Include particle system include file
// ************************************
   
   #include "particle.inc"
   
// Clock options
// *************
   
   #declare particle_start  = -0.2;
   #declare particle_end    =  1.2;
   #declare particle_cyclic = off;
   #declare particle_steps  = 100;
   
// General particle options
// ************************
   
   #declare particle_frequency = 1600;
   #declare particle_life      = 0.2;
   #declare particle_lifeturb  = 0.0;
   #declare particle_seed      = 123;
   //#declare particle_maxnumber = 100;
   
// Environment options
// *******************
   
   #declare particle_drag      = 0.5;
   #declare particle_transfer  = 1.0;
   
   #macro particle_gravity  (Clock,Point) -8*y    #end
   #macro particle_wind     (Clock,Point) <0,0,0> #end
   
// Emitter options
// ***************
   
   #macro particle_emitter  (Clock) Location_Spline(Clock)+y #end
   #macro particle_emitting (Clock) on      #end
   #macro particle_emitvect (Clock) <0,0,0> #end
   #macro particle_emitturb (Clock) 5.0     #end
   #macro particle_emitobj  (Clock)
      object {
         Lamp
         rotate    Rotation_Spline(Clock)
         translate -y
      }
   #end
   #macro particle_emitobjn (Clock) 10.0    #end
   
// Collision options
// *****************
   
   #declare particle_blockobj     = Room
   #declare particle_bounce       = 0.0;
   #declare particle_bounceturb   = 0.0;
   #declare particle_friction     = 0.0;
   #declare particle_bounceoffset = 0.01;
   //#macro particle_killobj    (Clock) object {}    #end
   
// Particle element macro (optional)
// *********************************
   
   #include "glitter.inc"
   
   #declare camera_location = <-10,10,-30>;
   #declare camera_sky = y;
   
   #declare glitter_blockobj =
   union {
      object {Lamp rotate Rotation_Spline(clock) translate Location_Spline(clock)}
      object {Room}
   }
   
   #declare glitter_color     = <1.0,0.8,0.2>;
   #declare glitter_colorturb = <0.3,0.3,0.3>;
   #declare glitter_size      = 0.15;
   
   #macro particle_element ()
//    Do things with the particle data here. Available data:
//    p_id,        p_random,    p_location,  p_direction, p_life,
//    p_age,       p_birth,     p_state,     p_rotate
      glitter_element()
   #end
   
// Call particle system
// ********************
   
   particle_system ("lamp")
   
   object {
      Lamp
      rotate    Rotation_Spline(clock)
      translate Location_Spline(clock)
   }
   