// Rune's Particle System
// Sample animation scene file
// 
// Suggested command line settings (for 25 frames per second):
// +kff125 +kf5
// 
// In this scene, one unit is one metre and one clock unit is one second.
   
   #declare WaterTex = 2; // 1 = solid (fast), 2 = transparent (slow)
   
   camera {
      location <7,1,1> +<-0.5,0.1,-0.5>*clock
      look_at <2,-0.2,2.25>
      angle 70
   }
   background {color rgb 1}
   light_source {<1,1,-1>*1000, color 1.3}
   global_settings {max_trace_level 50 noise_generator 3}
   
// Include particle system include file
// ************************************
   
   #include "particle.inc"
   
// Clock options
// *************
   
   #declare particle_start  = 0.0;
   #declare particle_end    = 6.0;
   #declare particle_cyclic = off;
   #declare particle_steps  = 40;
   
// General particle options
// ************************
   
   #declare particle_frequency = 1000;
   #declare particle_life      = 6.0;
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
   
   #macro particle_emitter  (Clock) <-1.25,2,0> #end
   #macro particle_emitting (Clock) on      #end
   #macro particle_emitvect (Clock) <0,0,0> #end
   #macro particle_emitturb (Clock) 0.2     #end
   //#macro particle_emitobj  (Clock) object {} #end
   #macro particle_emitobjn (Clock) 0.0     #end
   
// Collision options
// *****************
   
   #declare particle_blockobj    =
   height_field {
      function 300,300 {pattern {bumps scale 0.1 translate <1.0,0.3,0.0>}}
      smooth
      translate <-0.5,-0.5,-0.2>
      scale <12,1.6,12>
      rotate -15*z
   }
   #declare particle_bounce       = 0.3;
   #declare particle_bounceturb   = 0.4;
   #declare particle_friction     = 0.0;
   #declare particle_bounceoffset = 0.05;
   //#macro particle_killobj    (Clock) object {}    #end
   
// Particle element macro (optional)
// *********************************
   
   #include "water.inc"
   
// These settings are constant in this example, so they can
// be #declared outside of the particle_element macro.
   #declare water_blob     = yes;
   #declare water_size     = 0.15;
   #declare water_sizeturb = 0;
   #declare water_stretch  = 0.02;
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
   
   blob {
      threshold 1
      
      particle_system ("flow")
      
//    In case the particle system have no particles for the current
//    frame, place one invisible blob component to prevent an error.
      sphere {-100*y, 0.001, 0.001}
      
//    A blue water material, because completely clear was too difficult to see properly.
      #if (WaterTex=1) pigment {color rgb <0.8,0.8,1.0>} #end
      #if (WaterTex=2) pigment {color rgbf 1}            #end
      finish {phong 1 phong_size 20}
      interior {ior 1.33 fade_distance 0.5 fade_power 2 fade_color blue 0.5}
   }
   
// The ground
   object {
      particle_blockobj translate -0.03*y
      pigment {color rgb 1}
      normal {bumps 0.1 scale 0.1 turbulence 1}
      finish {brilliance 0.5 phong 0.1 phong_size 20}
   }
   
// Tube
   union {
      cylinder {0, -0.4*y, 0.2}
      cylinder {-2*x, 0, 0.2}
      cylinder {0, -5*y, 0.2 translate -2*x}
      sphere {0, 0.2}
      sphere {-2*x, 0.2}
      pigment {rgb <0.6,0.5,0.4>}
      normal {bumps 0.3 scale 0.05}
      finish {brilliance 2 phong 1}
      translate <-1.25,2.2,0>
   }
   