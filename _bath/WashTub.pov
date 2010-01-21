#include "colors.inc"
camera {	perspective 	location < 0.0, 1, -5>	angle 60	look_at < 0.0, 0.0, 0.0>
	rotate y*45}light_source {	< 100, 100, -100>	rgb <1.000000, 1.000000, 1.000000>	shadowless}background {	rgb <1.000000, 1, 1.000000>}
merge{
difference{
	sphere {		<0.0, 0, 0>, 2
	}
	plane { -y, 0}
	sphere {		<0.0, 0, 0>, 1.7
		pigment{Yellow}	}
	plane { -z, 0}
	pigment{Yellow}
}
intersection{
	difference{
		sphere {			<0.0, 0, 0>, 1.999
		}
		plane { -y, 0}
	}
	box{
		<-2,-2,0><2,-0.001,-0.3>
	}
	pigment{Yellow}
}
	scale <1,0.8,1>
}