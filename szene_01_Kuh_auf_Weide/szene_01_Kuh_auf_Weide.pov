//Persistence of Vision Ray Tracer Scene Description File

#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "finish.inc"
#include "skies.inc"
#include "woods.inc"
#include "Kuh.inc"

global_settings{
	assumed_gamma 2.2
	//good radiosity settings

}


//######### START Kamera ##########
camera {
        location  <0, 0, -3>
        look_at   <0, 0,  0>
}
//########## END Kamera ##########

//########## START Licht #########
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

//######### END Licht #########


//######### Start Cubemap ##########

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

//######### End Cubemap ##########


//######### START Boden #########
plane { y, -1 
	texture {  
		tiles { // Verschachtelung von Texturen 
			texture { 
				pigment { color red 1 green 1 blue 1 } 
				//finish { reflection 0.4 } 
			} 
			tile2 
			texture { 
				pigment { color red 0 green 0 blue 0 } 
				//finish { reflection 0.4 } 
			}   
		} 
		scale 2.3 // bestimmt die Grš§e der Kacheln 
	} 
} 


//######### END Boden #########





cow(<-clock*1.2,-0.5,0>)





