// Rune's Particle System
// Glow
// Particle Element Include File
/*
The glow particle element include file creates glows on the
location of each particle using spheres filled with media.


Usage:

1) #include the glow.inc include file before specifying any settings.

2) Specify the settings (described below).
   Settings that you don't want to be the same for all particles can
   be specified inside the particle_element() macro if you want.

3) Call the glow_element() macro from inside the particle_element() macro, like this:
   
   #macro particle_element() glow_element() #end

Settings (all optional, see the default values which are declared below):

   glow_color       The color of the glow (also used to control the intensity)
   glow_colorturb   A vector specifying the variation of the colors of the glows
   glow_size        The size of the glows
   glow_samples     Amount of media samples used for the glows

*/

// Defaults:
   #declare glow_color     = <1.0,1.0,1.0>;
   #declare glow_colorturb = <0.0,0.0,0.0>;
   #declare glow_size      = 1.0;
   #declare glow_samples   = 1; // very low, but often enough.
   
   
   
   #macro glow_element ()
      
//    Create a unique color for this particle element
      #local ColorJitter =
      (<Hash2(p_id,1),Hash2(p_id,2),Hash2(p_id,3)>-<0.5,0.5,0.5>)*glow_colorturb;
      
      #local Color =
      (
         glow_color             // Color of the glow
         *(1+ColorJitter)       // Randomness to color
         *(1.001-p_state)       // Make glow disappear over time
      );
      
      #local ColorM = max(Color.x,max(Color.y,Color.z));
      
      #local Color = Color/2;
      
//    Create the glow
      sphere {
         0, 1 hollow no_shadow
         pigment {rgbf 1}
         finish {ambient 1 diffuse 0}
         interior {
            media {
               emission   0.5/glow_size
               intervals 1
               samples glow_samples,glow_samples
               density {
                  spherical
                  density_map {
                     [0.0, rgb 0       ]
                     [0.6, rgb Color   ]
                     [1.0, rgb 2*ColorM]
                  }
               }
            }
            media {
               absorption   0.5/glow_size
               intervals 1
               samples glow_samples,glow_samples
               density {
                  spherical
                  density_map {
                     [0.0, rgb 0           ]
                     [0.6, rgb ColorM-Color]
                     [1.0, rgb 0           ]
                  }
               }
            }
         }
         scale glow_size
         translate p_location
      }
   #end
   