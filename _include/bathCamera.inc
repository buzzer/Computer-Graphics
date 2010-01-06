#declare BathCamera =
camera {
	perspective
	// Fliege v. vorne links nach hinten rechts 
	location <RoomWidth*(1/3+clock*2/3-clock*0.03), 12-6*clock, -RoomDepth*(0.97-clock*0.94)>
//	location < RoomWidth*1/3, 12, -RoomDepth> // Vorne links
//	location <RoomWidth*0.97, RoomHeight*2/3, -RoomDepth*0.03> // Ecke hinten rechts
//	location <30, 30,30>
//	right x * 1
//	up y * 3/4
	angle 80+60*clock
//	angle 70
	look_at <DuckX, DuckY, DuckZ> // Always look at Ducky
//	look_at < RoomWidth, RoomHeight*1/3, -RoomDepth*1/3> // Hinten rechts
//	look_at < RoomWidth*5/6, RoomHeight*1/3, -RoomDepth*1/3> // Wanne vorne links
//	look_at <15, 20, 0>
//	rotate y*360*clock
}