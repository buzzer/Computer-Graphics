// LIQID SPRAY: RAINBOW NOZZLE
// ***************************
// This animation shows how the nozzle_spin option can be used to create
// spinning spray objects, and how the spray_color_map can be used in
// animations.
// NOTE: This animation should be rendered with at least 100 frames to
//       properly see the spinning effect.

// CAMERA AND LIGHTS
   camera {location <0, 0, -25> look_at <0, 0, 0> angle 40}
   light_source {<0, 10, -50> rgb 1.5}

// BACKGROUND
   plane {z, 10
      pigment {checker rgb 0, rgb 1 scale 3}
      finish {ambient .4 diffuse .3}}

// SPRAY OPTIONS
   #declare spray_location = <-10, -3, 0>;
   #declare spray_direction = <5, 5, 0>;
   #declare spray_strength = 15;

   #declare spray_start_time = .4;
   #declare spray_stop = .8;
   #declare time_scale = 10;

   #declare particle_count = 100;
   #declare particle_life = 2;
   #declare particle_stretch = 2;
   #declare particle_dist = .6;

   #declare nozzle_angle = 30;
   #declare nozzle_spin = 2;

   #declare spray_color_map = color_map {
      [0 rgb <1, 0, 0>]
      [.2 rgb <1, 1, 0>]
      [.4 rgb <0, .7, .3>]
      [.6 rgb <0, .6, 1>]
      [.8 rgb <.5, 0, .5>]
      [1 rgb <1, 0, 0>]}

   #declare spray_turb = .1;
   #declare angle_turb = 3;
   #declare spin_turb = 3;

// CREATE SPRAY OBJECT
   #include "Spray.inc"
