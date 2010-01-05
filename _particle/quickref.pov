// Rune's Particle System
// Quick Reference
   
   
// Include particle system include file
// ************************************
   
   #include "particle.inc"
   
// Clock settings
// **************
   
   #declare particle_start  = 0.0;
   #declare particle_end    = 1.0;
   #declare particle_cyclic = off;
   #declare particle_steps  = 100;
   
// General particle settings
// *************************
   
   #declare particle_frequency = 100;
   #declare particle_life      = 1.0;
   #declare particle_lifeturb  = 0.0;
   #declare particle_seed      = 123;
   //#declare particle_maxnumber = 100;
   
// Environment settings
// ********************
   
   #declare particle_drag      = 0.0;
   #declare particle_transfer  = 0.0;
   
   #macro particle_gravity  (Clock,Point) <0,0,0> #end
   #macro particle_wind     (Clock,Point) <0,0,0> #end
   
// Emitter settings
// ****************
   
   #macro particle_emitter  (Clock) <0,0,0> #end
   #macro particle_emitting (Clock) on      #end
   #macro particle_emitvect (Clock) <0,0,0> #end
   #macro particle_emitturb (Clock) 0.0     #end
   //#macro particle_emitobj  (Clock) object {} #end
   #macro particle_emitobjn (Clock) 0.0     #end
   
// Collision settings
// ******************
   
   //#declare particle_blockobj     = object {}
   #declare particle_bounce       = 0.5;
   #declare particle_bounceturb   = 0.5;
   #declare particle_friction     = 0.0;
   #declare particle_bounceoffset = 0.01;
   //#macro particle_killobj    (Clock) object {}    #end
   
// Particle element macro (optional)
// *********************************
   
   #macro particle_element ()
//    Do things with the particle data here. Available data:
//    p_id,        p_random,    p_location,  p_direction, p_life,
//    p_age,       p_birth,     p_state,     p_rotate
   #end
   
// Call particle system
// ********************
   
   particle_system ("system1")
   
// Load system (optional)
// **********************
   
   #declare Number_Of_Particles = load_system ("system1");
   
   #declare Counter = 0;
   #while (Counter<Number_Of_Particles)
      load_particle(Counter)
//    Do things with the particle data here. Available data:
//    p_id,        p_random,    p_location,  p_direction, p_life,
//    p_age,       p_birth,     p_state,     p_rotate
      #declare Counter = Counter+1;
   #end
   