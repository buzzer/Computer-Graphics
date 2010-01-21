#declare CeramicPigment = pigment { rgb <1,1,1> }
#declare CeramicFinish     = finish { reflection .1 ambient .2 diffuse .9 }

#declare Washtub =
merge{
	difference{ // Sphere part
		sphere { <0, 0, 0>, 2	}
		plane { -y, 0 }
		sphere { <0, 0, 0>, 1.7 }
		plane { -z, 0}
	}
	intersection{ // Back board
		difference{
			sphere { <0.0, 0, 0>, 1.999 }
			plane { -y, 0}
		}
		box{ <-2,-2,0><2,-0.001,-0.3> }
	}
	pigment{CeramicPigment}
	finish{CeramicFinish}
	scale <1,0.8,1>
}