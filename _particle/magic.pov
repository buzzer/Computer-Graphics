// Rune's Particle System
// Sample animation scene file
// 
// Suggested command line settings (for 25 frames per second):
// +kff50 +kc
   
   camera {
      location <0,0.6,-1.8>
      look_at 0
   }
   
   global_settings {max_trace_level 50}
   
   sky_sphere {
      pigment {
         gradient y scale 2 translate -y
         color_map {
            [0.00, rgb <0.8,0.8,0.6>]
            [0.30, rgb <0.5,0.3,0.5>]
            [0.60, rgb <0.2,0.2,0.5>]
         }
      }
   }
   
// Include particle system include file
// ************************************
   
   #include "particle.inc"
   
// Clock settings
// **************
   
   #declare particle_start  = 0.0;
   #declare particle_end    = 1.0;
   #declare particle_cyclic = on;
   #declare particle_steps  = 20;
   
// General particle settings
// *************************
   
   #declare particle_frequency = 120;
   #declare particle_life      = 1.5;
   #declare particle_lifeturb  = 0.0;
   #declare particle_seed      = 123;
   //#declare particle_maxnumber = 100;
   
// Environment settings
// ********************
   
   #declare particle_drag      = 0.0;
   #declare particle_transfer  = 0.0;
   
   #macro particle_gravity  (Clock,Point) -1.0*y #end
   #macro particle_wind     (Clock,Point) <0,0,0> #end
   
// Emitter settings
// ****************
   
   #macro particle_emitter  (Clock) vrotate(y*0.50,360*z*Clock) #end
   #macro particle_emitting (Clock) on      #end
   #macro particle_emitvect (Clock) <0,0,0> #end
   #macro particle_emitturb (Clock) 0.4     #end
   //#macro particle_emitobj  (Clock) object {} #end
   #macro particle_emitobjn (Clock) 0.0     #end
   
// Collision settings
// ******************
   
// (Collision settings not used)
   
// Particle element macro (optional)
// *********************************
   
   #include "glow.inc"
   
// These settings are constant in this example, so they can
// be #declared outside of the particle_element macro.
   #declare glow_color     = <1.0,0.8,0.4>/2;
   #declare glow_colorturb = <0.3,0.3,0.3>;
   #declare glow_size      = 0.1;
   #declare glow_samples   = 1;
   
   #macro particle_element ()
//    Do things with the particle data here. Available data:
//    p_id,        p_random,    p_location,  p_direction, p_life,
//    p_age,       p_birth,     p_state,     p_rotate
      glow_element()
   #end
   
   
// Call particle system
// ********************
   
   particle_system ("glitter1")
   
   
// New system
// **********
// Has the same settings as the previous system,
// except the settings that are specified below:
   
// Emitter settings
// ****************
   #macro particle_emitter  (Clock) vrotate(-x*0.75,360*y*Clock) #end
   
// Particle element macro (optional)
// *********************************
   
   #declare glow_color     = <0.4,0.8,1.0>/2;
   #declare glow_colorturb = <0.3,0.3,0.3>;
   #declare glow_size      = 0.1;
   #declare glow_samples   = 1;
   
// The particle_element macro should be the same as before,
// so there is no need to specify it again.
   
   
// Call particle system
// ********************
   
   particle_system ("glitter2")
   