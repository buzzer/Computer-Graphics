#declare Rotorachse = difference {
        union {
                cylinder { < 0, -90, 0 >, < 0, -88, 0 >, 14 pigment { Silver } }
                cylinder { < 0, -88, 0 >, < 0, -78, 0 >, 3 pigment { Silver } }
                cylinder { < 0, -78, 0 >, < 0, -77, 0 >, 10 pigment { Silver } }
                cylinder { < 0, -76 + Rotor_Pos[0], 0 >, < 0, -77 + Rotor_Pos[0], 0 >, 10 pigment { Silver } } // obere Scheibe der Rotorachse
                cylinder { < 0, -76 + Rotor_Pos[0], 0 >, < 0, -77, 0 >, 3 pigment { Silver } } // Verlängernung der Rotoeachse
        }
        box { < -10, -79, -10 >, < 10, -72, -9.45 > pigment { Silver } }
        box { < -10, -79, -10 >, < 10, -72, -9.45 > pigment { Silver } rotate < 0, 90, 0 > }
        box { < -10, -79, -10 >, < 10, -72, -9.45 > pigment { Silver } rotate < 0, 180, 0 > }
        box { < -10, -79, -10 >, < 10, -72, -9.45 > pigment { Silver } rotate < 0, 270, 0 > }
}
//object { Rotorachse translate < 0, 0, 0 > scale 0.1 }

#declare Rotorblatt = union {
        box { < -0.1, 0, -3 >, < 0.1, -75, 3 > pigment { Silver } rotate < 0, 0, 0 >}
        cylinder { < -0.1, -75, 0 >, < 0.1, -75, 0 >, 3 pigment { Silver } rotate < 0, 0, 0 >}
}
//object { Rotorblatt scale 0.1 translate < 0, 5, 2 > }
    
#declare Rotorblatt = object { Rotorblatt rotate < 0, ((-90/6)*Rotor_Pos[0]) , 180 - (90 * Rotor_Pos[1]) > translate < 9.45, 13 + (Rotor_Pos[0]/2), 0 > } 
#declare Rotor = union {
        object { Rotorachse translate < 0, 90, 0 > }
        object { Rotorblatt rotate < 0, 0, 0 > }
        object { Rotorblatt rotate < 0, 90, 0 > }
        object { Rotorblatt rotate < 0, 180, 0 > }
        object { Rotorblatt rotate < 0, 270, 0 > }
        translate < 0, -48 + (90 * Rotor_Pos[2]), 0 >
}
//object { Rotor scale 0.3 }
