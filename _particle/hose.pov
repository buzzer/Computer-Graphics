// Rune's Particle System
// Sample animation scene file
// 
// Suggested command line settings (for 25 frames per second):
// +kff25 +kc
// 
// Note: The first frame parses very slow, but the next are much faster.
//       This is due to the cyclic animation, where particle calculations
//       have to be tracked quite a bit back in time.
// 
// In this scene, one unit is one metre and one clock unit is one second.
   
   #declare WaterTex = 2; // 1 = solid (fast), 2 = transparent (slow)
   
   camera {
      location <-2,1,-4>
      look_at  <-2,1, 0>
   }
   background {rgb <0.4,0.6,0.8>}
   light_source {<1,2,-3>*1000, color 1.3}
   fog {
      fog_type 2
      fog_alt 50
      distance 60
      color <0.7,0.9,1.0>
   }
   
// Include particle system include file
// ************************************
   
   #include "particle.inc"
   
// Clock options
// *************
   
   #declare particle_start  = 0.0;
   #declare particle_end    = 1.0;
   #declare particle_cyclic = on;
   #declare particle_steps  = 40;
   
// General particle options
// ************************
   
   #declare particle_frequency = 300;
   #declare particle_life      = 3.0;
   #declare particle_lifeturb  = 0.0;
   #declare particle_seed      = 123;
   //#declare particle_maxnumber = 100;
   
// Environment options
// *******************
   
   #declare particle_drag      = 0.0;
   #declare particle_transfer  = 0.0;
   
   #macro particle_gravity  (Clock,Point) -10*y   #end
   #macro particle_wind     (Clock,Point) <0,0,0> #end
   
// Emitter options
// ***************
   
   #macro particle_emitter  (Clock) <0,0.15,0> #end
   #macro particle_emitting (Clock) on      #end
   #macro particle_emitvect (Clock) vrotate(6.5*y,(30+20*sin(Clock*2*pi))*z) #end
   #macro particle_emitturb (Clock) 0.2     #end
   //#macro particle_emitobj  (Clock) object {} #end
   #macro particle_emitobjn (Clock) 0.0     #end
   
// Collision options
// *****************
   
   #declare particle_blockobj     = plane {y,0}
   #declare particle_bounce       = 0.3;
   #declare particle_bounceturb   = 1.0;
   #declare particle_friction     = 1.0;
   #declare particle_bounceoffset = 0.01;
   //#macro particle_killobj    (Clock) object {}    #end
   
// Particle element macro (optional)
// *********************************
   
   #include "water.inc"
   
// These settings are constant in this example, so they can
// be #declared outside of the particle_element macro.
   #declare water_blob     = yes;
   #declare water_size     = 0.1;
   #declare water_sizeturb = 0.5;
   #declare water_stretch  = 0.0;
   #declare water_falloff  = 0.2;
   #declare water_strength = 2.0;
   
   #macro particle_element ()
//    Do things with the particle data here. Available data:
//    p_id,        p_random,    p_location,  p_direction, p_life,
//    p_age,       p_birth,     p_state,     p_rotate
      water_element()
   #end
   
// Call particle system
// ********************
   
   blob {
      threshold 1
      
      particle_system ("hose")
      
//    In case the particle system have no particles for the current
//    frame, place one invisible blob component to prevent an error.
      sphere {-100*y, 0.001, 0.001}
      
//    A clear water material
      #if (WaterTex=1) pigment {color rgb 1}  #end
      #if (WaterTex=2) pigment {color rgbf 1} #end
      finish {phong 1 phong_size 20}
      interior {ior 1.33 fade_distance 1 fade_power 2}
   }
   
// The ground
   object {
      particle_blockobj
      pigment {color <0.7,0.5,0.3>}
      normal {bumps 0.3 scale 0.15 turbulence 1}
   }
   
// Yellow hose thinghy
   union {
      sphere {
         -vnormalize(particle_emitvect(clock))*0.03,
         0.13
      }
      cylinder {
         -vnormalize(particle_emitvect(clock))*0.03,
         +vnormalize(particle_emitvect(clock))*0.20,
         0.13
      }
      translate particle_emitter(clock)
      pigment {color <1,1,0>}
   }
   