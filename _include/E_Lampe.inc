

#include "colors.inc"
#include "functions.inc"
#include "logo.inc"   
#include "metals.inc"
#include "math.inc" 
//#include "coordinates2.inc"                     
#include "shapes2.inc" 
#include "textures.inc"             
//#include "poly.inc"
//#include "texture_factory_hall.inc"


//global_settings { max_trace_level 5 ambient_light rgb <1.0, 1.0, 0.95> }

//camera {location <-2,2,0> direction 1*z look_at < 0, 1.8, 5 >}  
//camera {location <25,30,25> direction 2*z look_at < 0, 0, 5 >}  
//camera {location <0,10,25> direction 3*z look_at < 0, 1, 0 >}
//camera {location <1,20,30> direction 1.8*z look_at < 1, 2, 0 >}
//camera {location <0.5,-5,0.5> direction 0.3*z look_at < 0, 0, 0 >}
//camera {location <15,1,0> direction 0.8*z look_at < 0, 3, 0 >}
//camera {location <20,20,0> direction 5*z look_at < 5, 12, 0 >}
//camera {location <-9,6,25> direction 5*z look_at <-9, 6, -3> }
//camera {location <-9, 6, -6.0> direction 1*z look_at <-9, 5.8, -5> }
//camera {location <-9, -3, -12.0> direction 3*z look_at <-9, 2, -6> }

//light_source {<20,-10,0> rgb <1.0, 1.0, 0.95>}
//light_source {<-140,200,300> rgb <1.0, 1.0, 0.95>*1.5}
//light_source {<1,2,0> rgb <1.0, 1.0, 0.95>*1.5}                 //in-hall lamp
//light_source {<140,200,-300> rgb <0.9, 0.9, 1.00>*0.8 shadowless}

//#declare scene_floor = plane 
//{       <0, -13, 0>, 0
//        pigment { checker color White, color Black }
//}
//object{ scene_floor }
//object{ scene_floor translate <0, 6, 0> }
                                 
                                 
//###############################


//object{Koordinaten}

#declare plastic_finish = finish
{
        ambient 0.5
        diffuse 0.5
        brilliance 2
        phong 1
} 

//sphere{ <0,1,0> 1 pigment{ Yellow } }        
     
#declare rise = 0.32;
#declare diameter = 0.4;
     
// create a curved tube object translating a sphere along a certain path

//sphere{< 0.000, rise*-7.0,  0.000>, diameter*0.1 pigment{Red} }
//sphere{< 0.000, rise*-6.0,  1.000>, diameter*0.1 pigment{Red} }
//sphere{< 0.000, rise*-0.5, -1.000>, diameter*0.1 pigment{Red} }
//sphere{<-2.121, rise*-0.5,  2.121>, diameter*0.1 pigment{Red} }
//sphere{<-3.000, rise* 0.0,  0.000>, diameter*0.1 pigment{Red} }
//sphere{<-2.121, rise* 0.5, -2.121>, diameter*0.1 pigment{Red} }

#declare full_turn_start = sphere_sweep {
  //linear_spline                 // linear curve
  //cubic_spline                // alternative spline curves
  b_spline
  6,                            // number of specified sphere positions
  <-1.000, rise*-4.0,  1.000>, diameter
  <-0.500, rise*-2.0,  0.750>, diameter
  < 0.000, rise*-0.5,  0.500>, diameter
  <-2.121, rise*-0.5,  2.121>, diameter
  <-3.000, rise* 0.0,  0.000>, diameter
  <-2.121, rise* 0.5, -2.121>, diameter
  //<-3, 1.06,  0>, 0.5
  //tolerance 0.001             // optional
  transmit 0.9
  //pigment{ White }
} 


#declare full_turn = sphere_sweep {
  //linear_spline                 // linear curve
  //cubic_spline                // alternative spline curves
  b_spline
  11,                            // number of specified sphere positions
  <-2.121,rise*-0.5,  2.121>, diameter
  <-3    , rise*0.0,  0    >, diameter                // position, radius
  <-2.121, rise*0.5, -2.121>, diameter
  < 0    , rise*1  , -3    >, diameter                 // ...
  < 2.121, rise*1.5, -2.121>, diameter
  < 3    , rise*2  ,  0    >, diameter
  < 2.121, rise*2.5,  2.121>, diameter
  < 0    , rise*3  ,  3    >, diameter
  <-2.121, rise*3.5,  2.121>, diameter
  <-3    , rise*4.0,  0    >, diameter
  <-2.121, rise*4.5, -2.121>, diameter
  //<-3, 1.06,  0>, 0.5
  //tolerance 0.001             // optional
  //transmit 0.9
  //pigment{ White }
} 

#declare full_turn_narrowing = sphere_sweep {
  //linear_spline                 // linear curve
  //cubic_spline                // alternative spline curves
  b_spline
  17,                            // number of specified sphere positions
  <-2.121                          , rise*-0.5,  2.121                          >, diameter
  <-3.000                          , rise* 0.0,  0.000                          >, diameter                
  <-2.121+0.125*1.5285*diameter*1.5, rise* 0.5, -2.121+0.125*1.5285*diameter*1.5>, diameter
  < 0.000                          , rise* 1.0, -3.000+0.250*2.0000*diameter*1.5>, diameter               
  < 2.121-0.375*1.5285*diameter*1.5, rise* 1.5, -2.121+0.375*1.5285*diameter*1.5>, diameter
  < 3.000-0.500*2.0000*diameter*1.5, rise* 2.0,  0.000                          >, diameter
  < 2.121-0.625*1.5285*diameter*1.5, rise* 2.5,  2.121-0.625*1.5285*diameter*1.5>, diameter
  < 0.000                          , rise* 3.0,  3.000-0.750*2.0000*diameter*1.5>, diameter
  <-2.121+0.875*1.5285*diameter*1.5, rise* 3.5,  2.121-0.875*1.5285*diameter*1.5>, diameter
  <-3.000+1.000*2.0000*diameter*1.5, rise* 4.0,  0.000                          >, diameter
  <-2.121+1.125*1.5285*diameter*1.5, rise* 4.5, -2.121+1.125*1.5285*diameter*1.5>, diameter
  < 0.000                          , rise* 5.0, -3.000+1.250*2.0000*diameter*1.5>, diameter
  < 2.121-1.375*1.5285*diameter*1.5, rise* 5.5, -2.121+1.375*1.5285*diameter*1.5>, diameter
  < 3.000-1.500*2.0000*diameter*1.5, rise* 6.0,  0.000                          >, diameter
  < 2.121-1.625*1.5285*diameter*1.5, rise* 6.5,  2.121-1.625*1.5285*diameter*1.5>, diameter
  < 1.000                          , rise*-18.0, -1.000                         >, diameter
  < 1.000                          , rise*-19.0, -1.000                         >, diameter
  //<-3, 1.06,  0>, 0.5
  //tolerance 0.001             // optional
  //transmit 0.9
  //pigment{ Yellow }
}

#declare spline_dots = union
{
        sphere{ <-3, 0.00,    0>, diameter }
        sphere{ < 0, rise*1, -3>, diameter }
        sphere{ < 3, rise*2,  0>, diameter }
        sphere{ < 0, rise*3,  3>, diameter }
}


#declare quarter_turn_1 = sphere_sweep {
  //linear_spline                 // linear curve
  //cubic_spline                // alternative spline curves
  b_spline
  4,                            // number of specified sphere positions
  <-3, 0.00,  0>, diameter                // position, radius
  < 0, rise*1, -3>, diameter                 // ...
  < 2.5, rise*2,  0>, diameter
  < 0, rise*3,  2.0>, diameter
  //tolerance 0.001             // optional
  transmit 0.9
  pigment{ White }
}

//sphere{ <-3  , 0.00,     0>, diameter pigment{ Yellow } }
//sphere{ < 0  , rise*1,  -3>, diameter pigment{ Yellow } }
//sphere{ < 2.5, rise*2,   0>, diameter pigment{ Yellow } }
//sphere{ < 0  , rise*3, 2.0>, diameter pigment{ Yellow } }

#declare quarter_turn_2 = sphere_sweep {
  //linear_spline                 // linear curve
  //cubic_spline                // alternative spline curves
  b_spline
  4,                            // number of specified sphere positions
  <-1, 0.00,  0>, diameter                // position, radius
  < 0, rise*1, -3>, diameter                 // ...
  < 3, rise*2,  0>, diameter
  < 0, rise*3,  2.0>, diameter
  //tolerance 0.001             // optional
  transmit 0.9
  pigment{ White }
}          

#declare full_turn_old = union
{
        //object{ quarter_turn }
        object{ spline_dots pigment{ Yellow } }
        //object{ quarter_turn rotate <0,  -90, 0> translate <0, rise*1, 0> }
        //object{ spline_dots rotate <0,  -90, 0> translate <0, rise*1, 0> pigment{ Red } }
        //object{ quarter_turn rotate <0, -180, 0> translate <0, rise*2, 0> }
        //object{ spline_dots rotate <0,  -180, 0> translate <0, rise*2, 0> pigment{ Blue } }
        //object{ quarter_turn rotate <0, -270, 0> translate <0, rise*3, 0> }
        //object{ spline_dots rotate <0,  -270, 0> translate <0, rise*3, 0> pigment{ Green } }

}

//object{ full_turn }

#declare full_tube = union
{       
        object{ full_turn_start translate <0, rise*-4, 0> }
        object{ full_turn translate <0, rise*-4, 0> }
        object{ full_turn }
        object{ full_turn translate <0, rise*4, 0> }
        object{ full_turn_narrowing translate <0, rise*8, 0> }
        pigment{ White }
        transmit 0.9
}
                                

//object{ full_tube }       

//object{ full_turn_narrowing translate <0, rise*8, 0> pigment{White} } 

#declare base_head = union
{
        cylinder{ <0,-2.4,0> <0,-1.9,0> 3.3 }

        // clipped conical shape; open, if present, means cone is hollow, else capped
        cone {
                <0,-2.4,0>, 3.3,
                <0,-4.0,0>, 2.7
             }
}

#declare screw = union
{
        object{ full_turn }
        object{ full_turn translate y*rise*-4 }
        object{ full_turn translate y*rise*-8 }
        object{ full_turn translate y*rise*-12 }
}        

//object{ screw scale 0.7 }

#declare thread = union
{
        object{ screw scale 0.7 }
        cylinder{ <0,rise*2,0> <0,rise*-9.2,0> 2.0 }
        //pigment{ Grey }
        //texture{ SilverFinish }
        //finish{ F_MetalD ambient 0.6}
}

#declare base = union
{       
        object{ base_head translate y*4.0 }
        object{ thread scale 0.9 }
        cone {
                <0,rise*-8.1,0>, 1.8,
                <0,rise*-9,0>, 1.3
                //pigment{ White }
                //texture{ SilverFinish }
                //finish{ F_MetalD }
             } 
        cone {
                <0,rise*-9,0>, 1.3,
                <0,rise*-10,0>, 1.0
             }
        sphere{ <0,rise*-9.3,0> 0.5 pigment{Black} }
}

#declare base_finished = object
{
        base
        pigment{ White }
        finish{ plastic_finish }
}                      

#declare lamp_off = union
{
        object{ base_finished translate y*-4 pigment{Grey} }
        object{ full_tube 
                pigment{White}
                finish{ 
                        ambient 0.4
                        diffuse 0.5
                        //reflection .9
                        specular 1
                        //roughness .001
                      }
              }
}        

//object{ lamp_off }

//sphere{ <,,> 0.1 pigment{Red} }
//sphere{ <,,> 0.1 pigment{Red} }
//sphere{ <,,> 0.1 pigment{Red} }
//sphere{ <,,> 0.1 pigment{Red} }
//sphere{ <,,> 0.1 pigment{Red} }

                           
//light_source 
//{
//        <0,0,0>
//        rgb <1.0, 1.0, 0.95>*1
//        //area_light <>, <>, <>, <>, 
//        looks_like{ full_tube }
//        //looks_like{ sphere{ <0,0,0> 1 pigment{Yellow} transmit 0.99} }
//}        
        
#declare lamp_on = union
{
        object{ base_finished translate y*-4 pigment{Grey} }
//        light_source 
//        {
//                <0,0,0>
//                rgb <1.0, 1.0, 0.95>*8
//                looks_like
//                { 
//                        full_tube
//                        finish{ 
//                                ambient 0.8
//                                diffuse 0.5
//                                //reflection .9
//                                specular 1
//                                //roughness .001
//                              }
//                }
//                //looks_like{ sphere{ <0,0,0> 1 pigment{Yellow} transmit 0.99} }
//        } 
	object{full_tube
		finish{ 
                                ambient 0.8
                                diffuse 0.5
                                //reflection .9
                                specular 1
                                //roughness .001
             }
	}
}

//object{ lamp_on translate <0,0,4> }
//box{ <-10,-10,-0.1> <10,10,0.1> pigment{ Grey } }
//object{ lamp_off translate <0,0,-4> }         
//box{ <-10,-10,-15> <-10.1,10,15> pigment{ Grey } }
        
//object{ lamp_off }        
        
//sphere{ <0,0,0> 
//        1 
//        pigment{Yellow} 
//        transmit 0.99
//        finish{ ambient 1 }
//      }    


//sphere 
//{
//       <0,0,0>, 5
//      pigment { White filter 1 }
//        finish {
//                ambient 1
//                diffuse 0.5
//                //reflection .9
//                specular 1
//                //roughness .001
//               }
        //interior { ior 1.33 }
//}

#declare socket = difference
{
        cone {
                <0, 0.0,0>, 2.5,
                <0,-3.2,0>, 2.1
             }            
        object{ base translate y*0 }
        //pigment{ Grey }
}

//object{ base translate <0, 0, 0> pigment{ Grey } }
//object{ socket translate z*0 }
