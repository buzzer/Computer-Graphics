// Lamp object by Rune S. Johansen

// easyblob macro by Rune S. Johansen
#macro easyblob (_threshold,_visibleradius,_blobbiness)
   #local _strength = (1+1/_blobbiness)*_threshold;
   #local _actualradius =
   _visibleradius/sqrt(1-sqrt(_threshold/_strength));
   _actualradius, _strength
#end

#declare Lamp =
blob {
   threshold 1
   sphere {0, easyblob(1,1,0.1)    scale <.16,0.16,.16> translate  1.9*y}
   sphere {0, easyblob(1,1,0.1)    scale <1.0,0.30,0.8> translate  1.5*y}
   
   sphere {0, easyblob(1,1,1)*-0.4 scale <1.8,1.00,1.4> translate  2.5*y}
   sphere {0, easyblob(1,1,1)      scale <1.8,1.00,1.4> translate  1.0*y}
   
   sphere {0, easyblob(1,1,1)      scale <0.8,0.15,0.6> translate 0.05*y}
   sphere {0, easyblob(1,0.9,1)*-1 scale <0.8,0.15,0.6> translate -0.1*y}
   
   #declare C = 0;
   #declare Cm = 20;
   #while (C<=Cm)
      #declare Value = C/Cm;
      
      #declare P = <1.3,0.8,0> + 1.5*Value*x + (-cos(Value*pi)/2+0.5)*y;
      sphere {P, 0.6-0.4*Value, 2}
      
      #declare C = C+1;
   #end
   sphere {0, 1, -5 scale <0.4,0.1,0.2> translate <2.8,1.82,0>}
   
   #declare C = 0;
   #declare Cm = 60;
   #while (C<Cm)
      #declare Value = C/Cm;
      
      #declare P = vrotate(vrotate(0.7*y,360*z*Value)*<0.75,1,1>,55*z) + <-2.1,1.1,0.0>;
      sphere {P, 0.16+0.06*cos(Value*2*pi), 2 scale <1,1,1.5>}
      
      #declare C = C+1;
   #end
   
   pigment {color <1.0,0.8,0.2>}
   finish {phong 0.3 phong_size 1 specular 0.8}
   
   rotate -90*y
   
   clipped_by {box {<-1.6,-0.1,-3.0>, <1.6,2.1,2.9>}}
}
