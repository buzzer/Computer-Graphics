// Rune's Particle System
// Smoke
// Particle Element Include File
/*
The smoke particle element include file creates particles
of smoke using spheres filled with media.


Usage:

1) #include the smoke.inc include file before specifying any settings.

2) Specify the settings (described below).
   Settings that you don't want to be the same for all particles can
   be specified inside the particle_element() macro if you want.

3) Call the smoke_element() macro from inside the particle_element() macro, like this:
   
   #macro particle_element() smoke_element() #end

Settings (all optional, see the default values which are declared below):

   smoke_color         The color of the smoke element
   smoke_absorption    The amount of media absorption used for the smoke particle
   smoke_emission      The amount of media emission used for the smoke particle
   smoke_scattering    The amount of media scattering used for the smoke particle
   smoke_startsize     The radius of the smoke particle when the particle is born
   smoke_endsize       The radius of the smoke particle when the particle dies
   smoke_samples       The amount of media samples used for the smoke particle
   smoke_intervals     The amount of smoke intervals used for the smoke particle

*/

// Defaults:
   #declare smoke_color      = <0.5,0.5,0.5>;
   #declare smoke_absorption = 1.0;
   #declare smoke_emission   = 1.0;
   #declare smoke_scattering = 0.0;
   #declare smoke_startsize  = 1.0;
   #declare smoke_endsize    = 2.0;
   #declare smoke_samples    = 1;
   #declare smoke_intervals  = 10;
   
   
   
   #macro smoke_media()
      media {
         #if (smoke_emission  !=0) emission   (  smoke_color)*smoke_emission  *(1-p_state)  #end
         #if (smoke_absorption!=0) absorption (1-smoke_color)*smoke_absorption*(1-p_state)  #end
         #if (smoke_scattering!=0) scattering {1,smoke_color *smoke_scattering*(1-p_state)} #end
         intervals smoke_intervals
         samples smoke_samples,smoke_samples
         density {
            spherical triangle_wave
            translate  10*p_random
            warp {turbulence 2.5}
            translate -10*p_random
            
            scale smoke_startsize+(smoke_endsize-smoke_startsize)*p_state
            translate p_location
         }
      }
   #end
   
   #macro smoke_container()
      sphere {
         0, 1 hollow
         scale smoke_startsize+(smoke_endsize-smoke_startsize)*p_state
         translate p_location
      }
   #end
   
   #macro smoke_element()
      object {
         smoke_container()
         pigment {rgbf 1}
         interior {
            smoke_media()
         }
      }
   #end
   