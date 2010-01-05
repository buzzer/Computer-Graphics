// Box for steam
#declare Steam =
box{<0,0,0>, <RoomWidth, RoomHeight, -RoomDepth>
  pigment{rgbt 1}
  hollow
  interior{ //-----------
    media{
      scattering{
        1,  // scattering media type 1,2,3,4,5
        0.1 // color of the media (no comma!)
        extinction 1.0 //optional 0~1
      }// end of scattering
      intervals 3 //
      density {granite scale 10
        color_map {
          [0.0 rgb <1,1,1>*0.1]
          [0.5 rgb <1,1,1>*0.3]
          [1.0 rgb <1,1,1>*1  ]
        } // end of color_map
      }// end of density
    } // end of media ---
  } // end of interior
  translate <0,1,0>
} //------- end of box