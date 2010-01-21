#include "colors.inc"
#include "textures.inc"

camera {
	perspective 
	location < 0.0, 2, -10>
	angle 60
	look_at < 0.0, 2.0, 0.0>
//	rotate y*90
}
light_source {
	< 100, 100, -100>
	rgb <1.000000, 1.000000, 1.000000>
	shadowless
}
background {	rgb <1.000000, 0.999908, 1.000000>}
//plane {	<0.0, 1, 0.0>, -2 pigment {Gray} }
//box {
//	< -1, -1, 1>, < 3, 6, 0>
//	pigment{Blue}
//}
union{
box {	< 0, 0, 0>, < 2.5, 5, -0.2>
//	texture{DMFWood6}
//	pigment{DMFLightOak}
//	pigment{Pine_Wood}	
//	pigment{Cherry_Wood}
//	pigment{Dark_Wood}
//	pigment{Tan_Wood}
//	pigment{DMFWood1}
	pigment{DMFWood4}
//	translate y*-2}
merge{cylinder {	<0.0, 0, 0.0>, <0.0, 0, 0.3>, 0.05
	texture{Gold_Texture}}
sphere {	<0.0, 0, 0>, 0.3
	texture{Gold_Texture}
	scale <1.3,0.3,0.3>
	translate <0.2,0,0>}
translate <0.2,2.3,-0.5>}
}