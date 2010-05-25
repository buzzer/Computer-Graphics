// Rune's Particle System
// Explode
// Particle Element Include File
/*   
The explode particle element include file create particles of fire and smoke,
not using media, but textured spheres.


Usage:

1) #include the expl.inc include file before specifying any settings.

2) Specify the settings (described below).
   Settings that you don't want to be the same for all particles can
   be specified inside the particle_element() macro if you want.

3) Call the expl_element() macro from inside the particle_element() macro, like this:
   
   #macro particle_element() expl_element() #end

Required setting:

   camera_location         The location of the camera

Settings (all optional, see the default values which are declared below):

   light_source_location   The location of the one light_source that may cast a shadow
   
   exp_size         The size of the fire/smoke elements
   exp_opacity      How solid the fire/smoke element is
   exp_emission     How much the fire element glows
   exp_smokeshade   The shade of the smoke - 0.0 is black, 1.0 is more like white
   exp_smokeglow    How much the smoke is glowing due to the illumination from the fire
   exp_smokestart   At which point in the particle's life there will appear smoke
   exp_fireend      At which point in the particle's life the fire will disappear (must be >= exp_smokestart)
   exp_ambient      The ambient lighting of the smoke
   exp_test         Set it to true to have the fire and smoke replaced by spheres with grid lines.

Note: Due to the trickery of the rendering method used,
      you can only use one light_source that casts a shadow.
      The other light_sources, if any, must be shadowless.

*/

// Defaults:
   #declare exp_size       = 1.0;
   #declare exp_opacity    = 1.0;
   #declare exp_emission   = 1.0;
   #declare exp_smokeshade = 0.5;
   #declare exp_smokeglow  = 1.0;
   #declare exp_smokestart = 0.1;
   #declare exp_fireend    = 0.2;
   #declare exp_ambient    = 0.1;
   #declare exp_test       = false;
// No default for camera_location, as it should always be specified.
// No default for light_source_location, as none is used per default.
   
   
   
   // From the standard math.inc include file (copied here for faster performance):
   // Returns a vector perpendicular to V
   // Author: Tor Olav Kristensen
   #macro VPerp_To_Vector(v0)
      #if (vlength(v0) = 0)
         #local vN = <0, 0, 0>;
      #else
         #local Dm = min(abs(v0.x), abs(v0.y), abs(v0.z));
         #if (abs(v0.z) = Dm)
            #local vN = vnormalize(vcross(v0, z));
         #else
            #if (abs(v0.y) = Dm)
               #local vN = vnormalize(vcross(v0, y));
            #else
               #local vN = vnormalize(vcross(v0, x));
            #end
         #end
      #end
      vN
   #end
   
   #macro exp_element ()
      #local Scale = exp_size*pow(p_state,0.3);
      #if (exp_fireend=0)
         #local FireLife = 1;
      #else
         #local FireLife = min(1,p_state/exp_fireend);
      #end
      #if (exp_test)
         union {
            sphere {
               0, Scale
               pigment {rgb <1-0.5*FireLife,0.5,0.5*FireLife>}
               finish {ambient 0.5 diffuse 0.5}
            }
            #local C = 0.5;
            #local Cm = 16;
            #while (C<Cm)
               #local V = C/Cm;
               torus {Scale*sin(V*pi), Scale*0.01 translate cos(V*pi)*y*Scale}
               torus {Scale*1,         Scale*0.01 rotate 90*x+360*V*y}
               #local C = C+1;
            #end
            pigment {rgb <1-0.5*FireLife,0.5,0.5*FireLife>}
            finish {ambient 1 diffuse 0}
            translate p_location
         }
      #else
         sphere {
            0, 1 no_shadow hollow
            pigment {
               cylindrical scale 0.7
               #local A = vnormalize(p_location-camera_location);
               #local B = VPerp_To_Vector(A);
               #local C = vcross(A, B);
               matrix < B.x, B.y, B.z, A.x, A.y, A.z, C.x, C.y, C.z, 0, 0, 0>
               
               scale 6
               translate +z*(p_random*100+FireLife)
               warp {turbulence 2-1.0*FireLife octaves 2}
               translate -z*(p_random*100+FireLife)
               scale 1/6
               
               scale 2
               translate +z*(p_random*100+FireLife)
               warp {turbulence 1.5 octaves 2}
               translate -z*(p_random*100+FireLife)
               scale 1/2
               
               translate -0.8*A
               
               color_map {
                  #declare C = 0;
                  #while (C<=100)
                     #local V = C/100;
                     #declare SmokeColor = (0.1+pow(0.9*V,0.5))*(exp_smokeshade+exp_smokeglow-exp_smokeglow*FireLife);
                     
                     #declare VF = mod(V*5/5*4,2); #declare VF = max(0, (VF<1?VF:2-VF)/2+V/2 -0.3*FireLife );
                     #declare FireColor = <0.3+0.7*pow(VF,0.3),0.1+0.8*pow(VF,1.0),0.0+0.4*pow(VF,2)> *(1+exp_emission*VF);
                     
                     #if (exp_fireend=0)
                        #declare VS = 0;
                     #else
                        #declare VS = exp_smokestart/(exp_fireend-exp_smokestart)*exp_fireend;
                     #end
                     #declare VT = min(1,max(0,VS+3*V-(VS+3)*FireLife));
                     #declare Color = (1-VT)*SmokeColor + VT*FireColor;
                     
                     #declare Transmit = 1-pow(V,(0.3+0.7*pow(p_state,2)))*(1-p_state) /(1+exp_emission*VF*VT)*exp_opacity;
                     
                     [V, rgb Color transmit Transmit]
                     #local C = C+1;
                  #end
               }
            }
            finish {
               ambient 1*(1-FireLife)+exp_ambient*FireLife
               diffuse 0+(1-exp_ambient)*FireLife
               brilliance 0
            }
            scale Scale
            translate p_location
            double_illuminate
         }
         #ifdef (light_source_location)
            sphere {
               0, 1 no_image no_reflection hollow
               pigment {
                  cylindrical scale 0.7
                  #local A = vnormalize(p_location-light_source_location);
                  #local B = VPerp_To_Vector(A);
                  #local C = vcross(A, B);
                  matrix < B.x, B.y, B.z, A.x, A.y, A.z, C.x, C.y, C.z, 0, 0, 0>
                  
                  scale 6
                  translate +z*(p_random*100+FireLife)
                  warp {turbulence 2-1.0*FireLife octaves 2}
                  translate -z*(p_random*100+FireLife)
                  scale 1/6
                  
                  scale 2
                  translate +z*(p_random*100+FireLife)
                  warp {turbulence 1.5 octaves 2}
                  translate -z*(p_random*100+FireLife)
                  scale 1/2
                  
                  translate -0.8*A
                  
                  color_map {
                     #declare C = 0;
                     #while (C<=100)
                        #local V = C/100;
                        #declare Transmit = 1-pow(V,(0.3+0.7*pow(p_state,2)))*(1-p_state);
                        [V, transmit Transmit]
                        #local C = C+1;
                     #end
                  }
               }
               finish {ambient 1 diffuse 0}
               scale exp_size*pow(p_state,0.3)
               translate p_location
            }
         #end
      #end
   #end
   