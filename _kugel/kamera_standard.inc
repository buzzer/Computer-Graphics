#include "colors.inc"
#include "metals.inc"
#include "glass.inc"
#include "Start_Pos.inc"


global_settings {max_trace_level 5}

//camera { angle 45 location <30,20,20> direction 1.8*z look_at < 5, 5, 0 >}
//--> camera { angle 0 location < 30, 30, -40 > direction 3.8*z look_at < 0, 3, 0 >}
//camera { angle 0 location < 30, -30, -40 > direction 3.8*z look_at < 0, 3, 0 >}

camera {location <10, 20, 10> direction 1.8*z look_at < 0, 0, 0 >}
//camera {location < -180,1000,-120 > direction 3.6*z look_at < -100,970,-90 > rotate <0,0,0> }
//camera {location <0,-1,-50> direction 1.8*z look_at < 0, -2, 0 >}
//camera {location <0,50,-150> direction 1.8*z look_at < 0, -2, 0 >}

light_source {<-1000, 10000, -1000> color White}
//light_source {<-200, 50, -500> color Gray50}
//light_source {< 50, 30, -20> color Gray75}
//light_source {<-500,500,50> rgb <1.0, 1.0, 0.95>*1.5}
//light_source {<140,200,-300> rgb <0.9, 0.9, 1.00>*0.8 shadowless}

#declare Boden = plane { < 0, 1, 0 >, -6.80
      pigment { White } //pigment { checker color Black, color White }
}

//object { Boden }