



#declare beinrotation1 = 3*sin(clock)*2*pi;
#declare beinrotation2 = -3*sin(clock)*2*pi;


#macro strasse(position)
	union{
	
		box{ 
			position+<0,0,-4000>, position+<200,0.3,4000>
			texture{pigment{color red 0.4 green 0.4 blue 0.4}}	
		}
		
		#declare Point = 1;
		#declare StartPoint = -500;
		#while(Point < 10000)
  			box{ 
				position+<95, 0, 1+Point+ StartPoint>, position+<105, 1, 50+Point+ StartPoint>
				texture{pigment{color White}}	
			}
  			#declare Point = Point+100;
		#end
		
		//translate (<+10.5,-2.5,-1.5>)*-1
		//rotate <0,0,30>
		//translate <+11,-1.5,-1.5>
		//scale 3
	}
#end


