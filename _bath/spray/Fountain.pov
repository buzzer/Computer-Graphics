// LIQID SPRAY: FOUNTAIN ANIMATION
// *******************************
// This animation shows how the particle_stretch option can be used
// to give the effect of motion, and how the nozzle_angle option can
// be used for different effects.

// CAMERA AND LIGHTS
   camera {location <5, 0, -40> look_at <0, 4, 0> angle 40}
   light_source {<10, 0, -100> rgb 1}

// FOUNTAIN BASE
   #declare FountainMarble = texture {
      pigment {marble
         color_map {[.7 rgb 1] [1 rgb <.9, .8, .85>]}
         turbulence .8 lambda 4 scale 3}
      finish {phong .3 phong_size 5}}

   union {
      cone {<0, -5, 0>, 1, <0, 0, 0>, .5}
      torus {.5, .3}
      sphere {<0, 2, 0>, 9
         clipped_by {box {<-9, -8, -9>, <9, -2, 9>}}
         scale <1.5, 1, 1.5>
         texture {FountainMarble
            normal {radial 3 frequency 21 scallop_wave}}}
      torus {12, .5 translate <0, -2, 0>
         texture {FountainMarble
            normal {radial .6 frequency 75 scallop_wave}}}
      texture {FountainMarble}}

// SPRAY OPTIONS
   #declare spray_loop = true;
   #declare particle_dist = 0;
   #declare particle_count = 200;
   #declare particle_size = .5;
   #declare evaporate = .4;
   #declare nozzle_spin = 33;
   #declare particle_stretch = 3;
   #declare spray_turb = .1;
   #declare color_turb = 10;
   #declare spray_color_map = color_map {
      [.5 rgb <.6, .7, .9>]
      [.8 rgb <.1, .2, .5>]
      [1 rgb <.3, .6, .9>]}

// FIRST SPRAY
   #declare particle_life = 1.8;
   #declare spray_strength = 11;
   #declare nozzle_angle = 80;
   #include "Spray.inc"

// SECOND SPRAY
   #declare particle_life = 2.5;
   #declare spray_strength = 16;
   #declare nozzle_angle = 20;
   #include "Spray.inc"
