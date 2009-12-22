#default {
  finish { ambient 0.4 }
}

camera
{
  up <0, 1, 0>
  right <1, 0, 0>
  location <-10,-4,20>
  look_at <1.3,0,0>
  angle 15
}

#include "colors.inc"


#declare whitepaint = texture { pigment { color rgb <1,1,1> } finish { diffuse 0.8 specular 0.2 } }
#declare redpaint = texture { pigment { color rgb <1,0,0> } finish { diffuse 0.8 specular 0.2 } }
#declare greenpaint = texture { pigment { color rgb <0 1 0> } finish { specular
0 reflection 0 diffuse 0.7 } }
#declare offwhitepaint = texture { pigment { color rgb <0.9 0.9 0.8> } finish { specular 0 reflection 0 diffuse 0.7 } }
#declare blackrubber = texture { pigment { color rgb <0.2 0.2 0.2> } finish { specular 0 reflection 0 diffuse 0.7 } }
#declare blackplastic = texture { pigment { color rgb <0.2 0.2 0.2> } finish { specular 0.4 reflection 0 diffuse 0.5 } }

background { color Black }

light_source { <10,10,10> color rgb <0.7,0.7,0.7> }
light_source { <-5,10,10> color rgb <0.4,0.4,0.4> }

//back wall
//box { <-15,-15,15> <15,15,15> texture { offwhitepaint } }
//x-y plane wall, if facing from -z
//box { <-15,-15,0> <15,15,1> texture { offwhitepaint } }
//x-y plane wall, if facing from +z
box { <-15,-15,0> <15,15,-1> texture { offwhitepaint } }
//x-z plane wall (horizontal)
//box { <-15,0,-15> <15,-1,15> texture { offwhitepaint } }

//opposite wall, for filling in reflection
box { <-45,-45,110> <45,45,111> texture { offwhitepaint } }
box { <-45,-45,0> <45,-46,111> texture { offwhitepaint } }
box { <45,-45,0> <46,45,111> texture { offwhitepaint } }

#declare AXIS_DIAM=0.01;
//x-axis
cylinder { <-15,0,0> <15,0,0> AXIS_DIAM texture { greenpaint } }
//y-axis
cylinder { <0,-15,0> <0,15,0> AXIS_DIAM texture { greenpaint } }
//z axis
cylinder { <0,0,-15> <0,0,15> AXIS_DIAM texture { greenpaint } }
text {
  ttf "cyrvetic.ttf" "Z" 0.1 0
  scale 0.3
  rotate 180*y
  translate <-0.3,0,6.5>
  texture { greenpaint }
}
text {
  ttf "cyrvetic.ttf" "X" 0.1 0
  scale 0.3
  translate <2.5,0.1,0.01>
  texture { greenpaint }
}
text {
  ttf "cyrvetic.ttf" "Y" 0.1 0
  scale 0.3
  translate <-0.25,2,0.01>
  texture { greenpaint }
}

#include "tub_filler.pov"

object { tub_filler }
