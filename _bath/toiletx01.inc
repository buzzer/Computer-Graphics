//toiletx01.inc by luisvaloyes - Bogota - Colombia
//www.luisvaloyes.uni.cc | luisvaloyes@malditasea.zzn.com
//a simple, low detailed toilet, useful for architectural scenes


//these are the parts of the toilet, all names are in spanish, some are used (maybe) only in Colombia, 
//and some are used only by me...

//Note:  scale used: 1meter = 10 POV units

#declare ToiletFinish = 
	// finish {phong .7 reflection .085}
	 finish {ambient .2 diffuse .85 phong .7 reflection .085}

#declare bolatronox01 =  difference { sphere {  <0.0,0.0,0.0>,1.0
  scale <2.0000,2.5000,3.2500>  rotate <0.0000,0.0000,0.0000>  translate <0.0000,3.3000,-3.7000>}
box {<-0.5,-0.5,-0.5>  <0.5,0.5,0.5>
  scale <5.0000,4.0000,7.0000>  rotate <0.0000,0.0000,0.0000>  translate <0.0000,5.5000,-3.7500>}}

#declare tapatronox01 = sphere {  <0.0,0.0,0.0>,1.0
  scale <2.0000,0.2500,2.3000>  rotate <0.0000,0.0000,0.0000>  translate <0.0000,4.0000,-4.6000>}

#declare bizcochox01 = torus {  1.0 0.2500
  scale <1.6000,0.8000,2.0000>  rotate <0.0000,0.0000,0.0000>  translate <0.0000,3.7000,-4.5000>}

#declare patax01 = cylinder {  <0.0,-0.5,0.0>,<0.0,0.5,0.0>,1.0
  scale <1.0000,3.2000,2.0000>  rotate <0.0000,0.0000,0.0000>  translate <0.0000,1.8000,-2.4000>}

#declare tapatanque = box {  <-0.5,-0.5,-0.5>  <0.5,0.5,0.5>
  scale <5.0000,0.3000,2.2000>  rotate <0.0000,0.0000,0.0000>  translate <0.0000,6.7000,-1.0000>}

#declare ladotanque2 = box {  <-0.5,-0.5,-0.5>  <0.5,0.5,0.5>
  scale <0.4000,3.0000,1.8000>  rotate <0.0000,0.0000,0.0000>  translate <-2.2000,5.2000,-1.0000>}

#declare ladotanque1 = box {  <-0.5,-0.5,-0.5>  <0.5,0.5,0.5>
  scale <0.4000,3.0000,1.8000>  rotate <0.0000,0.0000,0.0000>  translate <2.2000,5.2000,-1.0000>}

#declare esquitanque4 = cylinder {  <0.0,-0.5,0.0>,<0.0,0.5,0.0>,1.0
  scale <0.2000,3.0000,0.2000>  rotate <0.0000,0.0000,0.0000>  translate <-2.2000,5.2000,-1.8000>}

#declare esquitanque3 = cylinder {  <0.0,-0.5,0.0>,<0.0,0.5,0.0>,1.0
  scale <0.2000,3.0000,0.2000>  rotate <0.0000,0.0000,0.0000>  translate <2.2000,5.2000,-1.8000>}

#declare esquitanque2 = cylinder {  <0.0,-0.5,0.0>,<0.0,0.5,0.0>,1.0
  scale <0.2000,3.0000,0.2000>  rotate <0.0000,0.0000,0.0000>  translate <-2.2000,5.2000,-0.2000>}

#declare esquitanque1 = cylinder {  <0.0,-0.5,0.0>,<0.0,0.5,0.0>,1.0
  scale <0.2000,3.0000,0.2000>  rotate <0.0000,0.0000,0.0000>  translate <2.2000,5.2000,-0.2000>}

#declare tanquex01 = box {  <-0.5,-0.5,-0.5>  <0.5,0.5,0.5>
  scale <4.4000,3.0000,2.0000>  rotate <0.0000,0.0000,0.0000>  translate <0.0000,5.2000,-1.0000>}

#declare topetaza = cylinder {  <0.0,-0.5,0.0>,<0.0,0.5,0.0>,1.0
  scale <2.2500,0.4000,3.4500>  rotate <0.0000,0.0000,0.0000>  translate <0.0000,3.5000,-3.7500>}

#declare basex01 = box {  <-0.5,-0.5,-0.5>  <0.5,0.5,0.5>
  scale <2.4000,0.2000,4.0000>  rotate <0.0000,0.0000,0.0000>  translate <0.0000,0.1000,-3.5000>}

#declare basex03 = cylinder {  <0.0,-0.5,0.0>,<0.0,0.5,0.0>,1.0
  scale <1.2000,2.0000,1.0000>  rotate <0.0000,0.0000,0.0000>  translate <0.0000,1.0000,-5.5000>}

#declare basex02 = cylinder {  <0.0,-0.5,0.0>,<0.0,0.5,0.0>,1.0
  scale <1.2000,0.2000,1.0000>  rotate <0.0000,0.0000,0.0000>  translate <0.0000,0.1000,-1.5000>}

#declare boton01 = union { box {  <-0.5,-0.5,-0.5>  <0.5,0.5,0.5>
  scale <0.5,0.1500,0.2500>  rotate <0.0000,0.0000,0.0000>  translate <-0.2,0,-0.2>}
cylinder {  <0.0,-0.5,0.0>,<0.0,0.5,0.0>,1.0
  scale <0.2000,0.3000,0.2000>  rotate <90.0000,0.0000,0.0000>  translate <0.0000,0.0000,0.0000>}
pigment {rgb <.52,.52,.52>} finish {metallic reflection .025}}


//and this is the toilet...

#declare toiletx01 = union { union{
object {  basex02} object {  basex03} object {  basex01} object {  topetaza} object {  tanquex01}
object {  esquitanque1} object {  esquitanque2} object {  esquitanque3} object {  esquitanque4}
object {  ladotanque1} object {  ladotanque2} object {  tapatanque} object {  patax01}
object {  bizcochox01} object {  tapatronox01} object {  bolatronox01}
pigment {rgb <.9,.9,.9>} finish{ToiletFinish}} object {boton01 translate <-1.75,6.1,-2.2>}}

//if you have any comments or suggestions about this object, you can e-mail me...