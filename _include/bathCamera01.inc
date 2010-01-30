#include "math.inc"
#include "transforms.inc"

// The spline that the camera fly along
#declare CamSpline =
spline {
   cubic_spline
   
   -1, <0.25*RoomWidth, 0.5*RoomHeight, -0.25*RoomDepth>, // control point
   
   00, < 0.5*RoomWidth, 0.3*RoomHeight, -0.25*RoomDepth>, // start
   01, < 0.75*RoomWidth, 0.3*RoomHeight, -0.25*RoomDepth>,
   02, < 0.75*RoomWidth, 0.3*RoomHeight, -0.5*RoomDepth>,
   03, < 0.75*RoomWidth, 0.3*RoomHeight, -0.75*RoomDepth>,
   04, < 0.5*RoomWidth, 0.5*RoomHeight, -0.75*RoomDepth>,
   05, < 0.25*RoomWidth, 0.75*RoomHeight, -0.75*RoomDepth>,
   06, < 0.25*RoomWidth, 0.75*RoomHeight, -0.5*RoomDepth>,
   07, < 0.25*RoomWidth, 0.5*RoomHeight, -0.25*RoomDepth>,
   08, < 0.5*RoomWidth, 0.3*RoomHeight, -0.25*RoomDepth>, // stop
   
   09,  < 0.75*RoomWidth, 0.3*RoomHeight, -0.25*RoomDepth>, // control point
}


// First-person-view camera
// Follows the same path as the first aircraft
#declare BathCamera =
camera {
	angle 90
      location 0
      look_at z
      translate <0,0.4,0.4>
      Spline_Trans (CamSpline, clock*08, y, 0.5, 0.0)
   }