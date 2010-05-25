#declare Deckel_Pos = array[10][22] {
        {   0, 45, 45, 45, 45, 45, 45, 90, 90, 90, 90, 90, 90, 90, 90,135,135,135,135,135,135,180 }, //Deckelposition
        {   0,  0, 60,120,180,240,300,  0, 45, 90,135,180,225,270,315,  0, 60,120,180,240,300,  0 }, //Deckelposition
        {   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0 }, //Deckelposition
        {  50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50 }, //Deckel Aufahrhöhe
        //{  45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45 }
        {   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0 },

        {   1,  0,  1,  0,  1,  0,  1,  0,  1,  0,  1,  0,  1,  0,  1,  0,  1,  0,  1,  0,  1,  0 }, //Nummerierung
        {   0,  1,  1,  0,  0,  1,  1,  0,  0,  1,  1,  0,  0,  1,  1,  0,  0,  1,  1,  0,  0,  1 }, //Nummerierung
        {   0,  0,  0,  1,  1,  1,  1,  0,  0,  0,  0,  1,  1,  1,  1,  0,  0,  0,  0,  1,  1,  1 }, //Nummerierung
        {   0,  0,  0,  0,  0,  0,  0,  1,  1,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0,  0,  0,  0 }, //Nummerierung
        {   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  1,  1,  1,  1,  1,  1 }  //Nummerierung
}

//#declare Rotor_Pos = array[3] { 0, 0, 0 } //Blatt Anstellwinkel, Klapp Winkel, Ausfahrhöhe

#declare Kupfer = texture { T_Copper_3B } //pigment { Copper }
#declare Silber = texture { T_Silver_5E }



// ?
#declare KuZeX = 0;
#declare KuZeY = 0;
#declare KuZeZ = 0;

#declare Einfahren01 = 3.00;
#declare Einfahren02 = 3.00;
#declare Einfahren03 = 3.00;
#declare Einfahren04 = 3.00;
#declare Einfahren05 = 3.00;
#declare Einfahren06 = 3.00;
#declare Einfahren07 = 3.00;
#declare Einfahren08 = 3.00;
#declare Einfahren09 = 3.00; 
#declare Einfahren10 = 3.00;
#declare Einfahren11 = 3.00;
#declare Einfahren12 = 3.00;
#declare Einfahren13 = 3.00;
#declare Einfahren14 = 3.00;
#declare Einfahren15 = 3.00;
#declare Einfahren16 = 3.00;
#declare Einfahren17 = 3.00;
#declare Einfahren18 = 3.00;
#declare Einfahren19 = 3.00;
#declare Einfahren20 = 3.00;
#declare Einfahren21 = 3.00;
#declare Einfahren22 = 3.00;

#declare Kamera_pos = 1;
#declare Deckeloeffnen = array[22] { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1 }
#declare Deckelgroesse_neu = 0;
#declare Trochanter = 40;// lÃ¤nge" + vbNewLine
#declare Femur = -2;// lÃ¤nge" + vbNewLine
#declare Patella = 0;//winkel" + vbNewLine
#declare Rotor_Pos = array[3] { 2, 1, 1 }
