 				% a sphere
{ /v /u /face			  % bind arguments
  0.8 0.2 v point		  % surface color
  1.0 0.2 1.0			  % kd ks n
} sphere /s


				% scene consisting of one sphere
s -1.2 0.0 3.0 translate 	  % sphere at (-1, 0, 3)
/scene

				% directional light
1.0 -1.0 0.0 point		  % direction
1.0  1.0 1.0 point light /l	  % directional light

				% render
0.4 0.4 0.4 point		  % ambient light
[ l ]				  % lights
scene				  % scene to render
3				  % tracing depth
90.0				  % field of view
640 480				  % image wid and height
"sphere.ppm"			  % output file
render