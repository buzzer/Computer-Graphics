// Two rounds in the bath tub.
#declare NumDuckyPos = 12;
#declare YawAdvance = 0.5;
#declare RollAdvance = 0.2;
#declare ViewAxis = y;
#declare P1 = < (RoomWidth-TubWidth)+0.75*TubWidth, DuckY, -0.25*TubDepth>;
#declare P2 = < (RoomWidth-TubWidth)+0.50*TubWidth, DuckY, -0.25*TubDepth>;
#declare P3 = < (RoomWidth-TubWidth)+0.25*TubWidth, DuckY, -0.25*TubDepth>;
#declare P4 = < (RoomWidth-TubWidth)+0.25*TubWidth, DuckY, -0.75*TubDepth>;
#declare P5 = < (RoomWidth-TubWidth)+0.50*TubWidth, DuckY, -0.75*TubDepth>;
#declare P6 = < (RoomWidth-TubWidth)+0.75*TubWidth, DuckY, -0.75*TubDepth>;
#declare DuckySpline =
spline {
  natural_spline

 -01, P2, // control point

  00, P1, // start
  01, P6,
  02, P5,
  03, P4,
  04, P3,
  05, P2,
  06, P1, // end 1st round
  07, P6,
  08, P5,
  09, P4,
  10, P3,
  11, P2,
  12, P1, // end 2nd round  

  13, P6 // control point
}
