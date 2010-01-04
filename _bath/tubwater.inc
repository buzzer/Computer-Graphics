#include "glass.inc" // for Water

// Water
#declare Water =
plane{y, 0
      texture{
      		Green_Glass
              normal{
              	ripples 0.3
                    scale 0.25
//                    scale 0.1
                    turbulence 0.75
//                    turbulence 1
                    translate <DuckX, 0, DuckZ>// TODO dynamic take duck position
		}
      		finish{
      			ambient 0.15
             		diffuse 0.65
             		reflection 0.3
             	}
      	}// end of texture
      interior{I_Glass}
}// end of Water