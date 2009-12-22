// LIQID SPRAY: WATERFALL ANIMATION
// ********************************
// This animation shows how the nozzle_width option can be used to
// create waterfall spray objects, and how the particle_dist and
// particle_sep options can be used to separate the small particles
// from the large particles.

// CAMERA AND LIGHTS
   camera {location <-5, -10, -15> look_at <0, 3, 0> angle 50}
   light_source {<10, 30, -40> rgb 1}

// DAM WALL
   union {
      box {<-20, -10, 0>, <20, 5, 2>}
      box {<-.4, -10, -.4>, <.4, 5.4, 2> translate x * -3.5}
      box {<-.4, -10, -.4>, <.4, 5.4, 2> translate x *  3.5}
      box {<-.4, -10, -.4>, <.4, 5.4, 2> translate x *  10.5}
      pigment {bozo color_map {[0 rgb <.5, .475, .45>] [1 rgb <.7, .7, .65>]}
         scale <4, .5, 1>}
      normal {bumps 1 scale .2}
      finish {ambient .4 diffuse .4}}

// BACKGROUND
   sky_sphere {pigment {wrinkles
      color_map {[.4 rgb <0, .4, .8>] [.9 rgb <.8, .8, .8>]}
      scale <.3, .1, .3>
      translate x * 45}}

// SPRAY OPTIONS
   #declare spray_location = <0, 6, 1.5>;
   #declare spray_direction = -z;
   #declare spray_strength = 2;
   #declare spray_angle = 0;
   #declare spray_loop = true;

   #declare particle_life = 1.5;
   #declare particle_count = 300;
   #declare particle_size = 2;
   #declare particle_stretch = 2;
   #declare particle_dist = 1;
   #declare particle_sep = 1.5;

   #declare nozzle_width = 4;
   #declare nozzle_angle = 0;

   #declare spray_turb = .1;
   #declare spin_turb = 10;

   #declare use_blob = true;
   #declare spray_texture = texture {
      pigment {rgbt <.9, .9, 1, .6>}
      finish {phong .2 phong_size 1}}

// CREATE SPRAY OBJECT
   #include "Spray.inc"
