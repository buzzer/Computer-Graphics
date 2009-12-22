// Persistence of Vision Ray Tracer Scene Description File
// File: litebulb.pov
// Vers: 3.1
// Desc: household incandescent bulb (60 Watt)
// Date: 99.701
// Auth: Bob Hughes
// Mail: mailto:inversez@aol.com?Subject=PoV-Scene
// Note: This is set up as a scene file, to use only the bulb itself you will need to set
//       the Scene switch to off and use  LB  as the object in your own scenes (using this as a include).
//        _C_  must be defined also for using the light intensity you want (see the Lightbulb section).
//       Bulb dimensions are inches of approximately 4.25 H by 2.25 W & D, base tip centered on <0,0,0>.
//       Light fading starting at 15 units with a linear dropoff.
//       Keep in mind the light output is not relevant to real lightbulbs :-)
// Warn: Since this uses 'sor' it is highly unstable so certain viewpoints will cause distortion!

#declare Scene=on;

#if (Scene!=off)

global_settings {
max_trace_level 9
//ambient_light <1.5,1.5,1.5>*.75
//     radiosity {
//       brightness 3
//       count 123
//       distance_maximum 3  // 1/3 camera to object distance
//       error_bound 0.38
//       gray_threshold 0.4
//       low_error_factor 0.7
//       minimum_reuse 0.018
//       nearest_count 7
//       recursion_limit 1
//     }
 }

// Set a color of the background. NOTE: this affects scene reflections
background {
 color red 0.125 green 0.125 blue 0.125
}

// white pointlight and camera with variable positions
#declare LCX = 0;
#declare LCY = 0;
#declare LCZ = -9;
// rotation vectors (adjust for varying placements)
#declare RLX = 40;		#declare RCX = 30;
#declare RLY = 33;		#declare RCY = -15;
#declare RLZ = 0;		#declare RCZ = 0;

// external light
//light_source { <LCX,LCY,LCZ-15> color rgb <1.5,1.5,1.5>*.333 // *.667 approximates color rgb 1
//        spotlight point_at 0 radius 15 falloff 20
// rotate RLX*x rotate RLY*y rotate RLZ*z
//}
camera {
  location  <LCX,LCY,LCZ>
	rotate RCX*x rotate RCY*y rotate RCZ*z
  angle 45
  look_at   <0, 2.75, 0>
}

// scene surroundings
// room
box {<-75,-12.5,-50>,<75,25,50> hollow on
     pigment {rgb 1} finish {ambient .15 diffuse .85}}
// tabletop
box {<-10,-2,-10>,<10,-.5,10> pigment {rgb 1} finish {ambient .1 diffuse .8}}
// misc. objects
sphere {0,1 pigment {blue 1} translate <1.75,.51,3>}
cone {-y,1,y,0 pigment {green 1} translate <-2.5,.51,2.125>}
box {-1,1 pigment {red 1} translate <-5.5,.51,5>}
#end  // use scene or not


/* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Lightbulb %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */

// light intensity [0 to 1 typically]
#declare _C_ = .667; // clock;

// scale factor [inversely proportional to end scale, ie. LB at 0.5 would be 2 here]
#declare SF = 1; // change this according to any rescaling to be done

// Area light smoothness [1X1, 2X2, etc.]
#declare AS = 4;

// Area light jitter on or off (really not a good idea to turn off)
#declare AJ = on;

// lightbulb threads
#declare Thread =
union {union {
 difference { // threads
 cylinder {-y,y,1.1}
 torus {1.25,.25 rotate <15,-45,0> translate -1*y}
 torus {1.25,.25 rotate <15,-45,0> translate -.5*y}
 torus {1.25,.25 rotate <15,-45,0> translate 0*y}
 torus {1.25,.25 rotate <15,-45,0> translate .5*y}
 torus {1.25,.25 rotate <15,-45,0> translate 1*y}
 } // difference
 cone {0,1,.15*y,1.05 scale 1.05 translate 1*y} // upper thread lip
 cone {0,1,-.42*y,.667 scale 1.05 translate -1*y} // thread base
   texture {pigment {rgb<.985,.98,.99>*2}
    finish {ambient .025 diffuse .7 metallic brilliance -.075 reflection .5 reflection_exponent .9
         specular .9 roughness .006 phong .35 phong_size 6}
   }
  scale <.2975,.2125,.2975> translate -.18*y
 } // union
 cone {-y,.4,0,1 // insulator
       scale <.2975,.17,.2975> translate -.415*y
  texture {pigment {rgb<.05,.05,.05>}
   finish {ambient .05 diffuse .5 metallic brilliance 2.5 reflection .25 reflection_exponent .75}
         }
 }
 cylinder {-y,y,1 // brass contact
           scale <.425,.025,.425> scale <.3375,.225,.3375> translate -.575*y
  texture {pigment {rgb<1.95,1.95,.5>}
   finish {ambient .05 diffuse .75 metallic brilliance 2.5 reflection .125 reflection_exponent .75 specular .5 roughness .1}
  }
 } sphere {0,1 // solder contact
           scale <.1125,.05,.1125> translate -.58*y
  texture {pigment {rgb<.95,.95,.95>}
   finish {ambient .05 diffuse .75 metallic brilliance .5 reflection .125 reflection_exponent .75 specular .5 roughness .1}
  }
 }
  scale .96 translate -.06*y
} // union

#declare ContactThread=
difference { // hollow out threads
        object {Thread} object {Thread scale <.95,1.01,.95> translate .0125*y}
}

// lightbulb glass object
#declare LBG =
sor{
	16,
	<0.1,-0.06>,
	<0.1575,0.025>,
	<0.1625,0.125>,
	<0.185,0.242124>,
	<0.23,0.36>,
        <0.26,0.42>,
	<0.29,0.48>,
	<0.338973,0.632548>,
	<0.326867,0.759663>,
	<0.284495,0.853486>,
	<0.226991,0.920070>,
	<0.145274,0.971522>,
	<0.081717,0.992707>,
	<0.030265,0.998761>,
	<0.005000,1.000000>,
	<0.000000,1.004814>
 // sturm
  scale 2
}

// whole light bulb
#declare LB =
union {
// actual light source
light_source {0 // color is set to go very high due to opacity in bulb glass
         color rgb <1.33+(_C_*1),.75+(_C_*1.5),.667+(_C_*1.667)>*_C_
  area_light <.3+(_C_*.6), -.15-(_C_*.65), 0> <0, .3+(_C_*.6), .15+(_C_*.65)> AS, AS
 #if (AJ!=off) adaptive 1 jitter #end
   fade_distance 15 fade_power 1
 translate <0, 1.33, 0>
}
// final bulb glass
 merge {
 object {LBG hollow on} object {LBG scale .975 translate .01*y}
  texture {pigment {rgbf<(1.25-(.15*_C_)),(1.25-(.15*_C_)),(1.25-(.15*_C_)),(.1+(.2*_C_))>}
   finish {ambient .25+(_C_*.125) diffuse .9-(.5*_C_) specular .8 roughness .005 phong .1 phong_size 5
         reflection .15 reflection_exponent .8}
  }
   interior { fade_distance .75 fade_power 2
        media {
               intervals 9 samples 1,1
                emission <.8+(.175*_C_),.5+(.45*_C_),.3+(.625*_C_)>*(5*_C_)
                absorption <.3,.33,.29>*(3*_C_)
        density {spherical density_map {
                [0 rgb<1,.95,.9>*.15*_C_*.6*SF]
                [.4 rgb<1,.95,.9>*.5*_C_*.6*SF]
                [.8 rgb<1,.95,.9>*3-(1.5*_C_)*.6*SF]
                [1 rgb<1,.95,.9>*6-(3*_C_)*.6*SF]
        }} scale <.3125,.625,.3125> translate 1.46*y
        }}
 /*
  // use any light bulb logo here based on a 275 by 275 pixel gif with white background (palette # 255)
  texture {pigment {image_map { 
                               gif "ge_logo.gif"
                               map_type 0 once filter 255,1 transmit 0,.33+(.33*_C_)}
   translate -.5 rotate 90*x scale <.45,1,.45>}}
 */
 } // merge
// filament glass
 union {
 difference {
 difference {
 blob {threshold .5
        cylinder {-x*1,x*1,1.1,1 scale <1.33,.6,1.25> translate .33*y}
        cylinder {-x*1,x*1,1,1 scale <1.25,.6,1.25> translate -.1*y}
        cylinder {-y,0,1,1 scale <1.75,2.9,1>}
        cylinder {-y*1.25,-y*.5,1.1,1 scale <1.75,2,3>}
    scale <.0825,.1875,.05> translate .3*y
 }
 cylinder {0,.25*y,.1 translate .525*y}
 cylinder {0,-.1125*y,.03 scale <1,1,.25> translate .52501*y}
 sphere {0,1 scale <.0625,.0875,.075> translate .125*y}
 cylinder {-.5*y,.5*y,1 scale <.0625,.5,.075> translate -.125*y}
 }
 sphere {0,.1 scale <.5,.667,.667> translate .33*y}
 }
 cylinder {-.5*y,.5*y,1 scale <.025,.5,.025> translate 0*y}
 
  texture {pigment {rgbf<1.133,1.13,1.127,(.75-(.125*_C_))>}
   finish {ambient .33-(_C_*.25) diffuse .8-(.4*_C_) specular .5 roughness .005 reflection .2}
  } interior {ior 1.45 caustics 3 fade_distance .175 fade_power 1}
 } // union
// filament supports
 union {
        cylinder {-y,y,.0036 scale <1,.4,1> rotate <0,0,1> translate <-.05,-.1,0>}
        cylinder {-y,y,.0036 scale <1,.4,1> rotate <0,0,-1> translate <.05,-.1,0>}
        cylinder {-y,y,.0036 scale <1,.0775,1> rotate <0,0,10> translate <-.075,.375,0>}
        cylinder {-y,y,.0036 scale <1,.0775,1> rotate <0,0,-10> translate <.075,.375,0>}
        cylinder {-y,y,.0036 scale <1,.3,1> rotate <0,0,25> translate <-.2125,.7125,0>}
        cylinder {-y,y,.0036 scale <1,.15,1> rotate <0,0,-29> translate <.16,.575,0>}
        cylinder {-y,y,.0036 scale <1,.36,1> rotate <0,0,-11> translate <-.2675,1.325,0>}
        cylinder {-y,y,.0036 scale <1,.15,1> rotate <0,0,10> translate <.2,.85,0>}
        cylinder {-y,y,.0036 scale <1,.125,1> rotate <0,0,90> translate <-.075,1.67,0>}
        cylinder {-y,y,.0036 scale <1,.125,1> rotate <0,0,90> translate <.05,1,0>}
        cylinder {-y,y,.0036 scale <1,.025,1> rotate <90,0,0> translate <0,1.67,0>}
        cylinder {-y,y,.0036 scale <1,.025,1> rotate <90,0,0> translate <0,1,0>}
         texture {pigment {rgbf<.95,.925,.975>}
  finish {ambient .125 diffuse .667 metallic brilliance 2 reflection .25 reflection_exponent .75}
  }
 } // union
// filament
  cylinder {-y,y,1
        #if (_C_!=0) no_shadow #end
         texture {pigment {gradient y frequency 9
                 color_map {
                [.75 color rgbf<1,1,1,1>]
                [.75 color rgbf<2.5*(2-_C_),1.75*(1.125-_C_),1.125*(1.5-_C_),0>*(2*_C_)]
                } triangle_wave rotate 1*z}
  finish {ambient .15+(.85*_C_) diffuse .75 metallic brilliance 1.5 reflection .25 reflection_exponent .75}
         } scale <.02,.25,.02> translate 1.33*y
  } // union
 object {ContactThread}
  translate 0.75*y scale 1.7
} // union

#if (Scene=on)
LB  // the light bulb complete
#end
