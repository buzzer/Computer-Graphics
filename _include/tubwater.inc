#include "glass.inc" // for Water
#include "textures.inc" // for green glass texture

// Water
#declare Water =
plane{y, 0
  texture{ Green_Glass
    normal{
      ripples 0.3
      scale 0.75
      // scale 0.1
      turbulence 0.75
      // turbulence 1
//      translate <DuckX, 0, DuckZ> // Dynamic take duck position
      sine_wave phase 20*pi*clock  // Dynamic waves
    }
    finish{
      ambient 0.15
      diffuse 0.65
      reflection 0.3
    }
  }// end of texture
  interior{I_Glass}
}// end of Water
