#declare NumDuckyPos = 12;
#declare YawAdvance = 0.5;
#declare RollAdvance = 0.2;
#declare ViewAxis = y;
// Inside bath tub
#declare P1 = < (RoomWidth-TubWidth)+0.75*TubWidth, DuckY, -0.25*TubDepth>;
#declare P2 = < (RoomWidth-TubWidth)+0.75*TubWidth, DuckY, -0.75*TubDepth>;
#declare P3 = < (RoomWidth-TubWidth)+0.50*TubWidth, DuckY, -0.75*TubDepth>;
#declare P4 = < (RoomWidth-TubWidth)+0.25*TubWidth, DuckY, -0.75*TubDepth>;
#declare P5 = < (RoomWidth-TubWidth)+0.25*TubWidth, DuckY, -0.25*TubDepth>;
#declare P6 = < (RoomWidth-TubWidth)+0.50*TubWidth, DuckY, -0.25*TubDepth>;
//// Flooded bath
//#declare P7 = < 0.75*RoomWidth, DuckY, -0.25*RoomDepth>;
//#declare P8 = < 0.75*RoomWidth, DuckY, -0.75*RoomDepth>;
//#declare P9 = < 0.50*RoomWidth, DuckY, -0.75*RoomDepth>;
//#declare P10 = < 0.25*RoomWidth, DuckY, -0.75*RoomDepth>;
//#declare P11 = < 0.25*RoomWidth, DuckY, -0.25*RoomDepth>;
//#declare P12 = < 0.50*RoomWidth, DuckY, -0.25*RoomDepth>;

#declare DuckySpline =
spline {
  natural_spline

 -01, P6, // control point

  00, P1, // start
  01, P2,
  02, P3,
  03, P4,
  04, P5,
  05, P6,
  06, P1, // end 1st round

  07, P2 // control point
}
