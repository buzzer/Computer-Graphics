// Rune's Particle System
// Sample animation scene file
// 
// Suggested command line settings (for 25 frames per second):
// +kff100 +kc
// 
// Note: The first frame parses very slow, but the next are much faster.
//       This is due to the cyclic animation, where particle calculations
//       have to be tracked quite a bit back in time.
   
   camera {
      location <15,15,-15>
      angle 20
      look_at <0,0,0>
   }
   
   background {color rgb <0.6,0.8,0.9>}
   
   light_source {<0,2,-1>*1000, color 1}
   
   global_settings {max_trace_level 50}
   
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
   
   #declare particle_frequency = 80;
   #declare particle_life      = 1.0;
   #declare particle_lifeturb  = 0.3;
   #declare particle_seed      = 123;
   //#declare particle_maxnumber = 100;
   
// Environment settings
// ********************
   
   #declare particle_drag      = 1.0;
   #declare particle_transfer  = 1.0;
   
   #macro particle_gravity  (Clock,Point) <0,0,0> #end
   #macro particle_wind     (Clock,Point) <4,0,0> #end
   
// Emitter settings
// ****************
   
   #macro particle_emitter  (Clock) vrotate(-3*x,360*y*Clock)*<1,1,cos(2*pi*Clock)> #end
   #macro particle_emitting (Clock) on      #end
   #macro particle_emitvect (Clock) 40*vnormalize(particle_emitter(Clock-0.01)-particle_emitter(Clock)) #end
   #macro particle_emitturb (Clock) 1.0     #end
   //#macro particle_emitobj  (Clock) object {} #end
   #macro particle_emitobjn (Clock) 0.0     #end
   
// Collision settings
// ******************
   
// (Collision settings not used)
   
// Particle element macro (optional)
// *********************************
   
   #include "smoke.inc"
   
// These settings are constant in this example, so they can
// be #declared outside of the particle_element macro.
   #declare smoke_emission   = 4;
   #declare smoke_absorption = 4;
   #declare smoke_scattering = 0;
   #declare smoke_startsize  = 0.2;
   #declare smoke_endsize    = 0.9;
   #declare smoke_samples    = 1;
   #declare smoke_intervals  = 3;
   
   #macro particle_element ()
//    Do things with the particle data here. Available data:
//    p_id,        p_random,    p_location,  p_direction, p_life,
//    p_age,       p_birth,     p_state,     p_rotate
      
//    This setting is dependent on the particle_element data,
//    so it is #declared inside of the particle_element macro.
      #declare smoke_color = 0.3+0.07*vaxis_rotate(x,<1,1,1>,360*p_birth); // nice color cycle
      
      smoke_element()
   #end
   
// Call particle system
// ********************
   
   particle_system ("smoke")
   
   #declare Missile =
   union {
      cylinder {0.0*z, 0.8*z, 0.1}
      cone {0.8*z, 0.1, 1.0*z, 0.0}
      cone {0.0*z, 0.2, 0.4*z, 0.0 scale <1.0,0.1,1.0>}
      cone {0.0*z, 0.2, 0.4*z, 0.0 scale <0.1,1.0,1.0>}
      pigment {color rgb 0.7}
      finish {phong 0.5}
   }
   
   object {
      Missile
      #declare Z = vnormalize(particle_emitter(clock+0.05)-particle_emitter(clock));
      #declare Y = y;
      #declare X = vcross(Y,Z);
      #declare P = particle_emitter(clock);
      matrix <X.x,X.y,X.z,Y.x,Y.y,Y.z,Z.x,Z.y,Z.z,P.x,P.y,P.z>
   }
   