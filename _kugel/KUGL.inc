// **************************************************
// *                                                *
// *                     KUGL                       *
// *                                                *
// **************************************************

#declare Kamera = union { difference { cylinder { < 0, 0, 0 >, < 0, 20, 0 >, 12 pigment { Silver } texture { T_Copper_3B } } 
                                       cylinder { < 0, 0, 0 >, < 0, 21, 0 >, 11.5 pigment { Silver } texture { T_Copper_3B } }  
                                       } 
                          cylinder { < 0, 1, 0 >, < 0, 2, 0 >, 11.5 pigment { Silver } texture { Silber } }  
                          difference { sphere { < 0, 0, 0 >, 20 finish { F_Glass5 } }
                                       difference { cylinder { < 0, -21, 0 >, < 0, 21, 0 >, 22 pigment { Silver } texture { T_Copper_3B } } 
                                                    cylinder { < 0, 15, 0 >, < 0, 22, 0 >, 11.5 pigment { Silver } texture { T_Copper_3B } }  
                                                    } 
                                       translate < 0, 2, 0 >
                                       }
                          translate < 0, -41 + (20 * Kamera_pos), 0 >
                          }


# declare Hoehe_der_Dichtung = -0.5;
//light_source {< 0, 10, 0> rgb <1.0, 1.0, 1.0 >*150}

// Produziert einen Locher für die Hülle der KUGL
#declare Locher = union {
        cylinder { < 0, 0, 0 >, < 0, 51, 0 >, 12.5 pigment { Silver } }
        cylinder { < 0, 0, 0 >, < 0, 51, 0 >, 12.5 pigment { Silver } rotate < 180, 0, 0 > }
        #declare Drehen = 0;
        #while (Drehen < 360)
                cylinder { < 0, 0, 0 >, < 0, 51, 0 >, 12.5 pigment { Silver } rotate < Drehen, 0, 90 > }
                #declare Drehen = Drehen + 45;
        #end
        #declare Drehen = 0;
        #while (Drehen < 360)
                cylinder { < 0, 0, 0 >, < 0, 51, 0 >, 12.5 pigment { Silver } rotate < 45, Drehen, 0 > }
                cylinder { < 0, 0, 0 >, < 0, 51, 0 >, 12.5 pigment { Silver } rotate < 135, Drehen, 0 > }
                #declare Drehen = Drehen + 60;
        #end
}
//object { Locher scale 0.06 }

// Innenröhren
#declare Roehren = union {
        difference {
                sphere { < 0, 0, 0 >, 50 pigment { Silver } texture { Silber } } //finish { F_MetalE } }
//                sphere { < 0, 0, 0 >, 47 pigment { Red } }
                object { Locher }
        }

}

// Produziert die Hülle der KUGL
#declare Huelle = union {       
        difference {
                sphere { < 0, 0, 0 >, 50 pigment { Silver } texture { Silber } } //finish { F_MetalE } }
                sphere { < 0, 0, 0 >, 47 pigment { Red } }
                object { Locher }
        }
}
//object { Huelle scale 0.20 }


// Der Rand des Deckels 
#declare Rand = difference {
        difference {
                sphere { < 0, 0, 0 >, 50 + Hoehe_der_Dichtung pigment { Black } }
                sphere { < 0, 0, 0 >, 47 pigment { Red } }
                difference {
                        sphere { < 0, 0, 0 >, 51 pigment { Black } }
                        cylinder { < 0, 0, 0 >, < 0, 51, 0 >, 12.5 pigment { Black } }
                }
                //object { Zentrum }
        } //translate < 0.00, -3.00, 0.00 > 
}
//object { Rand scale 0.20 }

// Das innere des Deckels
#declare Zentrum = difference {
        sphere { < 0, 0, 0 >, 50 pigment { Silver }  texture { Silber } }
        sphere { < 0, 0, 0 >, 47 pigment { Red } }
        difference {
                sphere { < 0, 0, 0 >, 51 pigment { Silver }  texture { Silber } }
                cylinder { < 0, 0, 0 >, < 0, 51, 0 >, 11.5 pigment { Silver } }
        }
}
//object { Zentrum scale 0.20 }

// Der Deckel
#declare VorVorDeckel = difference { 
        union {
                object { Rand translate < 0, 0, 0 >}
                object { Zentrum translate < 0, 0, 0 >}
        }
        sphere { < 0, 52.8, 0 >, 3 rotate < 8, 0, 0 > pigment { Silver }  texture { Silber } }
        sphere { < 0, 52.8, 0 >, 3 rotate < 8, 60, 0 > pigment { Silver }  texture { Silber } }
        sphere { < 0, 52.8, 0 >, 3 rotate < 8, 120, 0 > pigment { Silver }  texture { Silber } }
        //sphere { < 0, 52.8, 0 >, 3 rotate < 8, 180, 0 > pigment { Silver } }
        sphere { < 0, 52.8, 0 >, 3 rotate < 8, 240, 0 > pigment { Silver }  texture { Silber } }
        sphere { < 0, 52.8, 0 >, 3 rotate < 8, 300, 0 > pigment { Silver }  texture { Silber } }
}
//#declare Deckel = object { VorDeckel translate < 0, -50, 0 > }
//object { Deckel scale 0.20 }

// Die vollständige Kugel
#declare KUGL = union {
        object { Huelle }
        #declare Deckel_setzen = 0;
        #while ( Deckel_setzen < 22)
                #declare VorDeckel = difference {
                        union {
                                object { VorVorDeckel }
                                #if (Deckel_Pos[5][Deckel_setzen] = 1)
                                        sphere { < 0, 47, 0 >, 3 rotate < 8, 240, 0 > pigment { Copper } texture { T_Copper_3B } }
                                #end
                                #if (Deckel_Pos[6][Deckel_setzen] = 1)
                                        sphere { < 0, 47, 0 >, 3 rotate < 8, 300, 0 > pigment { Copper } texture { T_Copper_3B } }
                                #end
                                #if (Deckel_Pos[7][Deckel_setzen] = 1)
                                        sphere { < 0, 47, 0 >, 3 rotate < 8, 0, 0 > pigment { Copper } texture { T_Copper_3B } }
                                #end
                                #if (Deckel_Pos[8][Deckel_setzen] = 1)
                                        sphere { < 0, 47, 0 >, 3 rotate < 8, 60, 0 > pigment { Copper } texture { T_Copper_3B } }
                                #end
                                #if (Deckel_Pos[9][Deckel_setzen] = 1)
                                        sphere { < 0, 47, 0 >, 3 rotate < 8, 120, 0 > pigment { Copper } texture { T_Copper_3B } }
                                #end
                        }
                        sphere { < 0, 0, 0 >, 46.99 pigment { Red } }        
                }

                #if (Deckeloeffnen[Deckel_setzen] = 1)
                        #declare Deckelgroesse = Deckelgroesse_neu;
                        #if (Deckel_setzen != 0)
                                object { Kamera translate < 0, Deckel_Pos[3][Deckel_setzen], 0 > rotate < Deckel_Pos[0][Deckel_setzen], Deckel_Pos[1][Deckel_setzen], Deckel_Pos[2][Deckel_setzen] + Deckel_Pos[4][Deckel_setzen] > } 
                        #end
                #else
                        #declare Deckelgroesse = 1;
                #end
                
                #declare Deckel = object { VorDeckel  translate < 0, -50, 0 > scale Deckelgroesse }
                
                #if (Deckel_setzen = 16)
                        #declare Teller1 = object { VorDeckel  translate < 0, -50, 0 > }
                #end
                #if (Deckel_setzen = 18)
                        #declare Teller2 = object { VorDeckel  translate < 0, -50, 0 > }
                #end
                #if (Deckel_setzen = 20)
                        #declare Teller3 = object { VorDeckel  translate < 0, -50, 0 > }
                #end

                #if (Deckelgroesse != 0)                                                         
                        object { Deckel translate < 0, Deckel_Pos[3][Deckel_setzen], 0 > rotate < Deckel_Pos[0][Deckel_setzen], Deckel_Pos[1][Deckel_setzen], Deckel_Pos[2][Deckel_setzen] + Deckel_Pos[4][Deckel_setzen] > }
                #end
                                
                #declare Deckel_setzen = Deckel_setzen + 1;
        #end
}

#declare Landebein1 = union {                   
                                cylinder { < 0, 0, 0 >, < 0, Trochanter, 0 >, 10 pigment { Silver } texture { T_Copper_3B } }
                                sphere { < 0, Trochanter, 0 >, 10 pigment { Silver } texture { T_Copper_3B } }
                                union {
                                        cylinder { < 0, 0, 0 >, < 0, Femur, 0 >, 10 pigment { Silver } texture { T_Copper_3B } }
                                        object { Teller1 translate < 0, Femur + 1, 0 > }
                                        rotate < Patella, 0, 0 > translate < 0, Trochanter, 0 >
                                      }  
                           }    
#declare Landebein2 = union {                   
                                cylinder { < 0, 0, 0 >, < 0, Trochanter, 0 >, 10 pigment { Silver } texture { T_Copper_3B } }
                                sphere { < 0, Trochanter, 0 >, 10 pigment { Silver } texture { T_Copper_3B } }
                                union {
                                        cylinder { < 0, 0, 0 >, < 0, Femur, 0 >, 10 pigment { Silver } texture { T_Copper_3B } }
                                        object { Teller2 translate < 0, Femur + 1, 0 > }
                                        rotate < Patella, 0, 0 > translate < 0, Trochanter, 0 >
                                      }  
                           }
#declare Landebein3 = union {                   
                                cylinder { < 0, 0, 0 >, < 0, Trochanter, 0 >, 10 pigment { Silver } texture { T_Copper_3B } }
                                sphere { < 0, Trochanter, 0 >, 10 pigment { Silver } texture { T_Copper_3B } }
                                union {
                                        cylinder { < 0, 0, 0 >, < 0, Femur, 0 >, 10 pigment { Silver } texture { T_Copper_3B } }
                                        object { Teller3 translate < 0, Femur + 1, 0 > }
                                        rotate < Patella, 0, 0 > translate < 0, Trochanter, 0 >
                                        }  
                           }
                       
                                
#declare KUGL = union { object { KUGL }
                        object { Landebein1 rotate < 135 , 000, 0 > }
                        object { Landebein2 rotate < 135 , 120, 0 > }
                        object { Landebein3 rotate < 135 , 240, 0 > }
                        object { Roehren }
                        }

          