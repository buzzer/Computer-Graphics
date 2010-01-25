#declare BathCamera =
camera {
//	perspective
	// Fliege v. vorne links nach hinten rechts 
//	location <RoomWidth*(1/3+clock*2/3-clock*0.03), 12-6*clock, -RoomDepth*(0.97-clock*0.94)>
	location < RoomWidth*1/4, 4/5*RoomHeight, -RoomDepth*0.97> // Links Vorne
//	location <RoomWidth*0.97, RoomHeight*1/3, -RoomDepth*0.03> // Rechts hinten Ecke 
//	location <1, RoomHeight*2/3, -0.1> // Links hinten
//	location <30, 30,30>
//	angle 80+60*clock
//	angle 40
//	look_at <1/3*RoomWidth,RoomHeight*1/2, 0> // Links hinten
//	look_at <1/3*RoomWidth, 1/2*RoomHeight, -RoomDepth> // Links vorne
//	look_at <RoomWidth, 1/2*RoomHeight, -RoomDepth> // Rechts vorne
//	look_at <DuckX, DuckY, DuckZ> // Always look at Ducky
	look_at (TubFillerPos-y*WaterDefault) + y*DuckY
//	look_at < RoomWidth, RoomHeight*1/3, -RoomDepth*1/3> // Rechts hinten
//	look_at < RoomWidth*5/6, RoomHeight*1/2, -RoomDepth*1/3> // Wanne vorne links
//	look_at <15, 20, 0>
//	rotate y*360*clock
}