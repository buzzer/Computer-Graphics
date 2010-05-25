// Rune's Particle System
// Water
// Particle Element Include File
/*
The water particle element include file creates drops of water
either as regular spheres or as blob elements.


Usage:

1) #include the water.inc include file before specifying any settings.

2) Specify the settings (described below).
   Settings that you don't want to be the same for all particles can
   be specified inside the particle_element() macro if you want.

3) Call the water_element() macro from inside the particle_element() macro, like this:
   
   #macro particle_element() water_element() #end

Settings (all optional, see the default values which are declared below):

   water_blob          Creates blob elements if set to yes, else creates spheres
   water_size          The size of the water drop element
   water_sizeturb      How much the water drops vary in size (from 0 to 1)
   water_stretch       The amount of pseudo motion blur (scales the drops in the direction of movement)
   water_falloff       How quickly the drops decrease in size
   water_strength      The strengt of the blob elements
   water_texture       The texture of the water drop element (optional)

*/
   
// Defaults:
   #declare water_blob     = no;
   #declare water_size     = 1.0;
   #declare water_sizeturb = 0.0;
   #declare water_stretch  = 0.0;
   #declare water_falloff  = 0.0;
   #declare water_strength = 2.0;
// There is no default for water_texture, as it will not be used per default.
   
   
   
   #macro water_element ()
      
      #local _scale = (
         water_size
         * (1+(p_random-0.5)*2*water_sizeturb)
         * (0.001+0.999*pow(1-p_state,water_falloff))
      );
      
      sphere {
         0, 1 #if (water_blob) water_strength #end
         #ifdef(water_texture)
            texture {water_texture}
         #end
         scale _scale + vlength(p_direction)*water_stretch*z
         rotate p_rotate
         translate p_location
      }
      
   #end
   