#include "textures.inc"

#declare DoorKnobText = texture{Gold_Texture}

#declare BathDoor =
union{
	box {
		< 0, 0, 0>, < 2.5, 5, -0.2>
	//	texture{DMFWood6}
	//	pigment{DMFLightOak}
	//	pigment{Pine_Wood}	
	//	pigment{Cherry_Wood}
	//	pigment{Dark_Wood}
	//	pigment{Tan_Wood}
	//	pigment{DMFWood1}
		pigment{DMFWood4}
	//	translate y*-2
	}
	merge{
		cylinder { <0.0, 0, 0.0>, <0.0, 0, 0.3>, 0.05 texture{DoorKnobText} }
		sphere {
			<0.0, 0, 0>, 0.3
			texture{DoorKnobText}
			scale <1.3,0.3,0.3>
			translate <0.2,0,0>
		}
		translate <0.2,2.3,-0.5>
	}
}