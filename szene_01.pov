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
   [function{ pow(Correct_Pig_fn(x,y,z).x, New_G)}
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
     image_map{ jpeg "storm.jpg"
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



text{
	ttf  "timrom.ttf" "Animierter Titel" 0.5,0
	pigment{Red}
	translate <7-clock,0,0>
}





