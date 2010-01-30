//#include "kamera_standard.inc"
#include "Start_Pos.inc"
#include "KUGL.inc"
#include "Rotor.inc"
#declare flug_rx = 0; //rotate
#declare flug_ry = 0; //rotate
#declare flug_rz = 0; //rotate
#declare flug_px = 0; //translate
#declare flug_py = 0; //translate
#declare flug_pz = 0; //translate
#declare flug = 45; // rotation
//#declare CamKugelRotFreq = 360*40*clock; // Optimal for 20 sec per scene.
#declare CamKugel = union {
	object { KUGL scale 0.05 rotate < flug_rx, flug_ry, flug_rz > translate < flug_px, flug_py, flug_pz > }
	object { Rotor scale 0.05 rotate < flug_rx, CamKugelRotFreq, flug_rz > translate < flug_px, flug_py, flug_pz > }
}
