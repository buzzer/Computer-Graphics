
#include "colors.inc"
#include "functions.inc"
#include "logo.inc"   
#include "metals.inc"
#include "math.inc" 
//#include "coordinates2.inc"                     
#include "shapes2.inc" 
#include "textures.inc"             

#include "E_Lampe.inc"
//#include "Factory_hall.inc" 
//#include "claw.inc"



global_settings { max_trace_level 5 ambient_light rgb <1.0, 1.0, 0.95> }

camera {location <10,2.0,0> direction 2*z look_at < -4, 0.7, 0 >} 
//camera {location <4,2.0,2> direction 2*z look_at < 4, 2.0, 0 >}
//camera {location <7.6,1.8,-1.8> direction 1*z look_at < 7.6, 1.8, 1.8 >}    
//camera {location <25,30,25> direction 2*z look_at < 0, 0, 5 >}  
//camera {location <0,10,25> direction 3*z look_at < 0, 1, 0 >}
//camera {location <1,20,30> direction 1.8*z look_at < 1, 2, 0 >}
//camera {location <0.5,-5,0.5> direction 0.3*z look_at < 0, 0, 0 >}
//camera {location <0,2,150> direction 4*z look_at < 0, 2, 0 >}
//camera {location <20,20,0> direction 5*z look_at < 5, 12, 0 >}
//camera {location <-9,6,25> direction 5*z look_at <-9, 6, -3> }
//camera {location <-9, 6, -6.0> direction 1*z look_at <-9, 5.8, -5> }
//camera {location <-9, -3, -12.0> direction 3*z look_at <-9, 2, -6> }

//light_source {<0,10,20> rgb <1.0, 1.0, 0.95>}
//light_source {<-140,200,300> rgb <1.0, 1.0, 0.95>*1.5}
light_source {<1,2,0> rgb <1.0, 1.0, 0.95>*1.5}                 //in-hall lamp
//light_source {<140,200,-300> rgb <0.9, 0.9, 1.00>*0.8 shadowless}

#declare scene_floor = plane 
{       <0, -13, 0>, 0
        pigment { checker color White, color Black }
}
//object{ scene_floor }
//object{ scene_floor2 }
//object{ scene_floor translate <0, 6, 0> }
                                 
                                 
//###############################

#declare chrome = texture
{ 
        pigment{ color rgbf <0.5, 0.5, 0.5> } 
        finish{ diffuse 0.1 
                specular 0.5 
                reflection 0.7 
                roughness 0.005 
                metallic  
              }             
}

//-------------------------------------

#declare Custom_SilverFinish = finish
{
   metallic
   ambient 0.25
   diffuse 0.95
   reflection 0.05
   brilliance 6
   phong 1
   phong_size 100
}

//-------------------------------------

//object{Koordinaten}

 

 
 

#declare hip_width = 7;
#declare femoral_length = 10;
#declare shank_length = 8;                    
#declare leg_length = (femoral_length + shank_length);
#declare torso_height = leg_length * 0.63;
#declare neck_length = torso_height * 0.15;
#declare shoulder_width = hip_width * 1.15;
#declare upper_arm_length = torso_height * 0.63;
#declare lower_arm_length = upper_arm_length;

#declare tube_diameter = 1;               

//set joints coordinates

#declare local_clock = clock;

#declare leg_step_angle = 60;

               
//get_angles_for_one_step_left_leg(local_clock, leg_step_angle) 

#declare left_hip_angle = 90; 
#declare left_shank_angle = 0;

//get_angles_for_one_step_right_leg(local_clock, leg_step_angle)

#declare right_hip_angle = 90; 
#declare right_shank_angle = 0;
                                    
                                    
#if( local_clock > 1 ) //>= 0.5 )
        #declare set_hip_y_offset = cos( (pi/180) * ( 90 - left_hip_angle )) * leg_length;
        #declare set_hip_x_offset = sin( (pi/180) * ( 90 - left_hip_angle )) * leg_length;  
        #declare set_hip_x_offset = set_hip_x_offset + 2 * (sin( (pi/180) * ( 90 - leg_step_angle )) * leg_length);
#else                                 
        #declare set_hip_y_offset = cos((pi/180) * ( right_hip_angle - 90 )) * leg_length;
        #declare set_hip_x_offset = -sin((pi/180) * ( right_hip_angle - 90 )) * leg_length;
#end

#declare set_hip_y_offset = set_hip_y_offset + tube_diameter;



//hip base                                      
#declare A   = <0,0,0>; 

//left leg

#declare B_  = A    + <0, 0 , hip_width / 2>;                                          //left hip joint
#declare C_  = B_   + <-femoral_length, 0, 0>;                                         //left knee joint
#declare C_  = vrotate( C_, <0,0,left_hip_angle> );                                    // "    "     "
#declare D_  = A    + <0,-shank_length, 0>;                                            //left ankle
#declare D_  = vrotate( D_, <0,0,left_shank_angle> );                                  // "     "
#declare D_  = D_   + C_;                                                              // "     "

//right leg  

#declare B__  = A   + <0, 0 ,-hip_width / 2>;                                          //right hip joint
#declare C__  = B__ + <-femoral_length, 0, 0>;                                         //right knee joint
#declare C__  = vrotate( C__, <0,0,right_hip_angle> );                                 //  "    "     "
#declare D__  = A   + <0,-shank_length, 0>;                                            //right ankle
#declare D__  = vrotate( D__, <0,0,right_shank_angle> );                               //  "     "
#declare D__  = D__ + C__;                                                             //  "     "

//#declare left_shoulder_angle = 90;
//#declare right_shoulder_angle = 90;
//#declare left_ellbow_angle = 0;
//#declare right_ellbow_angle = 0;

#declare E    = A   + <0, torso_height, 0>;                                            
#declare E_   = E   + <0, neck_length, 0>;                                             //head joint

//left arm
//get_angles_for_one_step_left_arm(clock)
#declare left_shoulder_angle = 90; 
#declare left_ellbow_angle = 0;

#declare F_   = E   + <0,0, shoulder_width / 2> ;                                      //left shoulder joint
#declare G_   = A   + <-upper_arm_length, 0, 0>;                                       //left ellbow joint
#declare G_   = vrotate( G_, <0,0,left_shoulder_angle> );                              // "     "      "
#declare G_   = G_  + F_ + <0,0,tube_diameter*1.9>;                                   // "     "      "
#declare H_   = A  + <0, -lower_arm_length, 0>;                                        //left hand joint
#declare H_   = vrotate( H_, <0,0,left_ellbow_angle> );                                // "    "     "
#declare H_   = H_  + G_;                                                              // "    "     "

//right arm
//get_angles_for_one_step_right_arm(clock)
#declare right_shoulder_angle = 90; 
#declare right_ellbow_angle = 0;

#declare F__  = E   + <0,0,-shoulder_width / 2> ;                                      //right shoulder joint
#declare G__  = A   + <-upper_arm_length, 0, 0>;                                       //right ellbow joint
#declare G__  = vrotate( G__, <0,0,right_shoulder_angle> );                            //  "     "      "
#declare G__  = G__ + F__ + <0,0,-tube_diameter*1.9>;                                   //  "     "      "
#declare H__  = A   + <0, -lower_arm_length, 0>;                                       //right hand joint
#declare H__  = vrotate( H__, <0,0,right_ellbow_angle> );                              //  "    "     "
#declare H__  = H__ + G__;                                                             //  "    "     "


//correct height of all points due to walking movement
#declare A   = A   + < set_hip_x_offset, set_hip_y_offset, 0 >;
#declare B_  = B_  + < set_hip_x_offset, set_hip_y_offset, 0 >;
#declare B__ = B__ + < set_hip_x_offset, set_hip_y_offset, 0 >;
#declare C_  = C_  + < set_hip_x_offset, set_hip_y_offset, 0 >;
#declare C__ = C__ + < set_hip_x_offset, set_hip_y_offset, 0 >;
#declare D_  = D_  + < set_hip_x_offset, set_hip_y_offset, 0 >;
#declare D__ = D__ + < set_hip_x_offset, set_hip_y_offset, 0 >;
#declare E   = E   + < set_hip_x_offset, set_hip_y_offset, 0 >;
#declare E_  = E_  + < set_hip_x_offset, set_hip_y_offset, 0 >;
#declare F_  = F_  + < set_hip_x_offset, set_hip_y_offset, 0 >;
#declare F__ = F__ + < set_hip_x_offset, set_hip_y_offset, 0 >;
#declare G_  = G_  + < set_hip_x_offset, set_hip_y_offset, 0 >;
#declare G__ = G__ + < set_hip_x_offset, set_hip_y_offset, 0 >;
#declare H_  = H_  + < set_hip_x_offset, set_hip_y_offset, 0 >;
#declare H__ = H__ + < set_hip_x_offset, set_hip_y_offset, 0 >;
                                                                   
                                                                   
//rotate around foot on ground to prevent other foot to go through ground

#declare full_foot_rotate_angle = 5;

#if( local_clock <= 1.00 )
        #declare R = D__;
        #declare foot_rotate_angle = full_foot_rotate_angle * (local_clock-0.75) * 4;
#end
#if( local_clock <= 0.75 )
        #declare R = D__;
        #declare foot_rotate_angle =   full_foot_rotate_angle 
                                     - full_foot_rotate_angle * (local_clock-0.50) * 4;
#end
#if( local_clock <= 0.50 )                                                           
        #declare R = D_;
        //#declare foot_rotate_angle = full_foot_rotate_angle * (local_clock-0.25) * 4;
        #declare foot_rotate_angle =   full_foot_rotate_angle 
                                     - full_foot_rotate_angle * (local_clock-0.00) * 4;
#end
#if( local_clock <= 0.25 )                                                             
        #declare R = D_;
        //#declare foot_rotate_angle =   full_foot_rotate_angle 
        //                             - full_foot_rotate_angle * (local_clock-0.00) * 4;
        #declare foot_rotate_angle = full_foot_rotate_angle * (local_clock-0.25) * 4;
#end

//#declare A   = A   + vrotate( R, <0,0,foot_rotate_angle> );
//#declare B_  = B_  + vrotate( R, <0,0,foot_rotate_angle> );
//#declare B__ = B__ + vrotate( R, <0,0,foot_rotate_angle> );
//#declare C_  = C_  + vrotate( R, <0,0,foot_rotate_angle> );
//#declare C__ = C__ + vrotate( R, <0,0,foot_rotate_angle> );
//#declare D_  = D_  + vrotate( R, <0,0,foot_rotate_angle> );
//#declare D__ = D__ + vrotate( R, <0,0,foot_rotate_angle> );
//#declare E   = E   + vrotate( R, <0,0,foot_rotate_angle> );
//#declare E_  = E_  + vrotate( R, <0,0,foot_rotate_angle> );
//#declare F_  = F_  + vrotate( R, <0,0,foot_rotate_angle> );
//#declare F__ = F__ + vrotate( R, <0,0,foot_rotate_angle> );
//#declare G_  = G_  + vrotate( R, <0,0,foot_rotate_angle> );
//#declare G__ = G__ + vrotate( R, <0,0,foot_rotate_angle> );
//#declare H_  = H_  + vrotate( R, <0,0,foot_rotate_angle> );
//#declare H__ = H__ + vrotate( R, <0,0,foot_rotate_angle> );

//#declare S  = C_ + vrotate( R, < 0, 0, (pi/180) * 5 > );
//#declare S  = vaxis_rotate( C_, R, 15 );
//sphere{ R tube_diameter * 1.5 pigment{Red} }
//sphere{ S tube_diameter * 1.5 pigment{Red} }          
     
////start walking from standing

//time-dependend translation of coordinates (A is fixed)

//left leg forward
//#declare C_ = C_ + C_ * <femoral_length * sin(15), 0, 0>;
//#declare D_ = D_ * <sin(0) , cos(0) , 0>;








////Assemble body    

#declare helferlein = union
{

        //hip    
        cylinder{ B__ B_ tube_diameter pigment{Grey} finish{Custom_SilverFinish} }
        //left leg      
        sphere{ B_ tube_diameter*1.5 pigment{Grey} finish{Custom_SilverFinish} }
        cylinder{ B_ C_ tube_diameter pigment{Grey} finish{Custom_SilverFinish} }
        sphere{ C_ tube_diameter*1.3 pigment{Grey} finish{Custom_SilverFinish} }
        cylinder{ C_ D_ tube_diameter pigment{Grey} finish{Custom_SilverFinish} }
        sphere{ D_ tube_diameter pigment{Grey} finish{Custom_SilverFinish} }
        //right leg
        sphere{ B__ tube_diameter*1.5 pigment{Grey} finish{Custom_SilverFinish} }
        cylinder{ B__ C__ tube_diameter pigment{Grey} finish{Custom_SilverFinish} }
        sphere{ C__ tube_diameter*1.3 pigment{Grey} finish{Custom_SilverFinish} }
        cylinder{ C__ D__ tube_diameter pigment{Grey} finish{Custom_SilverFinish} }
        sphere{ D__ tube_diameter pigment{Grey} finish{Custom_SilverFinish} }

        //torso
        cylinder{ A E tube_diameter pigment{Grey} finish{Custom_SilverFinish} }
        //neck
        sphere{ E tube_diameter*1.3 pigment{Grey} finish{Custom_SilverFinish} }
        cylinder{ E E_ tube_diameter*0.8 pigment{Grey} finish{Custom_SilverFinish} }
        #declare lamp_scale = 0.9;
        //object{ socket scale lamp_scale translate y*(torso_height + 2.2*neck_length)}
        object
        { 
                socket 
                scale lamp_scale 
                translate E_ + <0,3.2*lamp_scale,0> 
                pigment{Grey} 
                finish{Custom_SilverFinish}
        }

        //head
        #switch( clock  )
        #range( 0.0, 0.2 )
        //        object{ lamp_off scale lamp_scale translate E_ + <0, torso_height + 2.2*neck_length + 4*lamp_scale, 0> }
        #break
        #range( 0.2, 0.3 )
        //        object{ lamp_on scale lamp_scale translate E_ + <0, torso_height + 2.2*neck_length + 4*lamp_scale, 0> }
        #break
        #range( 0.3, 0.4 )
        //        object{ lamp_off scale lamp_scale translate E_ + <0, torso_height + 2.2*neck_length + 4*lamp_scale, 0> }
        #break
        #range( 0.4, 0.6 )
        //        object{ lamp_on scale lamp_scale translate E_ + <0, torso_height + 2.2*neck_length + 4*lamp_scale, 0> }
        #break
        #range( 0.6, 0.7 )
        //        object{ lamp_off scale lamp_scale translate E_ + <0, torso_height + 2.2*neck_length + 4*lamp_scale, 0> }
        #break       
        #range( 0.7, 1.0 )
        //        object{ lamp_on scale lamp_scale translate E_ + <0, torso_height + 2.2*neck_length + 4*lamp_scale, 0> }
        #break
        #end

        //object{ lamp_off scale lamp_scale translate E_ + <0, (3.2 + 4)*lamp_scale, 0> }

        //shoulders
        cylinder{ F__ F_ tube_diameter pigment{Grey} finish{Custom_SilverFinish} }
        //left arm
        sphere{ F_ tube_diameter*1.3 pigment{Grey} finish{Custom_SilverFinish} }
        cylinder{ F_ G_ tube_diameter pigment{Grey} finish{Custom_SilverFinish} }
        sphere{ G_ tube_diameter*1.3 pigment{Grey} finish{Custom_SilverFinish} }
        cylinder{ G_ H_ tube_diameter pigment{Grey} finish{Custom_SilverFinish} }
        sphere{ H_ tube_diameter*1.4 pigment{Grey} finish{Custom_SilverFinish} }
        //right arm
        sphere{ F__ tube_diameter*1.3 pigment{Grey} finish{Custom_SilverFinish} }
        cylinder{ F__ G__ tube_diameter pigment{Grey} finish{Custom_SilverFinish} }
        sphere{ G__ tube_diameter*1.3 pigment{Grey} finish{Custom_SilverFinish} }
        cylinder{ G__ H__ tube_diameter pigment{Grey} finish{Custom_SilverFinish} }   
        sphere{ H__ tube_diameter*1.4 pigment{Grey} finish{Custom_SilverFinish} }
        
}

#declare world_scale = 0.05*(1/0.9);

#declare body_x_offset = 4;



object{ helferlein scale world_scale translate <body_x_offset,0,0>}        

//#declare finger_angle = 9.9 + 25 - 25*clock;

//#declare claw_ = get_claw(finger_angle)

#declare thread_rise = rise * 0.7 * lamp_scale;
#declare screw_height = thread_rise*16 - 4;

#declare screw_height = (screw_height + 4) * world_scale;

#declare lamp_free = object
{ 
        lamp_on 
        scale lamp_scale * world_scale 
}

object{ 
        lamp_free 
        //rotate <0, 0 + 1440*clock, 0>
        translate E_*world_scale + <body_x_offset, ( 3.6 )*lamp_scale*world_scale, 0>
        translate < 0,screw_height , 0> 
      }
      
//object
//{ 
//        claw_ 
//        scale 0.1
//        //rotate <0, 30 + 1440*clock, 0> 
//        translate <4,2.5,0> + <0,screw_height + 1.8*clock,0> 
//}

