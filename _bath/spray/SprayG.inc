/*************************************************************************
         LIQUID SPRAY INCLUDE FILE FOR PERSISTENCE OF VISION 3.x
**************************************************************************

Created by Chris Colefax, 23 May 1997
Updated 13 August 1998: updated for POV-Ray 3.1

See "Spray.htm" for more information.
NOTE: This file should not be included directly in a POV-Ray scene!

*************************************************************************/

// ROTATE VECTORS IF SKY IS NOT +Y
// *******************************
   #if (_SP_sky.y != 1)
      #declare _SP_idisp = vrotate(vrotate(_SP_idisp, -y * _SP_wroty), -x * _SP_wrotx);
      #declare _SP_ivel  = vrotate(vrotate(_SP_ivel,  -y * _SP_wroty), -x * _SP_wrotx);
      #declare _SP_wind  = vrotate(vrotate(_SP_wind,  -y * _SP_wroty), -x * _SP_wrotx);
   #end

// SHIFT IF GROUND DISTANCE IS NOT 0
// *********************************
   #if (ground_dist != 0) #declare _SP_idisp = _SP_idisp - y * ground_dist; #end

// CALCULATE ACCELERATION, CURRENT VELOCITY, DISPLACEMENT
// ******************************************************
   #if (vlength(_SP_wind) > 0) #declare _SP_accel = _SP_accel + vrotate(_SP_wind * _SP_pscale.z / _SP_psize.z, (<_SP_rand1, _SP_rand2, _SP_rand3> - .5) * 360 * _SP_wturb); #end
   #declare _SP_cclk  = _SP_time;
   #declare _SP_iclk  = 0; #declare _SP_bounces = 0;
   #declare _SP_cvel  = _SP_ivel + (_SP_accel * _SP_cclk);
   #declare _SP_cdisp = _SP_idisp + (_SP_ivel * _SP_cclk) + (.5 * _SP_accel * _SP_cclk * _SP_cclk);
   #while (_SP_cdisp.y < 0)

// CALCULATE TIME OF INTERSECTION WITH GROUND PLANE
// ************************************************
   #if (_SP_accel.y = 0) #declare _SP_iclk = _SP_idisp.y / -_SP_ivel.y;
      #else #declare _SP_iclk = (-_SP_ivel.y - sqrt (_SP_ivel.y * _SP_ivel.y - (2 * _SP_accel.y * _SP_idisp.y))) / _SP_accel.y; #end

   #declare _SP_idisp = _SP_idisp + (_SP_ivel * _SP_iclk) + (.5 * _SP_accel * _SP_iclk * _SP_iclk);
   #declare _SP_ivel  = (_SP_ivel + (_SP_grav * _SP_iclk)) * <1, -ground_reflection, 1>;
   #declare _SP_cclk = _SP_cclk - _SP_iclk;

// CHECK IF PARTICLE HAS STOPPED MOVING
// ************************************
   #if (ground_reflection = 0 | _SP_bounces >= max_bounces)
      #if (ground_friction = 0) #declare _SP_cdisp = _SP_idisp;
         #else #if (ground_friction = 1) #declare _SP_cdisp = _SP_idisp + (_SP_ivel * _SP_cclk);
         #else #declare _SP_cdisp = _SP_idisp + (_SP_ivel * ((pow(ground_friction, _SP_cclk) / log(ground_friction)) - (1 / log(ground_friction)))); #end #end
      #declare _SP_cdisp = _SP_cdisp * <1, 0, 1>;
      #declare _SP_cvel  = _SP_ivel;
   #else
      #declare _SP_cvel  = _SP_ivel + (_SP_accel * _SP_cclk);
      #declare _SP_cdisp = _SP_idisp + (_SP_ivel * _SP_cclk) + (.5 * _SP_accel * _SP_cclk * _SP_cclk);
   #end #declare _SP_bounces = _SP_bounces + 1; #end

// CREATE PARTICLE
// ***************
   #if (_SP_bounces > max_bounces & puddle_thickness <= 0)
      sphere {x * _SP_count, 0 #if (use_blob != false) , 0 #end }
   #else
      #declare _SP_protatex = vlength (_SP_cvel * <1,0,1>); #if (_SP_protatex != 0 | _SP_cvel.y != 0)
         #declare _SP_protatex = -degrees (atan2 (_SP_cvel.y, _SP_protatex)); #end
      #declare _SP_protatey = 0; #if (_SP_cvel.x != 0 | _SP_cvel.z != 0) 
         #declare _SP_protatey = degrees (atan2 (_SP_cvel.x, _SP_cvel.z)); #end
      #if (evaporate != 0) #declare _SP_psize = _SP_psize * (pow(1 - (_SP_time / _SP_tscale / _SP_plife), evaporate) + .01); #end

      sphere {<0, 0, 0>, 1 #if (use_blob != false) , 1 #end
      #if (use_color_map = false)
         #if (components_only != false & use_blob != false)
            texture {spray_texture} #end
      #else texture {spray_texture
         pigment {gradient z color_map {spray_color_map} triangle_wave
            translate (color_map_triangle = false ? .5 : 1) * (spray_loop = false ? _SP_pclock * color_map_frequency / _SP_duration : mod(_SP_pclock * color_map_frequency, _SP_plife) / _SP_plife) + ((_SP_rand3 - .5) * _SP_cturb)
            scale _SP_psize * 1000}} #end
         scale _SP_psize rotate <_SP_protatex, _SP_protatey, 0> translate y * _SP_cdisp
      #declare _SP_pdist = _SP_cdisp.y / ((_SP_psize.x + _SP_psize.y + _SP_psize.z) / 3);
      #if (_SP_pdist < 1)
         #declare _SP_pthick = (_SP_pdist < puddle_thickness ? puddle_thickness : _SP_pdist);
         scale ((y * _SP_pthick) + (<1, 0, 1> / sqrt(_SP_pthick))) * (1 + ((puddle_scale - 1) * (1 - _SP_pthick)))
      #end
      translate <1, 0, 1> * _SP_cdisp

// UNDO GROUND DISTANCE SHIFT AND SKY VECTOR ROTATION
// **************************************************
   #if (ground_dist != 0) translate y * ground_dist        #end
   #if (_SP_sky.y != 1)   rotate <_SP_wrotx, _SP_wroty, 0> #end
   }

   #end
