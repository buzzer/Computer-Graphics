// Rune's Particle System
// Glitter
// Particle Element Include File
/*
The glitter particle element include file creates simple lens effects
at the location of each particle, using a trick with textured discs.


Usage:

1) #include the glitter.inc include file before specifying any settings.

2) Specify the settings (described below).
   Settings that you don't want to be the same for all particles can
   be specified inside the particle_element() macro if you want.

3) Call the glitter_element() macro from inside the particle_element() macro, like this:
   
   #macro particle_element() glitter_element() #end

Required setting:

   camera_location     The location of the camera

Settings (all optional, see the default values which are declared below):

   camera_sky          The sky vector of the camera
   
   glitter_color       The color of the glitter lens effects
   glitter_whiteness   How white the centers of the lens effects are
   glitter_colorturb   A vector specifying the variation of the colors of the lens effects
   glitter_size        The size of the glitter lens effects
   
   glitter_blockobj    A union of all Objects that should block for the lens effects

*/
   
// Defaults:
   #declare glitter_color     = <1.0,1.0,1.0>;
   #declare glitter_whiteness = 0.5;
   #declare glitter_colorturb = <0.0,0.0,0.0>;
   #declare glitter_size      = 1.0;
// No default for camera_location, as it should always be specified.
// No default for glitter_blockobj, as none is used per default.
   
   #ifndef (camera_sky) #declare camera_sky = y; #end
   
   
   
   #declare glitter_distinit = 0.01;
   #declare glitter_distcur  = glitter_distinit;
   #declare glitter_distsep  = 0.001;
   
   #macro glitter_disc (Scale,Rotate,B)
      disc {
         0, z, 1
         pigment {
            onion scallop_wave scale 2
            color_map {
               [0,rgb 1.5*ColorC transmit (1-B)+B*ColorT]
               [1,rgb 1.5*ColorE transmit 1.0           ]
            }
         }
         finish {ambient 1 diffuse 0}
         scale Scale*glitter_size rotate Rotate*z
         #local P = p_location-camera_location;
         #local Z = vnormalize(P);
         #local Y = vnormalize(vcross(vcross(Z, camera_sky), Z));
         #local X = vcross(Y,Z);
         matrix <X.x,X.y,X.z,Y.x,Y.y,Y.z,Z.x,Z.y,Z.z,P.x,P.y,P.z>
         scale 1/vlength(P)*glitter_distcur translate camera_location
         #declare glitter_distcur = glitter_distcur+glitter_distsep;
      }
   #end
   
   #macro glitter_element ()
      
      #local N = <0,0,0>;
      #local P = trace(glitter_blockobj,camera_location,p_location-camera_location,N);
      #if ( vlength(N)>0 & vlength(P-camera_location)>vlength(p_location-camera_location) )
         
//       Create a unique color for this particle element
         #local ColorJitter =
         (<Hash2(p_id,1),Hash2(p_id,2),Hash2(p_id,3)>-<0.5,0.5,0.5>)*glitter_colorturb;
         
         #local Color =
         (
            glitter_color          // Color of the glow
            *(1+ColorJitter)       // Randomness to color
            *(1.001-p_state)       // Make glow disappear over time
         );
         #local ColorM = max(Color.x,max(Color.y,Color.z));
         #local ColorE = Color/ColorM;
         #local ColorM = min(1,ColorM);
         #local ColorT = 1-ColorM;
         #local ColorC = ColorE*(1-glitter_whiteness)+<1,1,1>*glitter_whiteness;
         
         glitter_disc (<1.3,1.3,1>,000,0.7)
         glitter_disc (<0.2,4.0,1>,015,0.5)
         glitter_disc (<0.2,4.0,1>,135,0.5)
         glitter_disc (<0.2,4.0,1>,255,0.5)
         
      #end
      
   #end
   