// *********************************************************
// Rune's Particle System v1.01 for POV-Ray 3.5
// *********************************************************
// 
// Copyright (C) 2002 Rune S. Johansen
// http://runevision.com
// 
// See "particle.html" for more information.
// 
// *********************************************************

/*
Rune's Particle System v1.01 for POV-Ray 3.5
Copyright (C) 2002 Rune S. Johansen

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/
   
   // Macros returning random numbers.
   #macro Hash1(t1)
      #local p1=sin(t1);
      #local pf=cos(1e7*(p1));
      abs(1e4*pf-int(1e4*pf))
   #end
   
   #macro Hash2(t1,t2)
      #local p1=sin(t1);
      #local p2=cos(t2*2.2361);
      #local pf=cos(1e7*(p1+p2));
      abs(1e4*pf-int(1e4*pf))
   #end
   
   #macro Hash3(t1,t2,t3)
      #local p1=sin(t1);
      #local p2=cos(t2*2.2361);
      #local p3=sin(t3*1.8708+1);
      #local pf=cos(1e7*(p1+p2+p3));
      abs(1e4*pf-int(1e4*pf))
   #end
   
   // Functions returning random numbers (has bugs)
   // #declare Hash1 = function(x) {abs(mod(1e4*cos(1e7*(sin(x))),1))}
   // #declare Hash2 = function(x,y) {abs(mod(1e4*cos(1e7*(sin(x)+cos(y*2.2361))),1))}
   // #declare Hash3 = function(x,y,z) {abs(mod(cos(1e7*(sin(x)+cos(y*2.2361)+sin(z*1.8708+1))),1))}
   
   // Macro for returning random vector
   #macro Hash3p (A,B,C)
      #local D = A;
      #local Vector = 2*x;
      #while (vlength(Vector)>1)
         #local Vector = <Hash3(D,B,C),Hash3(D,B,C+1),Hash3(D,B,C+2)>*2-<1,1,1>;
         #local D = D+1;
      #end
      Vector
   #end
   
   // A few macros copied from math.inc - pasted here for faster performance.
   
   #macro VRotationD(V1, V2, Axis)
      (degrees(acos(min(vdot(vnormalize(V1),vnormalize(V2)),1)))
      *(vdot(Axis,vcross(V1,V2))<0?-1:1))
   #end
   
   // Returns a vector perpendicular to V
   // Author: Tor Olav Kristensen
   #macro VPerp_To_Vector(v0)
      #if (vlength(v0) = 0)
         #local vN = <0, 0, 0>;
      #else
         #local Dm = min(abs(v0.x), abs(v0.y), abs(v0.z));
         #if (abs(v0.z) = Dm)
            #local vN = vnormalize(vcross(v0, z));
         #else
            #if (abs(v0.y) = Dm)
               #local vN = vnormalize(vcross(v0, y));
            #else
               #local vN = vnormalize(vcross(v0, x));
            #end
         #end
      #end
      vN
   #end
   
   #macro particle_system (_name)
      
      #debug concat("\nParticle system \"",_name,"\" is called.\n")
      
      #ifndef (particle_start)       #declare particle_start       = 0.0; #end
      #ifndef (particle_end)         #declare particle_end         = 1.0; #end
      
      #if ( clock>=particle_start & clock<=particle_end )
         
         #ifndef (particle_cyclic)      #declare particle_cyclic      = off; #end
         #ifndef (particle_steps)       #declare particle_steps       = 100; #end
         
         #ifndef (particle_frequency)   #declare particle_frequency   = 100; #end
         #ifndef (particle_life)        #declare particle_life        = 1.0; #end
         #ifndef (particle_lifeturb)    #declare particle_lifeturb    = 0.0; #end
         #ifndef (particle_seed)        #declare particle_seed        = 123; #end
         
         #local _maxlife = particle_life*(1+particle_lifeturb);
         #ifndef (particle_maxnumber)
            #declare _max = ceil(_maxlife*particle_frequency+1);
         #else
            #declare _max = ceil(particle_maxnumber);
         #end
         
         #ifndef (particle_drag)        #declare particle_drag        = 0.0; #end
         #ifndef (particle_transfer)    #declare particle_transfer    = 0.0; #end
         
         #ifndef (particle_gravity)  #macro particle_gravity  (Clock,Point) <0,0,0> #end #end
         #ifndef (particle_wind)     #macro particle_wind     (Clock,Point) <0,0,0> #end #end
         
         #ifndef (particle_emitter)  #macro particle_emitter  (Clock) <0,0,0> #end #end
         #ifndef (particle_emitting) #macro particle_emitting (Clock) on      #end #end
         #ifndef (particle_emitvect) #macro particle_emitvect (Clock) <0,0,0> #end #end
         #ifndef (particle_emitturb) #macro particle_emitturb (Clock) 1.0     #end #end
         #ifndef (particle_emitobjn) #macro particle_emitobjn (Clock) 0.0     #end #end
         
         #ifndef (particle_bounce)       #declare particle_bounce       = 0.5; #end
         #ifndef (particle_bounceturb)   #declare particle_bounceturb   = 0.5; #end
         #ifndef (particle_friction)     #declare particle_friction     = 0.0; #end
         #ifndef (particle_bounceoffset) #declare particle_bounceoffset = 0.01;#end
         
         #ifndef (particle_element) #debug " - No particle_element macro is defined.\n" #end
         
         #local _timespan = particle_end-particle_start;
         #if ( clock=initial_clock | (clock-particle_start)<clock_delta | clock_on=false )
            
            #if (particle_cyclic=on)
               
               #local _historyloops = int(
                  -(clock-_maxlife-particle_start) / _timespan
               );
               
               #declare _curbackloop = _historyloops+1;
               #local _historystart = (
                  +particle_end
                  +mod(clock-_maxlife-particle_start,_timespan)
               );
               _particle_calculate (_name,_historystart,particle_end,true,no)
               
               #local C = _historyloops;
               #while (C>0)
                  #declare _curbackloop = C;
                  _particle_calculate (_name,particle_start,particle_end,false,no)
                  #local C = C-1;
               #end
               
               #declare _curbackloop = 0;
               #local _historystart = max(particle_start,clock-_maxlife);
               _particle_calculate (_name,_historystart,clock,false,yes)
               
            #else
               #declare _curbackloop = 0;
               #local _historystart = max(particle_start,clock-_maxlife);
               _particle_calculate (_name,_historystart,clock,true,yes)
            #end
            
         #else
            
            #declare _curbackloop = 0;
            _particle_calculate (_name,clock-clock_delta,clock,false,yes)
            
         #end
         
         #debug concat(" - Particle system finished.\n")
         
      #else
         #debug concat(" - Particle system is inactive at the current clock value.\n")
      #end
      
   #end
   
   #macro _particle_calculate (_name,_start,_end,_reset,_createparticles)
      
      #if ( _reset=true | file_exists(concat(_name,".data"))=false )
         #declare Olocation = array[_max]
         #declare Clocation = array[_max]
         #declare Birth     = array[_max]
         #declare Life      = array[_max]
         #declare Id        = array[_max]
         #local C=0;#while(C<_max)#declare Olocation[C]=<0,0,0>;#local C=C+1;#end
         #local C=0;#while(C<_max)#declare Clocation[C]=<0,0,0>;#local C=C+1;#end
         #local C=0;#while(C<_max)#declare Birth[C]    =   0;   #local C=C+1;#end
         #local C=0;#while(C<_max)#declare Life[C]     =  -1;   #local C=C+1;#end
         #local C=0;#while(C<_max)#declare Id[C]       =   0;   #local C=C+1;#end
      #else
         #include concat(_name,".data")
         #declare _max = dimension_size(Life,1);
      #end
      
      #local Nlocation = array[_max]
//    Integer value for the current calculation step:
      #local S = ceil(_start*particle_steps-0.000001);
//    clock value for the previous calculation step (lower than actual clock):
      #local _oldclock = (S-1)/particle_steps;
//    clock value for the current calculation step (higher than actual clock):
      #local _clock    = (S+0)/particle_steps;
//    value being 0 if clock=_oldclock and 1 if clock=_clock:
      #local _reltime = (clock-_oldclock)/(_clock-_oldclock);
      
//    Particle number for _oldclock
      #local N    = ceil(_oldclock*particle_frequency);
//    Particle number for _clock
      #local Nnew = ceil(_clock   *particle_frequency);
      
      #while (S<ceil(_end*particle_steps-0.000001))
         
         #local S = S+1;
         #local _oldclock = (S-1)/particle_steps;
         #local _clock    = (S+0)/particle_steps;
         
         //#local _reltime = (clock-_oldclock)/(_clock-_oldclock);
         
         #local C = 0;
         
         #local N    = ceil((S-1)/particle_steps*particle_frequency);
         #local Nnew = ceil((S+0)/particle_steps*particle_frequency);
         
//       Loop through particle array
         #while (C<_max)
            
//          Update particle
            #if (Life[C]>0)
               _particle_update(C)
            #end
            
//          Initialize new particle
            #local Nclock = N/particle_frequency;
            #if ( (Life[C]=-1) & (N<Nnew) & ((particle_emitting(Nclock))>0) )
               _particle_init(C)
               #local N = N+1;
            #end
            
            #local C = C+1;
         #end
         
      #end
      
      #local _reltime = (clock-_oldclock)/(_clock-_oldclock);
      
      _particle_save()
      
      #declare _arraysize = _max;
      #if (_createparticles=true)
         _particle_create()
      #end
      
   #end
   
   
   #macro _particle_init(_nr)
      
      #local Ntime = 1-(_clock-Nclock)*particle_steps;
      #declare __Dir = (
         +particle_emitturb(Nclock)*Hash3p(1,S,N)/particle_steps
         +particle_emitvect(Nclock)/particle_steps
         +particle_transfer*((particle_emitter(Nclock))-(particle_emitter(Nclock-1/particle_steps)))
      );
      #declare __Loc = (particle_emitter(Nclock));
      #ifdef(particle_emitobj)
         #declare Try = 1;
         #declare Flag = off;
         #declare __Obj = particle_emitobj(Nclock);
         #declare __ObjMin = min_extent(__Obj);
         #declare __ObjMax = max_extent(__Obj);
         #declare _objectn = <0,0,0>;
         #while (Try<1000&Flag=off)
            #declare __P_ = (__ObjMax-__ObjMin)*<Hash3(Try,N,1),Hash3(Try,N,2),Hash3(Try,N,3)>+__ObjMin;
            //#debug concat("\nPLOC: <",vstr(3,__P_,",",8,3),"> TRY: ",str(Try,1,0))
            #declare __Loc_ =
            trace (
               __Obj,
               __P_,
               Hash3p(Try,N,4),
               _objectn
            );
            #if (vlength(_objectn)>0&inside(__Obj,__P_))
               #declare __P_ = __Loc_;
               #declare __Dir = __Dir + particle_emitobjn(Nclock)*_objectn/particle_steps;
               #declare Flag = on;
            #end
            #declare Try = Try+1;
         #end
         #if (Try=1000) #debug " - Failed to place particle inside emitter object.\n" #end
         #declare __Loc = __Loc+__P_;
      #end
      #declare Olocation[_nr] = (__Loc-__Dir*(0+Ntime));
      #declare Clocation[_nr] = (__Loc+__Dir*(1-Ntime));
      
      #declare Id[_nr] = N-int(2+particle_start*particle_frequency);
      #declare Birth[_nr] = Nclock-_curbackloop*_timespan;
      #declare Life[_nr]  = particle_life*(1+particle_lifeturb*(Hash1(Id[_nr])*2-1));
      
   #end
   
   
   #macro _particle_update(_nr)
      
      #if (Birth[_nr]+_curbackloop*_timespan+Life[_nr]<=_clock)
         #declare Life[_nr] = -1;
      #else
         
         #local _change = (Clocation[_nr]-Olocation[_nr]);
         #local _velocity = _change*particle_steps;
         #if ( particle_drag=0 )
            #local _wind = <0,0,0>;
         #else
            #local _windeffect = (particle_wind(_clock,Clocation[_nr]))-_velocity;
            #if ( vlength(_windeffect)=0 )
               #local _wind = <0,0,0>;
            #else
               #local _wind = (
                  vnormalize(_windeffect)
                  * particle_drag
                  * pow(vlength(_windeffect),2)
                  * pow(1/particle_steps,2)
               );
               #if (vlength(_wind)>vlength(_windeffect))
                  #local _wind = _windeffect;
               #end
            #end
         #end
         
         #declare Nlocation[_nr] = (
            Clocation[_nr]
//          Add inertia
            +_change
//          Add wind
            +_wind
//          Add gravity
            +(particle_gravity(_clock,Clocation[_nr]))*pow(1/particle_steps,2)
         );
         
         #ifdef(particle_blockobj)
            #local _test = -1;
            #local _flag = on;
            #ifdef (_tracestart) #undef _tracestart #end
            #while ( _test<100 & _flag=on )
               #local _flag = off;
               _particle_collision()
               #local _test = _test+1;
            #end
            #if (_test>9)
               #debug concat(" - Collision loop: ",str(_test,3,0),"\n")
            #end
            #local p_id = Id[_nr];
         #end
         
         #declare Olocation[_nr] = Clocation[_nr];
         #declare Clocation[_nr] = Nlocation[_nr];
         
         #ifdef(particle_killobj)
            #if (inside(particle_killobj(_clock),Clocation[_nr]))
               #declare Life[_nr] = -1;
            #end
         #end
         
      #end
      
   #end
   
   
   #macro _particle_collision()
      
      
      #local _objectn = <0,0,0>;
      #ifndef (_tracestart) #declare _tracestart = Clocation[_nr]; #end
      #declare _Nlocation = Nlocation[_nr];
      #declare _Clocation = Clocation[_nr];
      
      #ifdef(particle_blocktrans)
         #declare _tracestartclock = _oldclock+(_clock-_oldclock)*(vlength(_tracestart-_Clocation)/vlength(_Nlocation-_Clocation));
         #declare _tracestart = vinv_transform(_tracestart,particle_blocktrans(_tracestartclock));
         #declare _Nlocation  = vinv_transform(_Nlocation, particle_blocktrans(_clock)   );
         #declare _Clocation  = vinv_transform(_Clocation, particle_blocktrans(_oldclock));
      #end
      
      #local _change = _Nlocation-_Clocation;
      #local _objectp = trace (
         particle_blockobj,
         _tracestart-_change*0.0001,
         _change,
         _objectn
      );
       
      #if (vlength(_objectn)>0)
      #if (
         vlength(_objectp-_Clocation) < vlength(_change)
         &
         vdot(_objectn,_change)<=0
      )
         
         /*
         // Code for support for a moving particle_blockobj - NOT READY FOR IMPLEMENTATION!
         #ifdef(particle_envtrans)
            #declare _intersectionclock = _oldclock+(_clock-_oldclock)*vlength(_objectp-_Clocation)/vlength(_change);
            #declare _objectp_ = _objectp;
            #declare _objectp  = vtransform(_objectp,particle_blocktrans(_intersectionclock));
            #declare _objectn  = vnormalize(vtransform(_objectn+_objectp_,particle_blocktrans(_intersectionclock))-_objectp);
            #declare _Nlocation = vtransform(_Nlocation,particle_blocktrans(_intersectionclock));
            #declare _Clocation = vtransform(_Clocation,particle_blocktrans(_intersectionclock));
            #local _change = _Nlocation-_Clocation;
         #end*/
         
         #declare _flag = on;
         #local _offset = _objectn*particle_bounceoffset;
         #declare _tracestart = _objectp+_offset;
         
         #if (vlength(vcross(_change,_objectn))=0)
            #local _bouncevector = -_change*particle_bounce;
            #local _about = VPerp_To_Vector(_objectn);
         #else
            #local _bouncevector = vaxis_rotate(-_change,_objectn,180);
            #local _about = vnormalize(vcross(_change,_objectn)); // perpendicular to bounce-plane
         #end
         #local _turbangle = 90-VRotationD(_bouncevector,_objectn,<0,0,0>);
         
         // apply turbulence to the bounce
         #local _direction =
         vaxis_rotate(
            _bouncevector,
            _about,
            _turbangle*Hash3(3,S,Id[_nr])*particle_bounceturb
         );
         #local _direction = vaxis_rotate(_direction,_bouncevector,360*Hash3(4,S,Id[_nr]));
         
         // calculate movement tangental to surface and perpendicular to surface
         #local _direction_p = vdot(_direction,_objectn)/vdot(_objectn,_objectn)*_objectn;
         #local _direction_t = _direction-_direction_p;
         #local _direction = (
            + _direction_p * particle_bounce
            + _direction_t * (1-(1-particle_bounce)*particle_friction)
         );
         
         // set the new vectors
         #local _ratio = vlength(_Clocation-_objectp)/vlength(_Clocation-_Nlocation);
         #local _cvector = -_direction*   _ratio ;
         #local _nvector = +_direction*(1-_ratio);
         #declare Clocation[_nr] = _objectp+_cvector+_offset;
         #declare Nlocation[_nr] = _objectp+_nvector+_offset;
         
      #end
      #end
      
   #end
   
   
   #macro _particle_data(C)
      #declare p_id     = Id[C];
      #declare p_random = Hash1(p_id);
      
      #declare p_location  = Clocation[C]*_reltime + Olocation[C]*(1-_reltime);
      #declare p_direction = (Clocation[C]-Olocation[C])*particle_steps;
      
      #declare p_life  = Life[C];
      #declare p_age   = clock-Birth[C];
      #declare p_birth = mod(Birth[C]-particle_start+100*_timespan,_timespan)+particle_start;
      #declare p_state = (p_age/p_life);
      
      #if (vlength(p_direction)>0)
         #if (vlength(p_direction*<1,1,0>)>0)
            #local _rotatez = VRotationD(x,<p_direction.x,p_direction.y,0>,z);
         #else
            #local _rotatez = 0;
         #end
         #local _rotatey = VRotationD(x,vrotate(p_direction,-_rotatez*z),y)+90;
         #declare p_rotate = <0,_rotatey,_rotatez>;
      #else
         #declare p_rotate = <0,0,0>;
      #end
   #end
   
   
   #macro _particle_create()
      
      #local C = 0;
      #local G = 0;
      #while (C<_arraysize)
         #if ( Birth[C]<clock & Birth[C]+Life[C]>clock )
            
            #ifdef(particle_element)
               _particle_data(C)
               particle_element ()
            #end
            
            #local G = G+1;
         #end
         #local C = C+1;
      #end
      
      #debug concat(" - Number of currently active particles: ",str(G,0,0),"\n")
      
   #end
   
   
   #macro load_system (_name)
      #debug concat("\nParticle system \"",_name,"\" is loaded.\n")
      #if (file_exists(concat(_name,".data")))
         #include concat(_name,".data")
         #declare _reltime = (clock-_oldclock)/(_clock-_oldclock);
         #local C = 0;
         #local Cp = 0;
         #local Cm = dimension_size(Life,1);
         #declare _particlepointer = array[Cm]
         #while (C<Cm)
            #if ( Birth[C]<clock & Birth[C]+Life[C]>clock)
               #declare _particlepointer[Cp] = C;
               #declare Cp = Cp+1;
            #end
            #declare C = C+1;
         #end
         #local _number = Cp;
         #debug concat(" - Number of currently active particles: ",str(_number,0,0),"\n")
      #else
         #local _number = 0;
         #debug concat(" - System could not be found.\n")
      #end
      _number
   #end
   
   #macro load_particle (_nr)
      _particle_data(_particlepointer[_nr])
   #end
   
   
   #macro _particle_save()
      #fopen data concat(_name,".data") write
         
         #write (data,"#declare _oldclock = ",_oldclock,";\n")
         #write (data,"#declare _clock = ",_clock,";\n")
         #write (data,"#declare _timespan = ",_timespan,";\n")
         
         #write (data,"#declare Clocation = array[",_max,"] {")
         #local C = 0;
         #while (C<_max)
            #write (data,Clocation[C],",")
            #local C = C+1;
         #end
         #write (data,"}\n")
         
         #write (data,"#declare Olocation = array[",_max,"] {")
         #local C = 0;
         #while (C<_max)
            #write (data,Olocation[C],",")
            #local C = C+1;
         #end
         #write (data,"}\n")
         
         #write (data,"#declare Id = array[",_max,"] {")
         #local C = 0;
         #while (C<_max)
            #write (data,Id[C],",")
            #local C = C+1;
         #end
         #write (data,"}\n")
         
         #write (data,"#declare Birth = array[",_max,"] {")
         #local C = 0;
         #while (C<_max)
            #write (data,Birth[C],",")
            #local C = C+1;
         #end
         #write (data,"}\n")
         
         #write (data,"#declare Life = array[",_max,"] {")
         #local C = 0;
         #while (C<_max)
            #write (data,Life[C],",")
            #local C = C+1;
         #end
         #write (data,"}\n")
         
      #fclose data
   #end
   