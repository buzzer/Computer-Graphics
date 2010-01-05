#declare BathCamera =
camera {
	perspective 
	location < RoomWidth*1/3, 12, -RoomDepth> // Vorne links
//	location <RoomWidth*0.97, RoomHeight*2/3, -RoomDepth*0.03> // Ecke hinten rechts
//	right x * 1
//	up y * 3/4
	angle 80
//	angle 70
	look_at <DuckX, DuckY, DuckZ> // Always look at Ducky
//	look_at < RoomWidth, RoomHeight*1/3, -RoomDepth*1/3> // Hinten rechts
//	look_at < RoomWidth*5/6, RoomHeight*1/3, -RoomDepth*1/3> // Wanne vorne links
//	rotate y*360*clock
}