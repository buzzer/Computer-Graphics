// Rune's Particle System
// Fire
// Particle Element Include File
/*
The fire particle element include file creates flames of fire on the
location of each particle using spheres filled with media.


Usage:

1) #include the fire.inc include file before specifying any settings.

2) Specify the settings (described below).

3) Call the fire_create() macro with a string with name of the
   particle system as parameter. For example:
   
   fire_create("system1")

4) The fire is now created, and you also have access to the following
   global variables which have been calculated:
   
   fire_center       Vector which is a weighted average of the locations of the flames.
   
   fire_light        Float value which approximately follows the total brightness of the fire.
                     
   These values can for example be used to create a single light_source which follows the fire.
   The fire_light value often needs to be multiplied with a constant though.

Settings (all optional, see the default values which are declared below):

   fire_method       Method 1 creates individual spheres with individual interiors.
                     Method 2 creates a merge of the spheres, which contains the interiors of all the particles.
   
   fire_color        The color of the flames.
   fire_intensity    The intensity of the flames.
   fire_highlight    Can be used to control an overexposure-like effect.
   fire_samples      Amount of media samples used.
   fire_turbulence   Turbulence of the flames.
   fire_size         Size of the flames.
   fire_stretch      How much the flames are stretched longer in the vector of movement.

*/

// Defaults:
   #declare fire_method     = 1;
   #declare fire_color      = <0.85,0.45,0.15>;
   #declare fire_intensity  = 2.0;
   #declare fire_highlight  = 2.0;
   #declare fire_samples    = 1; // very low, but sometimes enough.
   #declare fire_turbulence = 1.0;
   #declare fire_size       = 1.0;
   #declare fire_stretch    = 1.0; // important to adjust to the individual scene!
   
   
   
   #macro Size(P) sin(pow(1-P,2)*pi)*1.5 #end
   
   #macro fire_media()
      media {
         emission fire_intensity*(1-pow(p_state,2))
         intervals 1
         samples fire_samples,fire_samples
         density {
            spherical scale fire_size*0.8/3
            translate -10*p_random*x
            warp {turbulence fire_turbulence}
            translate 10*p_random*x
            transform {rotate p_rotate inverse}
            scale <1,1,1+vlength(p_direction)*fire_stretch>*3*Size(p_state)
            rotate p_rotate
            color_map {[0, rgb 0][0.3, rgb fire_color][1.0, rgb fire_color+fire_highlight*(1-p_state)]}
         }
         translate p_location
      }
      media {
         absorption fire_intensity*(1-pow(p_state,2))
         intervals 1
         samples fire_samples,fire_samples
         density {
            spherical scale fire_size*0.8/3
            translate -10*p_random*x
            warp {turbulence fire_turbulence}
            translate 10*p_random*x
            transform {rotate p_rotate inverse}
            scale <1,1,1+vlength(p_direction)*fire_stretch>*3*Size(p_state)
            rotate p_rotate
            color_map {[0, rgb 0][0.3, rgb (1-fire_color)][1, rgb 0]}
         }
         translate p_location
      }
   #end
   
   #macro fire_container()
      sphere {0, fire_size scale <1,1,1+vlength(p_direction)*fire_stretch>*Size(p_state) rotate p_rotate translate p_location}
   #end
   
   #macro fire_create(fire_system)
      
      #declare Cm = load_system (fire_system);
      
      #if (fire_method=1)
         union {
            #local C = 0;
            #while (C<Cm)
               object {
                  load_particle(C)
                  fire_container()
                  pigment {color rgbf 1}
                  interior {fire_media()}
               }
               #declare C = C+1;
            #end
            hollow no_shadow
         }
      #end
      
      #if (fire_method=2)
         merge {
            #local C = 0;
            #while (C<Cm)
               load_particle(C)
               fire_container()
               #declare C = C+1;
            #end
            pigment {color rgbf 1}
            interior {
               #local C = 0;
               #while (C<Cm)
                  load_particle(C)
                  fire_media()
                  #declare C = C+1;
               #end
            }
            hollow no_shadow
         }
      #end
      
      #local C = 0;
      #local L = 0;
      #local V = <0,0,0>;
      #while (C<Cm)
         load_particle(C)
         #local W = pow(sin(pow(1-p_state,1)*pi),2)*(1-pow(p_state,2));
         #declare L = L+W;
         #declare V = V+p_location*W;
         #declare C = C+1;
      #end
      #declare V = V/L;
      #declare fire_center = V;
      #declare fire_light = L;
      
   #end