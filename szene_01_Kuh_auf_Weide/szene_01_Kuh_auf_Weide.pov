//Persistence of Vision Ray Tracer Scene Description File

#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "finish.inc"
#include "skies.inc"
#include "woods.inc"
#include "Kuh.inc"
#include "Strasse.inc"
#include "mgrass.pov"

#declare Fertig = "false";  // true oder false




#if (Fertig = "true")
//#####################################################################
//#####################################################################


#declare PdV=<0,55,-80>;
#declare PdA=<0,12,10>;
//camera{location PdV direction 2*z up y sky y right x*4/3  look_at PdA}



#declare Blanc1=rgb<0.90,0.81,0.81>;

#declare Green1=rgb<230,170,50>/255;
#declare Green2=rgb<110,160,8>/255;
#declare Green1=rgb<0.4,1,0.3>*0.4;
#declare Green2=rgb<60,160,8>/255;
// --------------------------------------
// Grass texture
// --------------------------------------
#declare P_Spotted =pigment {
spotted
    color_map {
        [0.0, 0.2   color Tan*0.1 color Tan*0.4]
        [0.2, 0.3   color Tan*0.4 color Green1]
        [0.3, 1.01   color Green1 color Green1*1.2]
    }
}

#declare P_Earth =pigment {
    spotted
    color_map {
        [0 color Tan*0.3]
        [0.6 color Tan*0.3]
        [0.6 color Green1*0.4]
        [1   color Green1*0.4]
    }
}
#declare P_Green=pigment{Green2*1.3}
//#declare P_Spotted=pigment{Red}
//#declare P_Earth=pigment{Blue}
#declare T_Grass=texture {                  
    pigment {
        gradient y
        turbulence 0.2
        pigment_map {                                
            [0.0 P_Earth]
            [0.3 P_Green]
            [0.9 P_Spotted]
            [1.00 P_Earth]
        }
    }

    finish{ambient 0.01 diffuse 0.7 specular 0.2 roughness 0.015}
    scale <0.001,1,0.001>
 
} 
// --------------------------------------
// Patch parameters
// --------------------------------------
// Final number of triangles = nBlade x nBlade x segBlade x 2 (or 4 if dofold = true)
// --------------------------------------
#declare lPatch=100;               // size of patch
#declare nBlade=50;                // number of blades per line (there will be nBlade x nBlade blades)
//#declare nBlade=4;                // number of blades per line (there will be nBlade x nBlade blades)
#declare ryBlade = 0;            // initial y rotation of blade
#declare segBlade= 10;            // number of blade segments
#declare lBlade = 3;             // length of blade
#declare wBlade = 0.4;            // width of blade at start
#declare wBladeEnd = 0.2;         // width of blade at the end
#declare doSmooth=false;          // true makes smooth triangles
#declare startBend = <0,1,0.3>;   // bending of blade at start (<0,1,0>=no bending)
#declare vBend = <0,1,0>;         // force bending the blade (<0,1,1> = 45°)
#declare pwBend = 4;              // bending power (how slowly the curve bends)
#declare rd = 459;                // seed
#declare stdposBlade = 1;         // standard deviation of blade position 0..1
#declare stdrotBlade = 360;       // standard deviation of rotation
#declare stdBlade = 1.2;           // standard deviation of blade scale
#declare stdBend = 3;            // standard deviation of blade bending
#declare dofold = true;          // true creates a central fold in the blade (twice more triangles)
#declare dofile = true;          // true creates a mesh file
#declare fname = "fgrass2.inc"     // name of the mesh file to create

// --------------------------------------
// Prairie parameters
// --------------------------------------
#declare nxPrairie=3;             // number of patches for the first line
#declare addPatches=1;            // number of patches to add at each line
#declare nzPrairie=5;             // number of lines of patches
#declare rd=seed(779);            // random seed
#declare stdscale=1;              // stddev of scale
#declare stdrotate=1;             // stddev of rotation
#declare doTest=false;            // replaces the patch with a sphere

// --------------------------------------
// Create the patch and the prairie
// --------------------------------------
#if (dofile=true) // if the patch is already created, turn off the next line
    MakeGrassPatch(lPatch,nBlade,ryBlade,segBlade,lBlade,wBlade,wBladeEnd,doSmooth,startBend,vBend,pwBend,rd,stdposBlade,stdrotBlade,stdBlade,stdBend,dofold,dofile,fname)
    #declare objectPatch=#include fname
#else        
    #declare objectPatch=object{MakeGrassPatch(lPatch,nBlade,ryBlade,segBlade,lBlade,wBlade,wBladeEnd,doSmooth,startBend,vBend,pwBend,rd,stdposBlade,stdrotBlade,stdBlade,stdBend,dofold,dofile,fname)}
#end        

object{MakePrairie(lPatch,nxPrairie,addPatches,nzPrairie,objectPatch,rd,stdscale,stdrotate,doTest)
    texture{T_Grass scale 40}
}  

//cylinder{0,y*30,5 texture{T_Grass scale 40}}
//plane{y,0 texture{T_Grass scale 40}}
//plane{y,0 pigment{Tan}}
background{rgb<0.5,0.7,1>*2}


//#####################################################################
//#####################################################################
#end










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
#end

box{ <-1, -1, -1>,< 1, 1, 1>
 texture{ uv_mapping
   Correct_Pigment_Gamma( // gamma correction
     pigment{
     image_map{ png "cubemap_sky.png"
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


#if (Fertig = "true")
global_settings{
	assumed_gamma 2.2
	//good radiosity settings

}
#end 


//light_source{0 White*2 translate <-200, 400, -300>}
//light_source{PdA White*0.5 shadowless}
//
//light_source{PdA White*0.5 shadowless}


light_source {
    <-200, 400, -300>
    color Gray50
    //shadowless
  }

//plane{y,0 texture{T_Grass scale 40}}
plane{y, 0
	texture { 
				pigment { color red 0.5 green 0.7 blue 0.5 } 
			}   
}

//######### START Kamera ##########
camera {
	#if(clock < 15)
		location  <150, 50, -100>
		look_at   <0, 20, 0>
	#else
		location  <150, 50, -100>
		look_at   < clock - 14 , 20, 0>
	#end
}
//########## END Kamera ##########
//Clock End 	= 100
//Final Frame	= 200
//Subset End 	= 200


strasse(<500,0,0>)
cow(<-clock, 9 ,0>)










