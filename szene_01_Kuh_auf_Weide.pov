//Persistence of Vision Ray Tracer Scene Description File

#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "finish.inc"
#include "skies.inc"
#include "woods.inc"

global_settings{
	assumed_gamma 2.2
	//good radiosity settings

}

camera {
        location  <0, 0, -10>
        look_at   <0, 0,  0>
}

light_source {
	< 0.0, 100, 30>*-1
	color White
}

light_source {
	< 5.0, 0, 30>*-1
	color White
}


light_source{
	<0.0,10.0,-2.0>
	color White*1
	spotlight
	point_at <0,0,0.5>
	falloff 180
	radius 100.5
	tightness 0.0
	jitter
	adaptive 4
	photons{
		refraction on
		reflection on
	}
}

// Macro for the adjustment of images
// for image_map with assumed_gamma = 1.0 ;
#macro Correct_Pigment_Gamma(Orig_Pig, New_G)
	#local Correct_Pig_fn =
		function{ pigment {Orig_Pig} }
		pigment{ average pigment_map{
			[function{ 
				pow(Correct_Pig_fn(x,y,z).x, New_G)
			}
			color_map{[0 rgb 0][1 rgb<3,0,0>]}]
   [function{ pow(Correct_Pig_fn(x,y,z).y, New_G)}
               color_map{[0 rgb 0][1 rgb<0,3,0>]}]
   [function{ pow(Correct_Pig_fn(x,y,z).z, New_G)}
               color_map{[0 rgb 0][1 rgb<0,0,3>]}]
   }}
#end //
// "image_map" gamma corrected:
//    Correct_Pigment_Gamma(
//    pigment{ image_map{ jpeg "colors.jpg"}}
//    , Correct_Gamma)
//------------------------------------------------

box{ <-1, -1, -1>,< 1, 1, 1>
 texture{ uv_mapping
   Correct_Pigment_Gamma( // gamma correction
     pigment{
     image_map{ jpeg "cubemap_green.jpeg"
                map_type 0    // planar
                interpolate 2 // bilinear
                once //
              } //  end of image_map
    } // end of pigment
    , 1) //, New_Gamma
    finish { ambient 1 diffuse 0 }
 } // end of texture
scale 1000
} // end of skybox --------------------




plane { y, -1 
	texture {  
		tiles { // Verschachtelung von Texturen 
			texture { 
				pigment { color red 1 green 1 blue 1 } 
				finish { reflection 0.4 } 
			} 
			tile2 
			texture { 
				pigment { color red 0 green 0 blue 0 } 
				finish { reflection 0.4 } 
			}   
		} 
		scale 2.3 // bestimmt die Grš§e der Kacheln 
	} 
} 








#declare Flattern = 45;//sin(clock)*90;


// creates a smooth blobby shape
#declare StrengthVal = 1.0; // (+ or -) strength of component's radiating density
#declare RadiusVal   = 1.0; // (0 < RadiusVal) outer sphere of influence on other components
#declare Wing=blob{
    threshold 0.3
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <2,13,0.2> translate y*13 rotate z*-2 rotate y*1}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,12,0.2> translate y*12 rotate z*-10 rotate y*3}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,11,0.2> translate y*11 rotate z*-16 rotate y*5}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,10,0.2> translate y*10 rotate z*-22 rotate y*7}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,9,0.2> translate y*9 rotate z*-28 rotate y*9}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,8,0.2> translate y*8 rotate z*-34 rotate y*11}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,7,0.2> translate y*7 rotate z*-40 rotate y*13}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,6,0.2> translate y*6 rotate z*-46 rotate y*15}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,5,0.2> translate y*5 rotate z*-54 rotate y*17}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,5,0.2> translate y*5 rotate z*-60 rotate y*15}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,5,0.2> translate y*5 rotate z*-66 rotate y*14}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,5,0.2> translate y*5 rotate z*-72 rotate y*13}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,5,0.2> translate y*5 rotate z*-80 rotate y*12}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,5.2,0.2> translate y*5 rotate z*-86 rotate y*11}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,5.3,0.2> translate y*5 rotate z*-92 rotate y*10}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,5.4,0.1> translate y*5 rotate z*-98 rotate y*9}
    
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,4,0.2> translate y*4.1 rotate z*-105 translate x rotate y*8}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,5,0.2> translate y*4.2 rotate z*-110 translate x rotate y*7}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,5,0.2> translate y*4.3 rotate z*-115 translate x rotate y*6}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,5,0.2> translate y*4.5 rotate z*-120 translate x rotate y*5}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,5,0.2> translate y*5 rotate z*-125 translate x rotate y*4}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,6,0.2> translate y*6 rotate z*-130 translate x rotate y*3}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,7,0.2> translate y*6 rotate z*-135 translate x rotate y*2}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,8.5,0.2> translate y*6 rotate z*-140 translate x rotate y*1}
    sphere { <0, 0, 0>, StrengthVal, RadiusVal scale <1.5,8.5,0.2> translate y*6 rotate z*-145 translate x rotate y*0}
    sturm
}

#declare T_Wing=texture{
     pigment{White}
     normal{bumps 0.1 scale 0.5}
     finish{ambient 0 diffuse 0.8}
}
#declare Wings=union{
    object{Wing scale <1.5,1,-1> translate y*12 rotate x*-Flattern}
    object{Wing scale <1.5,1,1> translate y*12 rotate x*Flattern}
    texture{T_Wing}
    translate y*-4
}

//object{Wings rotate y*90 scale 0.1}

//plane {
//	<0,1,0>, 0.0
//	pigment{
//		image_map{jpeg "texture.jpg"
//		interpolate 2
//		}
//	scale 1	
//	}
//}



light_source{
	<0.0,10.0,-2.0>
	color White*1
	spotlight
	point_at <0,0,0.5>
	falloff 180
	radius 100.5
	tightness 0.0
	jitter
	adaptive 4
	photons{
		refraction on
		reflection on
	}
}




//cow 
#macro cow(Position)
union{

object{Wings rotate z*20 scale 0.7 translate Position-<10,0,0>}

	
box{
	Position-<8,2.5,1.5>,Position+<8,2.5,1.5>
	texture{pigment{color White}}	
}
	union{
		//fleck hinte
		union{
			box{
					Position-<-6,0,-1.6>,Position-<-3,1,1.6>
					texture{pigment{color Black}}
				}	
			box{
					Position-<-5,1,-1.6>,Position-<-2,2,1.6>
					texture{pigment{color Black}}
				}	
			box{
					Position-<-5,-1,-1.6>,Position-<-2,0,1.6>
					texture{pigment{color Black}}
				}	
		}
		//fleck vorne
		union{
			box{
					Position-<6,-2,-1.6>,Position-<3,-1,1.6>
					texture{pigment{color Black}}
				}	
			box{	
					Position-<5,-1,-1.6>,Position-<2,0,1.6>
					texture{pigment{color Black}}
				}
		}
	}
	
	//Euter
	union{
		box{	
			Position-<-7.5,3.5,0.5>,Position-<-3,0,-0.5>
			texture{pigment{color Pink}}
		}
		box{	
			Position-<-7.5,4,0.5>,Position-<-4,0,-0.5>
			texture{pigment{color Pink}}
		}
		box{	
			Position-<-7.5,4.5,0.5>,Position-<-5,0,-0.5>
			texture{pigment{color Pink}}
		}
		box{	
			Position-<-3,3,0.25>,Position-<7,0,-0.25>
			texture{pigment{color White}}
		}
	}

//bein vorne links
box{Position-<7,2.5,1.5>,Position-<6,9.5,0.5>
	texture{pigment{color White}}
	
	translate (Position-<7,2.5,-1.5>)*-1
	translate <-0.5,0,0>
	rotate <0,0,45>	
	translate <0.5,0,0>
	translate Position-<7,2.5,-1.5>
		
}
//bein vorne rechts
box{Position-<7,2.5,-1.5>,Position-<6,9.5,-0.5>
	texture{pigment{color White}}
	
	translate (Position-<7,2.5,-1.5>)*-1
	translate <-0.5,0,0>
	rotate <0,0,45>	
	translate <0.5,0,0>
	translate Position-<7,2.5,-1.5>
	
}
//
//bein hinten links
box{Position-<-7,2.5,1.5>,Position-<-6,9.5,0.5>
	texture{pigment{color White}}
	
	translate (Position-<-7,2.5,-1.5>)*-1
	translate <0.5,0,0>
	rotate <0,0,45>	
	translate <-0.5,0,0>
	translate Position-<-7,2.5,-1.5>

	
	
}
//bein hinten rechts
box{Position-<-7,2.5,-1.5>,Position-<-6,9.5,-0.5>
	texture{pigment{color White}}
	translate (Position-<-7,2.5,-1.5>)*-1
	translate <0.5,0,0>
	rotate <0,0,45>	
	translate <-0.5,0,0>
	translate Position-<-7,2.5,-1.5>
}
//schwanz
box{Position-<-11,-1.5,-0.5>,Position-<-8,-2.5,0.5>
	texture{pigment{color White}}
	
	
	//inser pixelate
	translate (Position-<-8,-2.5,0.5>)*-1
	//translate <0.5,0,0>
	rotate <0,0,-45>
	translate Position-<-8,-2.5,0.5>
}
//hals
box{Position-<+10,0.5,-0.5>,Position-<+8,-2.5,0.5>
		texture{pigment{color White}}
}
union{
//kopf
	box{Position-<+11,1.5,1.5>,Position-<+10,-3.5,-1.5>
			texture{pigment{color White}}
	}
	
	//Zunge JUNGE
	box{Position-<+10.5,2.0,0.5>,Position-<+11.2,1.0,-0.5>
			texture{pigment{color Black}}
	}
	
	//Auge
	box{Position-<+11.0,-2.5,1.5>,Position-<+11.1,-2.0,0.5>
			texture{pigment{color Black}}
			no_shadow
	}
	box{Position-<+11.0,-2.5,-1.5>,Position-<+11.1,-2.0,-0.5>
			texture{pigment{color Black}}
			no_shadow
	}
	//geweih
	union{
		box{Position-<+11.1,-4.5,-0.5>,Position-<+10.5,-3.25,0.5>
				texture{pigment{color Black}}
		}
		//mitte g
		box{Position-<+11,-4.25,-1.5>,Position-<+10.5,-3.5,-0.5>
				texture{pigment{color Black}}
		}
		box{Position-<+11,-4.1,-2.5>,Position-<+10.5,-3.5,-1.5>
				texture{pigment{color Black}}
		}
		box{Position-<+11,-4.25,-3.5>,Position-<+10.5,-3.25,-2.5>
				texture{pigment{color Black}}
		}
		
		//mitte g
		box{Position-<+11,-4.25,1.5>,Position-<+10.5,-3.5,0.5>
				texture{pigment{color Black}}
		}
		box{Position-<+11,-4.1,2.5>,Position-<+10.5,-3.5,1.5>
				texture{pigment{color Black}}
		}
		box{Position-<+11,-4.25,3.5>,Position-<+10.5,-3.25,2.5>
				texture{pigment{color Black}}
		}
	}
	



	translate (Position-<+10.5,-2.5,-1.5>)*-1
	rotate <0,45,0>
	translate Position-<+10.5,-2.5,-1.5>
	translate Position+<1,-2,0>
	}
	rotate <-20,-120,0>
	scale 0.1
}
#end

cow(<0,0,0>)





