// POV-Ray 3.5 Scene Description File
// FAST SKY
// Copyright March 2002 Rune S. Johansen - http://rsj.mobilixnet.dk
// 
// This scene file contains a fast rendering sky with shaded clouds using just four planes.
   
// First the basic scene elements...

camera {
   spherical
   location <0, 10, -10>
//   angle 120 120*3/4
   angle 60
   look_at  <0,10,0>
//   translate 10*y
}

light_source {<2,2,0>*1000000, color 3}

plane {y, 0 pigment {checker color rgb 0.9, color rgb 1.0}}


// And here the fast Sky...

#declare Clouds =
union {
   plane {
      y, 260
      texture {
         finish {ambient 0 diffuse 0.7}
         pigment {
            bozo turbulence 1.00 translate 200*y
            color_map {
               [0.5, rgb 1 transmit 1.0]
               [1.0, rgb 1 transmit 0.6]
            }
            scale 0.125
         }
         scale 1500
      }
   }
   plane {y, 200}
   plane {y, 220}
   plane {y, 240}
   texture {
      finish {ambient 0 diffuse 0.7}
      pigment {
         bozo turbulence 0.35 translate 300*y
         color_map {
            [0.5, rgb 1 transmit 1.0]
            [0.8, rgb 1 transmit 0.5]
         }
         scale 10 warp {turbulence 0.7} scale 1/10
         scale 0.125
      }
      scale 2500
   }
   texture {
      finish {ambient 0 diffuse 0.5}
      pigment {
         bozo turbulence 0.35 translate 400*y
         color_map {
            [0.5, rgb 1 transmit 1.0]
            [0.8, rgb 1 transmit 0.4]
         }
         scale 10 warp {turbulence 0.7} scale 1/10
         scale 0.125
      }
      scale 2500
   }
   hollow double_illuminate
   scale 1/200
}

object {Clouds scale 300} // distance above ground (y=0) to lowest parts of clouds

background {
   color <0.25,0.35,0.80> // color at horizon
}

fog {
   color <0.70,0.80,1.00> // color at top of sky
   fog_type 2
   distance 300
   fog_offset 0
   fog_alt    60
}