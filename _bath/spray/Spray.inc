/*************************************************************************
         LIQUID SPRAY INCLUDE FILE FOR PERSISTENCE OF VISION 3.x
**************************************************************************

Created by Chris Colefax, 23 May 1997
Updated 13 August 1998: updated for POV-Ray 3.1

See "Spray.htm" for more information.

*************************************************************************/

// CHECK VERSION
// *************
   #declare _SP_tempver = version; #version 3.0;

// DETERMINE REQUIRED PARAMETERS
// *****************************
   #ifndef (spray_start)    #declare spray_start = 0;     #end
   #ifndef (spray_stop)     #declare spray_stop  = 1;     #end
   #ifndef (spray_clock)    #declare spray_clock = clock; #end
   #ifndef (spray_loop)     #declare spray_loop  = false; #end
   #ifndef (flow_rate)      #declare flow_rate   = 1;     #end
   #ifndef (particle_life)  #declare _SP_plife   = 1;     #else #declare _SP_plife = abs(particle_life); #end
   #ifndef (time_scale)     #declare _SP_tscale  = 1;     #else #declare _SP_tscale = abs(time_scale);   #end
   #if     (_SP_tscale = 0) #declare _SP_tscale  = 1;     #end

   #declare _SP_plife = _SP_plife / _SP_tscale;
   #if     (spray_start >= spray_stop) #warning "The spray_start must be less than the spray_stop!  No spray created.\n" #else
   #if     (flow_rate > 0 & (spray_loop != false | (spray_clock > spray_start & spray_clock < spray_stop + _SP_plife)))

// DETERMINE TIME PARAMETERS
// *************************
   #ifndef (spray_start_time) #declare _SP_startd = 0; #else #declare _SP_startd = spray_start_time; #end
   #ifndef (spray_stop_time)  #declare _SP_stopd  = 0; #else #declare _SP_stopd  = spray_stop_time;  #end
   #declare _SP_duration = spray_stop - spray_start;
   #if (_SP_startd + _SP_stopd > _SP_duration) #warning "The spray_start_time and spray_stop_time are too large!  The times have been decreased.\n" #declare _SP_startd = .5; #declare _SP_stopd = .5; #end

// DETERMINE SPRAY PARAMETERS
// **************************
   #ifndef (spray_location)  #declare _SP_loc       = <0, 0, 0>;                            #else #declare _SP_loc  = spray_location * <1, 1, 1>;              #end
   #ifndef (spray_direction) #declare _SP_dir       = <0, 1, 0>;                            #else #declare _SP_dir  = vnormalize(spray_direction * <1, 1, 1>); #end
   #ifdef  (spray_strength)  #declare _SP_dir       = _SP_dir * spray_strength * flow_rate; #end
   #ifndef (wind)            #declare _SP_wind      = <0, 0, 0>;                            #else #declare _SP_wind = wind * <1, 1, 1>;                        #end
   #ifndef (spray_sky)       #declare _SP_sky       = <0, 1, 0>;                            #else #declare _SP_sky  = vnormalize(spray_sky * <1, 1, 1>);       #end
   #ifndef (spray_gravity)   #declare spray_gravity = 9.8;                                  #end
   #declare _SP_grav = -_SP_sky * abs(spray_gravity);

// CHECK THAT SKY AND DIRECTION ARE DIFFERENT
// ******************************************
   #if (_SP_dir.x != 0 & _SP_sky.x != 0) #declare _SP_cvec = _SP_dir * (_SP_sky.x / _SP_dir.x);
      #else #if (_SP_dir.y != 0 & _SP_sky.y != 0) #declare _SP_cvec = _SP_dir * (_SP_sky.y / _SP_dir.y);
         #else #if (_SP_dir.z != 0 & _SP_sky.z != 0) #declare _SP_cvec = _SP_dir * (_SP_sky.z / _SP_dir.z);
            #else #declare _SP_cvec = _SP_dir; #end #end #end
   #if (_SP_sky.x = _SP_cvec.x & _SP_sky.y = _SP_cvec.y & _SP_sky.z = _SP_cvec.z)
      #declare _SP_dir = vrotate(_SP_dir, <1, 1, 1>); #end
   #declare _SP_rotaxis = vnormalize(vcross(_SP_dir, _SP_sky));

// DETERMINE PARTICLE PARAMETERS
// *****************************
   #ifndef (particle_count)   #declare particle_count  = 100;                                               #end
   #ifndef (particle_size)    #declare _SP_pscale      = <1, 1, 1>;                                         #else #declare _SP_pscale = particle_size * <1, 1, 1> #end
   #ifdef  (particle_stretch) #declare _SP_pscale      = _SP_pscale * (z + (<1, 1, 0> / particle_stretch)); #end
   #ifndef (particle_dist)    #declare particle_dist   = 1;                                                 #end
   #ifndef (particle_sep)     #declare particle_sep    = 0;                                                 #end
   #ifndef (evaporate)        #declare evaporate       = 0;                                                 #end
   #ifndef (use_blob)         #declare use_blob        = false;                                             #end
   #ifndef (blob_threshold)   #declare blob_threshold  = .5;                                                #end
   #ifndef (components_only)  #declare components_only = false;                                             #end

// DETERMINE NOZZLE PARAMETERS
// ***************************
   #ifndef (nozzle_spin)  #declare nozzle_spin  = 1;  #end
   #ifndef (nozzle_angle) #declare nozzle_angle = 20; #end
   #ifndef (nozzle_width) #declare nozzle_width = 0;  #end
   #if (nozzle_width != 0) #declare _SP_nozvec = nozzle_width * _SP_rotaxis; #end

// DETERMINE GROUND PARAMETERS
// ***************************
   #ifndef (ground_plane) #declare ground_plane = false;
      #else #if (ground_plane != false)
         #ifndef (ground_dist) #declare ground_dist = 0; #end
         #if (vdot(_SP_loc, _SP_sky) - ground_dist <= 0) #warning "Spray_location is under ground plane!  Ground plane disabled.\n" #declare ground_plane = false; #end
         #ifndef (ground_reflection) #declare ground_reflection = .8; #else #declare ground_reflection = abs(ground_reflection); #end
         #ifndef (ground_friction)   #declare ground_friction   = .5; #else #declare ground_friction   = abs(ground_friction);   #end
         #ifndef (max_bounces)       #declare max_bounces       = 1;  #else #declare max_bounces       = abs(max_bounces);       #end
         #ifndef (puddle_thickness)  #declare puddle_thickness  = .3; #else #declare puddle_thickness  = abs(puddle_thickness);  #end
         #ifndef (puddle_scale)      #declare puddle_scale      = 1;  #end
         #if (_SP_sky.y != 1)
            #declare _SP_wrotx = vlength(_SP_sky * <1, 0, 1>); #if (_SP_wrotx != 0 | _SP_sky.y != 0)
               #declare _SP_wrotx = degrees(atan2(_SP_wrotx, _SP_sky.y)); #end
            #declare _SP_wroty = 0; #if (_SP_sky.x != 0 | _SP_sky.z != 0) 
               #declare _SP_wroty = degrees(atan2(_SP_sky.x, _SP_sky.z)); #end
            #declare _SP_grav  = -y * abs(spray_gravity);
   #end #end #end

// DETERMINE TEXTURE PARAMETERS
// ****************************
   #ifndef (spray_texture) #declare spray_texture = texture {pigment {rgb <.6, .7, .8>} finish {phong .3 phong_size 2}} #end
   #ifndef (use_color_map) #ifdef (spray_color_map) #declare use_color_map = true; #else #declare use_color_map = false; #end #end
   #if (use_color_map != false)
      #ifndef (spray_color_map)
         #warning "You must specify a color_map to texture the spray!\n" #declare use_color_map = false;
      #else
         #ifndef (color_map_triangle)   #declare color_map_triangle  = spray_loop; #end
         #ifndef (color_map_frequency)  #declare color_map_frequency = 1;          #end
         #if (color_map_frequency <= 0) #declare color_map_frequency = 1;          #end
   #end #end

// DETERMINE TURBULENCE (RANDOMNESS) PARAMETERS
// ********************************************
   #ifndef (spray_turb)  #declare spray_turb = 0;                #end
   #ifdef  (spray_seed)  #declare _SP_rand   = seed(spray_seed); #else #declare _SP_rand  = seed(0);                  #end
   #ifndef (scale_turb)  #declare _SP_sturb  = spray_turb;       #else #declare _SP_sturb = scale_turb * spray_turb;  #end
   #ifndef (angle_turb)  #declare _SP_aturb  = spray_turb;       #else #declare _SP_aturb = angle_turb * spray_turb;  #end
   #ifndef (spin_turb)   #declare _SP_nturb  = spray_turb;       #else #declare _SP_nturb = spin_turb * spray_turb;   #end
   #ifndef (vel_turb)    #declare _SP_vturb  = spray_turb;       #else #declare _SP_vturb = vel_turb * spray_turb;    #end
   #ifndef (color_turb)  #declare _SP_cturb  = spray_turb;       #else #declare _SP_cturb = color_turb * spray_turb;  #end
   #ifndef (wind_turb)   #declare _SP_wturb  = spray_turb;       #else #declare _SP_wturb = wind_turb * spray_turb;   #end

// CREATE LIQUID SPRAY
// *******************
   #if (use_blob = false) union { #else #if (components_only = false) blob {threshold blob_threshold #end #end
   #if (spray_loop = false) #declare _SP_clock = spray_clock - spray_start; #else #declare _SP_clock = spray_clock * _SP_plife * _SP_tscale; #end
   #declare _SP_pcount = particle_count * flow_rate;
   #declare _SP_count = 0; #while (_SP_count < _SP_pcount)

// CREATE SPRAY PARTICLE
// *********************
   #declare _SP_rand1 = rand(_SP_rand); #declare _SP_rand2 = rand(_SP_rand); #declare _SP_rand3 = rand(_SP_rand);
   #declare _SP_pclock = _SP_clock - mod(_SP_clock, _SP_plife) + (_SP_plife * _SP_count / _SP_pcount);
   #if (_SP_pclock > _SP_clock) #declare _SP_pclock = _SP_pclock - _SP_plife; #end
   #if (spray_loop != false | (_SP_pclock > 0 & _SP_pclock < _SP_duration))

// CALCULATE PARTICLE PARAMETERS
// *****************************
   #declare _SP_psize  = _SP_pscale * (1 + (<_SP_rand1, _SP_rand2, _SP_rand3> - .5) * 2 * _SP_sturb);
   #if (particle_dist != 0) #declare _SP_psize  = _SP_psize * (.1 + pow(_SP_rand2, particle_dist) * .9); #end
   #if (particle_sep   = 0)
      #declare _SP_pangle = nozzle_angle; #declare _SP_vel = 1;
   #else
      #declare _SP_pangle = nozzle_angle + (1 - _SP_psize.z / _SP_pscale.z) * 30 * particle_sep;
      #declare _SP_vel    = 1 + (1 - _SP_psize.z / _SP_pscale.z) * particle_sep;
   #end

   #if (nozzle_width = 0) #declare _SP_idisp = _SP_loc; #else #declare _SP_idisp = _SP_loc + _SP_nozvec * (_SP_rand1 - .5); #end
   #declare _SP_time   = (_SP_clock - _SP_pclock) * _SP_tscale;
   #declare _SP_accel  = _SP_grav;

// CALCULATE INITIAL VELOCITY
// **************************
   #if (spray_loop = false) #switch (_SP_pclock)
      #range (0, _SP_startd) #declare _SP_vel = _SP_vel * pow(sin(pi * .5 * _SP_pclock / _SP_startd), .5); #break
      #range (_SP_duration - _SP_stopd, _SP_duration) #declare _SP_vel = _SP_vel * pow(sin(pi * .5 * - (_SP_pclock - _SP_duration) / _SP_stopd), .5); #break
      #end #end
   #declare _SP_ivel = vaxis_rotate(_SP_dir * _SP_vel * (1 + ((_SP_rand1 - .5) * .5 * _SP_vturb)), _SP_rotaxis, _SP_pangle * .5 * (1 - _SP_rand2 * _SP_aturb));
   #declare _SP_ivel = vaxis_rotate(_SP_ivel, _SP_dir, nozzle_spin * 360 * mod(_SP_pclock, _SP_plife) / _SP_plife + (1 + ((_SP_rand3 - .5) * _SP_nturb)) * 360);

// CREATE PARTICLE WITHOUT GROUND PLANE
// ************************************
   #if (ground_plane = false)
      #if (vlength(_SP_wind) > 0) #declare _SP_accel = _SP_accel + vrotate(_SP_wind * _SP_pscale.z / _SP_psize.z, (<_SP_rand1, _SP_rand2, _SP_rand3> - .5) * 360 * _SP_wturb); #end
      #declare _SP_cvel    = _SP_ivel + (_SP_accel * _SP_time);
      #declare _SP_cdisp   = _SP_idisp + (_SP_ivel * _SP_time) + (.5 * _SP_accel * _SP_time * _SP_time);
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
         scale _SP_psize rotate <_SP_protatex, _SP_protatey, 0> translate _SP_cdisp}

// CREATE PARTICLE WITH GROUND PLANE
// *********************************
   #else #include "SprayG.inc" #end

// LOOP THROUGH PARTICLES
// **********************
   #else sphere {x * _SP_count, 0 #if (use_blob != false) , 0 #end } #end
   #declare _SP_count = _SP_count + 1; #end
   #if (use_blob != false & components_only != false) #else texture {spray_texture}} #end

   #end #end
   #version _SP_tempver;
