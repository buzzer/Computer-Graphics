// LIQID SPRAY: SPILLED PAINT SCENE
// ********************************
// This scene shows how the ground plane options can be used to make
// the spray object form puddles, and how the components_only option
// can be used to combine different blob objects.

// CAMERA AND LIGHTS
   camera {location <5, 15, -25> look_at <0, 1, 0> angle 30}
   light_source {<-5, 50, -30> rgb 1
      area_light 10, 10, 4, 4 adaptive 1}

// GROUND PLANE OBJECT
   plane {y, 0
      texture {
         pigment {granite color_map {[0 rgb <.7, .5, .3>] [1 rgb <.9, .7, .4>]}}
         normal  {granite -.6}
         scale 3}
      texture {
         pigment {checker rgbt 1, rgbt <.5, .3, .1, .6>}
         finish {reflection .6}
         scale 4 rotate y * -30}}

// SPRAY OPTIONS
   #declare use_blob = true;
   #declare components_only = true;
   #declare spray_loop = true;
   #declare spray_turb = .3;
   #declare spin_turb = 4;
   #declare angle_turb = 2;
   #declare particle_count = 60;
   #declare particle_life = 2;
   #declare particle_dist = .3;
   #declare particle_size = 1.5;
   #declare particle_stretch = 1.25;
   #declare evaporate = .2;
   #declare nozzle_angle = 30;

   #declare ground_plane = true;
   #declare ground_reflection = 0;
   #declare ground_friction = 1;
   #declare puddle_scale = 2;
   #declare puddle_thickness = .6;

// CREATE SPRAY BLOB OBJECT
   blob {threshold .5
      #declare spray_location = <8, 4.5, 5>;
      #declare spray_direction = <-4, 0, -2>;
      #declare spray_strength = 8;
      #declare spray_color_map = color_map {[0 rgb <.8, .1, .3>]}
      #include "Spray.inc"

      #declare spray_seed = 10;
      #declare spray_location = <5, 5, 8>;
      #declare spray_direction = <-2, 0, -3>;
      #declare spray_strength = 8;
      #declare spray_color_map = color_map {[0 rgb <.8, .6, 0>]}
      #include "Spray.inc"

      #declare spray_seed = 20;
      #declare spray_location = <8, 3, -1>;
      #declare spray_direction = <-5, 0, 1>;
      #declare spray_strength = 8;
      #declare spray_color_map = color_map {[0 rgb <0, .6, .7>]}
      #include "Spray.inc"
   }
