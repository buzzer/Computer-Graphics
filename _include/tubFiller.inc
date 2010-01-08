#declare chrome = texture {
 	pigment { color rgbf < 0.5 0.5 0.5 0>}
	finish { 
		diffuse 0.1 
		specular 0.5 
		reflection 0.5
		roughness 0.005 
		metallic
	} 
}

#declare tub_filler=
union {
  //fancy mountpoint
  cylinder { <0,0,0> <0,0,0.1> 1.65 }
  torus { 1.65 0.1 rotate 90*x }
  cylinder { <0,0,0> <0,0,0.2> 1.55 }
  torus { 1.55 0.1 rotate 90*x translate 0.1*z }
  cylinder { <0,0,0> <0,0,0.3> 1.45 }
  torus { 1.45 0.1 rotate 90*x translate 0.2*z }
  //spout
  difference {
    sphere_sweep {
      b_spline
      7 <0,0,-3> 2 <0,0,-1> 2 <0,0,1.6> 0.5 <0,0,4> 0.5
      <0,0,5.5> 0.5 <0,-1.3,5.7> 0.5 <0,-2.6,5.9> 0.5
    }
    box { <-3,-3,-3> <3,3,0> }
    box { <-2,-1,-2> <2,0,2> rotate -15*x translate <0,-1.2,5> }
    cylinder { <0,-1,0> <0,0.7,0> 0.4 rotate -15*x translate <0,-1,5.67> }
  }
  torus { 0.5 0.1 rotate -15*x translate <0,-1,5.67> }
  texture { chrome }
}
