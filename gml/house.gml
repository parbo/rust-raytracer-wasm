% house.gml
%
% OUTPUTS: house.ppm
%
% A crude house.  This example exercises most of the mechanisms.
%

/* surface.ins
 *
 * This include file defines simple constant surface functions
 */


%%%%%%%%%% include surface.ins %%%%%%%%%%

/* util.ins
 *
 * COPYRIGHT (c) 2000 Bell Labs, Lucent Techbnologies.
 *
 * Various GML utility functions.
 */


%%%%%%%%%% include util.ins %%%%%%%%%%

{ /x } /pop		% pop a stack item
{ /x x x } /dup		% duplicate a stack item

% pop n items off the stack
{ /n
  { /self /i
    i 1 lessi
    { }
    { /x i 1 subi self self apply }
    if
  } /loop
  n loop loop apply
} /popn

% dot product
% ... v2 v1  dot  ==> ... r
{ /v1 /v2
  v1 getx v2 getx mulf
  v1 gety v2 gety mulf addf
  v1 getz v2 getz mulf addf
} /dot

% integer absolute value
{ /i i 0 lessi { i negi } { i } if } /absi

% floating-point absolute value
{ /f f 0.0 lessf { f negf } { f } if } /absf

% normalize
% ... v1  normalize  ==> ... v2
{ /v
  1.0 v v dot apply sqrt divf /s	% s = sqrt(1.0/v dot v)
  s v getx mulf				% push s*x
  s v gety mulf				% push s*y
  s v getz mulf				% push s*z
  point					% make normalized vector
} /normalize

% addp
{ /v2 /v1
  v1 getx v2 getx addf
  v1 gety v2 gety addf
  v1 getz v2 getz addf point
} /addp

% subp
{ /v2 /v1
  v1 getx v2 getx subf
  v1 gety v2 gety subf
  v1 getz v2 getz subf point
} /subp

% mulp
{ /v2 /v1
  v1 getx v2 getx mulf
  v1 gety v2 gety mulf
  v1 getz v2 getz mulf point
} /mulp

% negp
{ /v
  v getx negf
  v gety negf
  v getz negf point
} /negp


% A simple pseudo-random number generator (from Graphics Gems II; p. 137)
% We have to do the computation in FP, since it overflows in integer arithmetic.
{ real 25173.0 mulf 13849.0 addf 65536.0 divf frac 65536.0 mulf floor } /random

% A random number in [0..1].
%
% seed  randomf  ==> f seed
{ 
  random apply /seed
  seed real 65535.0 divf seed
} /randomf

%%%%%%%%%% util.ins %%%%%%%%%%

/* colors.ins
 *
 * This include file defines a bunch of colors
 */


%%%%%%%%%% include colors.ins %%%%%%%%%%

0.0  0.0  0.0  point /black
1.0  1.0  1.0  point /white
1.0  0.0  0.0  point /red
0.0  1.0  0.0  point /green
0.0  0.0  1.0  point /blue
1.0  0.0  1.0  point /magenta
1.0  1.0  0.0  point /yellow
0.0  1.0  1.0  point /cyan

% ... <level>  grey  ==>  <color>
{ clampf /level level level level point } /grey

%%%%%%%%%% colors.ins %%%%%%%%%%


% ... <color> matte  ==>  ... <surface>
{ /color
  { /v /u /face
    color 1.0 0.0 1.0
  }
} /matte

% ... <color> <kd> <ks> <n>  ==>  ... <surface>
{ /n /ks /kd /color
  { /v /u /face
    color kd ks n
  }
} /const-surface

%%%%%%%%%% surface.ins %%%%%%%%%%

% These are the standard X11 RGP colors and names.  They are probably
% COPYRIGHT the X Consortium.
%
% we convert them to GML colors
%


%%%%%%%%%% include rgb.ins %%%%%%%%%%

{ 1.0 255.0 divf /s
  { /b /g /r
    r real s mulf
    g real s mulf
    b real s mulf point
  }
} apply /rgb

255 250 250 rgb apply	/snow
248 248 255 rgb apply	/ghost-white
245 245 245 rgb apply	/white-smoke
220 220 220 rgb apply	/gainsboro
255 250 240 rgb apply	/floral-white
255 250 240 rgb apply	/FloralWhite
253 245 230 rgb apply	/old-lace
253 245 230 rgb apply	/OldLace
250 240 230 rgb apply	/linen
250 235 215 rgb apply	/antique-white
250 235 215 rgb apply	/AntiqueWhite
255 239 213 rgb apply	/papaya-whip
255 239 213 rgb apply	/PapayaWhip
255 235 205 rgb apply	/blanched-almond
255 235 205 rgb apply	/BlanchedAlmond
255 228 196 rgb apply	/bisque
255 218 185 rgb apply	/peach-puff
255 218 185 rgb apply	/PeachPuff
255 222 173 rgb apply	/navajo-white
255 222 173 rgb apply	/NavajoWhite
255 228 181 rgb apply	/moccasin
255 248 220 rgb apply	/cornsilk
255 255 240 rgb apply	/ivory
255 250 205 rgb apply	/lemon-chiffon
255 250 205 rgb apply	/LemonChiffon
255 245 238 rgb apply	/seashell
240 255 240 rgb apply	/honeydew
245 255 250 rgb apply	/mint-cream
245 255 250 rgb apply	/MintCream
240 255 255 rgb apply	/azure
240 248 255 rgb apply	/alice-blue
240 248 255 rgb apply	/AliceBlue
230 230 250 rgb apply	/lavender
255 240 245 rgb apply	/lavender-blush
255 240 245 rgb apply	/LavenderBlush
255 228 225 rgb apply	/misty-rose
255 228 225 rgb apply	/MistyRose
255 255 255 rgb apply	/white
  0   0   0 rgb apply	/black
 47  79  79 rgb apply	/dark-slate-gray
105 105 105 rgb apply	/dim-gray
105 105 105 rgb apply	/DimGray
105 105 105 rgb apply	/dim-grey
105 105 105 rgb apply	/DimGrey
112 128 144 rgb apply	/slate-gray
112 128 144 rgb apply	/SlateGray
112 128 144 rgb apply	/slate-grey
112 128 144 rgb apply	/SlateGrey
119 136 153 rgb apply	/light-slate-gray
119 136 153 rgb apply	/LightSlateGray
119 136 153 rgb apply	/light-slate-grey
119 136 153 rgb apply	/LightSlateGrey
190 190 190 rgb apply	/gray
190 190 190 rgb apply	/grey
211 211 211 rgb apply	/light-grey
211 211 211 rgb apply	/LightGrey
211 211 211 rgb apply	/light-gray
211 211 211 rgb apply	/LightGray
 25  25 112 rgb apply	/midnight-blue
  0   0 128 rgb apply	/navy
  0   0 128 rgb apply	/navy-blue
100 149 237 rgb apply	/cornflower-blue
100 149 237 rgb apply	/CornflowerBlue
 72  61 139 rgb apply	/dark-slate-blue
106  90 205 rgb apply	/slate-blue
106  90 205 rgb apply	/SlateBlue
123 104 238 rgb apply	/medium-slate-blue
132 112 255 rgb apply	/light-slate-blue
  0   0 205 rgb apply	/medium-blue
  0   0 205 rgb apply	/MediumBlue
 65 105 225 rgb apply	/royal-blue
  0   0 255 rgb apply	/blue
 30 144 255 rgb apply	/dodger-blue
  0 191 255 rgb apply	/deep-sky-blue
135 206 235 rgb apply	/sky-blue
135 206 250 rgb apply	/light-sky-blue
 70 130 180 rgb apply	/steel-blue
176 196 222 rgb apply	/light-steel-blue
176 196 222 rgb apply	/LightSteelBlue
173 216 230 rgb apply	/light-blue
173 216 230 rgb apply	/LightBlue
176 224 230 rgb apply	/powder-blue
176 224 230 rgb apply	/PowderBlue
175 238 238 rgb apply	/pale-turquoise
175 238 238 rgb apply	/PaleTurquoise
  0 206 209 rgb apply	/dark-turquoise
  0 206 209 rgb apply	/DarkTurquoise
 72 209 204 rgb apply	/medium-turquoise
 72 209 204 rgb apply	/MediumTurquoise
 64 224 208 rgb apply	/turquoise
  0 255 255 rgb apply	/cyan
224 255 255 rgb apply	/light-cyan
224 255 255 rgb apply	/LightCyan
 95 158 160 rgb apply	/cadet-blue
 95 158 160 rgb apply	/CadetBlue
102 205 170 rgb apply	/medium-aquamarine
102 205 170 rgb apply	/MediumAquamarine
127 255 212 rgb apply	/aquamarine
  0 100   0 rgb apply	/dark-green
 85 107  47 rgb apply	/dark-olive-green
 85 107  47 rgb apply	/DarkOliveGreen
143 188 143 rgb apply	/dark-sea-green
143 188 143 rgb apply	/DarkSeaGreen
 46 139  87 rgb apply	/sea-green
 46 139  87 rgb apply	/SeaGreen
 60 179 113 rgb apply	/medium-sea-green
 60 179 113 rgb apply	/MediumSeaGreen
 32 178 170 rgb apply	/light-sea-green
 32 178 170 rgb apply	/LightSeaGreen
152 251 152 rgb apply	/pale-green
  0 255 127 rgb apply	/spring-green
124 252   0 rgb apply	/lawn-green
  0 255   0 rgb apply	/green
127 255   0 rgb apply	/chartreuse
  0 250 154 rgb apply	/medium-spring-green
173 255  47 rgb apply	/green-yellow
173 255  47 rgb apply	/GreenYellow
 50 205  50 rgb apply	/lime green
 50 205  50 rgb apply	/LimeGreen
154 205  50 rgb apply	/yellow-green
154 205  50 rgb apply	/YellowGreen
 34 139  34 rgb apply	/forest-green
 34 139  34 rgb apply	/ForestGreen
107 142  35 rgb apply	/olive-drab
107 142  35 rgb apply	/OliveDrab
189 183 107 rgb apply	/dark-khaki
189 183 107 rgb apply	/DarkKhaki
240 230 140 rgb apply	/khaki
238 232 170 rgb apply	/pale-goldenrod
238 232 170 rgb apply	/PaleGoldenrod
250 250 210 rgb apply	/light-goldenrod-yellow
250 250 210 rgb apply	/LightGoldenrodYellow
255 255 224 rgb apply	/light-yellow
255 255 224 rgb apply	/LightYellow
255 255   0 rgb apply	/yellow
255 215   0 rgb apply	/gold
238 221 130 rgb apply	/light-goldenrod
238 221 130 rgb apply	/LightGoldenrod
218 165  32 rgb apply	/goldenrod
184 134  11 rgb apply	/dark-goldenrod
184 134  11 rgb apply	/DarkGoldenrod
188 143 143 rgb apply	/rosy-brown
188 143 143 rgb apply	/RosyBrown
205  92  92 rgb apply	/indian-red
205  92  92 rgb apply	/IndianRed
139  69  19 rgb apply	/saddle-brown
139  69  19 rgb apply	/SaddleBrown
160  82  45 rgb apply	/sienna
205 133  63 rgb apply	/peru
222 184 135 rgb apply	/burlywood
245 245 220 rgb apply	/beige
245 222 179 rgb apply	/wheat
244 164  96 rgb apply	/sandy-brown
244 164  96 rgb apply	/SandyBrown
210 180 140 rgb apply	/tan
210 105  30 rgb apply	/chocolate
178  34  34 rgb apply	/firebrick
165  42  42 rgb apply	/brown
233 150 122 rgb apply	/dark-salmon
233 150 122 rgb apply	/DarkSalmon
250 128 114 rgb apply	/salmon
255 160 122 rgb apply	/light-salmon
255 160 122 rgb apply	/LightSalmon
255 165   0 rgb apply	/orange
255 140   0 rgb apply	/dark-orange
255 140   0 rgb apply	/DarkOrange
255 127  80 rgb apply	/coral
240 128 128 rgb apply	/light-coral
240 128 128 rgb apply	/LightCoral
255  99  71 rgb apply	/tomato
255  69   0 rgb apply	/orange-red
255  69   0 rgb apply	/OrangeRed
255   0   0 rgb apply	/red
255 105 180 rgb apply	/hot-pink
255 105 180 rgb apply	/HotPink
255  20 147 rgb apply	/deep-pink
255  20 147 rgb apply	/DeepPink
255 192 203 rgb apply	/pink
255 182 193 rgb apply	/light-pink
255 182 193 rgb apply	/LightPink
219 112 147 rgb apply	/pale-violet-red
219 112 147 rgb apply	/PaleVioletRed
176  48  96 rgb apply	/maroon
199  21 133 rgb apply	/medium-violet-red
199  21 133 rgb apply	/MediumVioletRed
208  32 144 rgb apply	/violet-red
208  32 144 rgb apply	/VioletRed
255   0 255 rgb apply	/magenta
238 130 238 rgb apply	/violet
221 160 221 rgb apply	/plum
218 112 214 rgb apply	/orchid
186  85 211 rgb apply	/medium-orchid
186  85 211 rgb apply	/MediumOrchid
153  50 204 rgb apply	/dark-orchid
153  50 204 rgb apply	/DarkOrchid
148   0 211 rgb apply	/dark-violet
148   0 211 rgb apply	/DarkViolet
138  43 226 rgb apply	/blue-violet
138  43 226 rgb apply	/BlueViolet
160  32 240 rgb apply	/purple
147 112 219 rgb apply	/medium-purple
147 112 219 rgb apply	/MediumPurple
216 191 216 rgb apply	/thistle
255 250 250 rgb apply	/snow1
238 233 233 rgb apply	/snow2
205 201 201 rgb apply	/snow3
139 137 137 rgb apply	/snow4
255 245 238 rgb apply	/seashell1
238 229 222 rgb apply	/seashell2
205 197 191 rgb apply	/seashell3
139 134 130 rgb apply	/seashell4
255 239 219 rgb apply	/AntiqueWhite1
238 223 204 rgb apply	/AntiqueWhite2
205 192 176 rgb apply	/AntiqueWhite3
139 131 120 rgb apply	/AntiqueWhite4
255 228 196 rgb apply	/bisque1
238 213 183 rgb apply	/bisque2
205 183 158 rgb apply	/bisque3
139 125 107 rgb apply	/bisque4
255 218 185 rgb apply	/PeachPuff1
238 203 173 rgb apply	/PeachPuff2
205 175 149 rgb apply	/PeachPuff3
139 119 101 rgb apply	/PeachPuff4
255 222 173 rgb apply	/NavajoWhite1
238 207 161 rgb apply	/NavajoWhite2
205 179 139 rgb apply	/NavajoWhite3
139 121	 94 rgb apply	/NavajoWhite4
255 250 205 rgb apply	/LemonChiffon1
238 233 191 rgb apply	/LemonChiffon2
205 201 165 rgb apply	/LemonChiffon3
139 137 112 rgb apply	/LemonChiffon4
255 248 220 rgb apply	/cornsilk1
238 232 205 rgb apply	/cornsilk2
205 200 177 rgb apply	/cornsilk3
139 136 120 rgb apply	/cornsilk4
255 255 240 rgb apply	/ivory1
238 238 224 rgb apply	/ivory2
205 205 193 rgb apply	/ivory3
139 139 131 rgb apply	/ivory4
240 255 240 rgb apply	/honeydew1
224 238 224 rgb apply	/honeydew2
193 205 193 rgb apply	/honeydew3
131 139 131 rgb apply	/honeydew4
255 240 245 rgb apply	/LavenderBlush1
238 224 229 rgb apply	/LavenderBlush2
205 193 197 rgb apply	/LavenderBlush3
139 131 134 rgb apply	/LavenderBlush4
255 228 225 rgb apply	/MistyRose1
238 213 210 rgb apply	/MistyRose2
205 183 181 rgb apply	/MistyRose3
139 125 123 rgb apply	/MistyRose4
240 255 255 rgb apply	/azure1
224 238 238 rgb apply	/azure2
193 205 205 rgb apply	/azure3
131 139 139 rgb apply	/azure4
131 111 255 rgb apply	/SlateBlue1
122 103 238 rgb apply	/SlateBlue2
105  89 205 rgb apply	/SlateBlue3
 71  60 139 rgb apply	/SlateBlue4
 72 118 255 rgb apply	/RoyalBlue1
 67 110 238 rgb apply	/RoyalBlue2
 58  95 205 rgb apply	/RoyalBlue3
 39  64 139 rgb apply	/RoyalBlue4
  0   0 255 rgb apply	/blue1
  0   0 238 rgb apply	/blue2
  0   0 205 rgb apply	/blue3
  0   0 139 rgb apply	/blue4
 30 144 255 rgb apply	/DodgerBlue1
 28 134 238 rgb apply	/DodgerBlue2
 24 116 205 rgb apply	/DodgerBlue3
 16  78 139 rgb apply	/DodgerBlue4
 99 184 255 rgb apply	/SteelBlue1
 92 172 238 rgb apply	/SteelBlue2
 79 148 205 rgb apply	/SteelBlue3
 54 100 139 rgb apply	/SteelBlue4
  0 191 255 rgb apply	/DeepSkyBlue1
  0 178 238 rgb apply	/DeepSkyBlue2
  0 154 205 rgb apply	/DeepSkyBlue3
  0 104 139 rgb apply	/DeepSkyBlue4
135 206 255 rgb apply	/SkyBlue1
126 192 238 rgb apply	/SkyBlue2
108 166 205 rgb apply	/SkyBlue3
 74 112 139 rgb apply	/SkyBlue4
176 226 255 rgb apply	/LightSkyBlue1
164 211 238 rgb apply	/LightSkyBlue2
141 182 205 rgb apply	/LightSkyBlue3
 96 123 139 rgb apply	/LightSkyBlue4
198 226 255 rgb apply	/SlateGray1
185 211 238 rgb apply	/SlateGray2
159 182 205 rgb apply	/SlateGray3
108 123 139 rgb apply	/SlateGray4
202 225 255 rgb apply	/LightSteelBlue1
188 210 238 rgb apply	/LightSteelBlue2
162 181 205 rgb apply	/LightSteelBlue3
110 123 139 rgb apply	/LightSteelBlue4
191 239 255 rgb apply	/LightBlue1
178 223 238 rgb apply	/LightBlue2
154 192 205 rgb apply	/LightBlue3
104 131 139 rgb apply	/LightBlue4
224 255 255 rgb apply	/LightCyan1
209 238 238 rgb apply	/LightCyan2
180 205 205 rgb apply	/LightCyan3
122 139 139 rgb apply	/LightCyan4
187 255 255 rgb apply	/PaleTurquoise1
174 238 238 rgb apply	/PaleTurquoise2
150 205 205 rgb apply	/PaleTurquoise3
102 139 139 rgb apply	/PaleTurquoise4
152 245 255 rgb apply	/CadetBlue1
142 229 238 rgb apply	/CadetBlue2
122 197 205 rgb apply	/CadetBlue3
 83 134 139 rgb apply	/CadetBlue4
  0 245 255 rgb apply	/turquoise1
  0 229 238 rgb apply	/turquoise2
  0 197 205 rgb apply	/turquoise3
  0 134 139 rgb apply	/turquoise4
  0 255 255 rgb apply	/cyan1
  0 238 238 rgb apply	/cyan2
  0 205 205 rgb apply	/cyan3
  0 139 139 rgb apply	/cyan4
151 255 255 rgb apply	/DarkSlateGray1
141 238 238 rgb apply	/DarkSlateGray2
121 205 205 rgb apply	/DarkSlateGray3
 82 139 139 rgb apply	/DarkSlateGray4
127 255 212 rgb apply	/aquamarine1
118 238 198 rgb apply	/aquamarine2
102 205 170 rgb apply	/aquamarine3
 69 139 116 rgb apply	/aquamarine4
193 255 193 rgb apply	/DarkSeaGreen1
180 238 180 rgb apply	/DarkSeaGreen2
155 205 155 rgb apply	/DarkSeaGreen3
105 139 105 rgb apply	/DarkSeaGreen4
 84 255 159 rgb apply	/SeaGreen1
 78 238 148 rgb apply	/SeaGreen2
 67 205 128 rgb apply	/SeaGreen3
 46 139	 87 rgb apply	/SeaGreen4
154 255 154 rgb apply	/PaleGreen1
144 238 144 rgb apply	/PaleGreen2
124 205 124 rgb apply	/PaleGreen3
 84 139	 84 rgb apply	/PaleGreen4
  0 255 127 rgb apply	/SpringGreen1
  0 238 118 rgb apply	/SpringGreen2
  0 205 102 rgb apply	/SpringGreen3
  0 139	 69 rgb apply	/SpringGreen4
  0 255	  0 rgb apply	/green1
  0 238	  0 rgb apply	/green2
  0 205	  0 rgb apply	/green3
  0 139	  0 rgb apply	/green4
127 255	  0 rgb apply	/chartreuse1
118 238	  0 rgb apply	/chartreuse2
102 205	  0 rgb apply	/chartreuse3
 69 139	  0 rgb apply	/chartreuse4
192 255	 62 rgb apply	/OliveDrab1
179 238	 58 rgb apply	/OliveDrab2
154 205	 50 rgb apply	/OliveDrab3
105 139	 34 rgb apply	/OliveDrab4
202 255 112 rgb apply	/DarkOliveGreen1
188 238 104 rgb apply	/DarkOliveGreen2
162 205	 90 rgb apply	/DarkOliveGreen3
110 139	 61 rgb apply	/DarkOliveGreen4
255 246 143 rgb apply	/khaki1
238 230 133 rgb apply	/khaki2
205 198 115 rgb apply	/khaki3
139 134	 78 rgb apply	/khaki4
255 236 139 rgb apply	/LightGoldenrod1
238 220 130 rgb apply	/LightGoldenrod2
205 190 112 rgb apply	/LightGoldenrod3
139 129	 76 rgb apply	/LightGoldenrod4
255 255 224 rgb apply	/LightYellow1
238 238 209 rgb apply	/LightYellow2
205 205 180 rgb apply	/LightYellow3
139 139 122 rgb apply	/LightYellow4
255 255	  0 rgb apply	/yellow1
238 238	  0 rgb apply	/yellow2
205 205	  0 rgb apply	/yellow3
139 139	  0 rgb apply	/yellow4
255 215	  0 rgb apply	/gold1
238 201	  0 rgb apply	/gold2
205 173	  0 rgb apply	/gold3
139 117	  0 rgb apply	/gold4
255 193	 37 rgb apply	/goldenrod1
238 180	 34 rgb apply	/goldenrod2
205 155	 29 rgb apply	/goldenrod3
139 105	 20 rgb apply	/goldenrod4
255 185	 15 rgb apply	/DarkGoldenrod1
238 173	 14 rgb apply	/DarkGoldenrod2
205 149	 12 rgb apply	/DarkGoldenrod3
139 101	  8 rgb apply	/DarkGoldenrod4
255 193 193 rgb apply	/RosyBrown1
238 180 180 rgb apply	/RosyBrown2
205 155 155 rgb apply	/RosyBrown3
139 105 105 rgb apply	/RosyBrown4
255 106 106 rgb apply	/IndianRed1
238  99	 99 rgb apply	/IndianRed2
205  85	 85 rgb apply	/IndianRed3
139  58	 58 rgb apply	/IndianRed4
255 130	 71 rgb apply	/sienna1
238 121	 66 rgb apply	/sienna2
205 104	 57 rgb apply	/sienna3
139  71	 38 rgb apply	/sienna4
255 211 155 rgb apply	/burlywood1
238 197 145 rgb apply	/burlywood2
205 170 125 rgb apply	/burlywood3
139 115	 85 rgb apply	/burlywood4
255 231 186 rgb apply	/wheat1
238 216 174 rgb apply	/wheat2
205 186 150 rgb apply	/wheat3
139 126 102 rgb apply	/wheat4
255 165	 79 rgb apply	/tan1
238 154	 73 rgb apply	/tan2
205 133	 63 rgb apply	/tan3
139  90	 43 rgb apply	/tan4
255 127	 36 rgb apply	/chocolate1
238 118	 33 rgb apply	/chocolate2
205 102	 29 rgb apply	/chocolate3
139  69	 19 rgb apply	/chocolate4
255  48	 48 rgb apply	/firebrick1
238  44	 44 rgb apply	/firebrick2
205  38	 38 rgb apply	/firebrick3
139  26	 26 rgb apply	/firebrick4
255  64	 64 rgb apply	/brown1
238  59	 59 rgb apply	/brown2
205  51	 51 rgb apply	/brown3
139  35	 35 rgb apply	/brown4
255 140 105 rgb apply	/salmon1
238 130	 98 rgb apply	/salmon2
205 112	 84 rgb apply	/salmon3
139  76	 57 rgb apply	/salmon4
255 160 122 rgb apply	/LightSalmon1
238 149 114 rgb apply	/LightSalmon2
205 129	 98 rgb apply	/LightSalmon3
139  87	 66 rgb apply	/LightSalmon4
255 165	  0 rgb apply	/orange1
238 154	  0 rgb apply	/orange2
205 133	  0 rgb apply	/orange3
139  90	  0 rgb apply	/orange4
255 127	  0 rgb apply	/DarkOrange1
238 118	  0 rgb apply	/DarkOrange2
205 102	  0 rgb apply	/DarkOrange3
139  69	  0 rgb apply	/DarkOrange4
255 114	 86 rgb apply	/coral1
238 106	 80 rgb apply	/coral2
205  91	 69 rgb apply	/coral3
139  62	 47 rgb apply	/coral4
255  99	 71 rgb apply	/tomato1
238  92	 66 rgb apply	/tomato2
205  79	 57 rgb apply	/tomato3
139  54	 38 rgb apply	/tomato4
255  69	  0 rgb apply	/OrangeRed1
238  64	  0 rgb apply	/OrangeRed2
205  55	  0 rgb apply	/OrangeRed3
139  37	  0 rgb apply	/OrangeRed4
255   0	  0 rgb apply	/red1
238   0	  0 rgb apply	/red2
205   0	  0 rgb apply	/red3
139   0	  0 rgb apply	/red4
255  20 147 rgb apply	/DeepPink1
238  18 137 rgb apply	/DeepPink2
205  16 118 rgb apply	/DeepPink3
139  10	 80 rgb apply	/DeepPink4
255 110 180 rgb apply	/HotPink1
238 106 167 rgb apply	/HotPink2
205  96 144 rgb apply	/HotPink3
139  58  98 rgb apply	/HotPink4
255 181 197 rgb apply	/pink1
238 169 184 rgb apply	/pink2
205 145 158 rgb apply	/pink3
139  99 108 rgb apply	/pink4
255 174 185 rgb apply	/LightPink1
238 162 173 rgb apply	/LightPink2
205 140 149 rgb apply	/LightPink3
139  95 101 rgb apply	/LightPink4
255 130 171 rgb apply	/PaleVioletRed1
238 121 159 rgb apply	/PaleVioletRed2
205 104 137 rgb apply	/PaleVioletRed3
139  71	 93 rgb apply	/PaleVioletRed4
255  52 179 rgb apply	/maroon1
238  48 167 rgb apply	/maroon2
205  41 144 rgb apply	/maroon3
139  28	 98 rgb apply	/maroon4
255  62 150 rgb apply	/VioletRed1
238  58 140 rgb apply	/VioletRed2
205  50 120 rgb apply	/VioletRed3
139  34	 82 rgb apply	/VioletRed4
255   0 255 rgb apply	/magenta1
238   0 238 rgb apply	/magenta2
205   0 205 rgb apply	/magenta3
139   0 139 rgb apply	/magenta4
255 131 250 rgb apply	/orchid1
238 122 233 rgb apply	/orchid2
205 105 201 rgb apply	/orchid3
139  71 137 rgb apply	/orchid4
255 187 255 rgb apply	/plum1
238 174 238 rgb apply	/plum2
205 150 205 rgb apply	/plum3
139 102 139 rgb apply	/plum4
224 102 255 rgb apply	/MediumOrchid1
209  95 238 rgb apply	/MediumOrchid2
180  82 205 rgb apply	/MediumOrchid3
122  55 139 rgb apply	/MediumOrchid4
191  62 255 rgb apply	/DarkOrchid1
178  58 238 rgb apply	/DarkOrchid2
154  50 205 rgb apply	/DarkOrchid3
104  34 139 rgb apply	/DarkOrchid4
155  48 255 rgb apply	/purple1
145  44 238 rgb apply	/purple2
125  38 205 rgb apply	/purple3
 85  26 139 rgb apply	/purple4
171 130 255 rgb apply	/MediumPurple1
159 121 238 rgb apply	/MediumPurple2
137 104 205 rgb apply	/MediumPurple3
 93  71 139 rgb apply	/MediumPurple4
255 225 255 rgb apply	/thistle1
238 210 238 rgb apply	/thistle2
205 181 205 rgb apply	/thistle3
139 123 139 rgb apply	/thistle4
  0   0   0 rgb apply	/gray0
  0   0   0 rgb apply	/grey0
  3   3   3 rgb apply	/gray1
  3   3   3 rgb apply	/grey1
  5   5   5 rgb apply	/gray2
  5   5   5 rgb apply	/grey2
  8   8   8 rgb apply	/gray3
  8   8   8 rgb apply	/grey3
 10  10  10 rgb apply	/gray4
 10  10  10 rgb apply	/grey4
 13  13  13 rgb apply	/gray5
 13  13  13 rgb apply	/grey5
 15  15  15 rgb apply	/gray6
 15  15  15 rgb apply	/grey6
 18  18  18 rgb apply	/gray7
 18  18  18 rgb apply	/grey7
 20  20  20 rgb apply	/gray8
 20  20  20 rgb apply	/grey8
 23  23  23 rgb apply	/gray9
 23  23  23 rgb apply	/grey9
 26  26  26 rgb apply	/gray10
 26  26  26 rgb apply	/grey10
 28  28  28 rgb apply	/gray11
 28  28  28 rgb apply	/grey11
 31  31  31 rgb apply	/gray12
 31  31  31 rgb apply	/grey12
 33  33  33 rgb apply	/gray13
 33  33  33 rgb apply	/grey13
 36  36  36 rgb apply	/gray14
 36  36  36 rgb apply	/grey14
 38  38  38 rgb apply	/gray15
 38  38  38 rgb apply	/grey15
 41  41  41 rgb apply	/gray16
 41  41  41 rgb apply	/grey16
 43  43  43 rgb apply	/gray17
 43  43  43 rgb apply	/grey17
 46  46  46 rgb apply	/gray18
 46  46  46 rgb apply	/grey18
 48  48  48 rgb apply	/gray19
 48  48  48 rgb apply	/grey19
 51  51  51 rgb apply	/gray20
 51  51  51 rgb apply	/grey20
 54  54  54 rgb apply	/gray21
 54  54  54 rgb apply	/grey21
 56  56  56 rgb apply	/gray22
 56  56  56 rgb apply	/grey22
 59  59  59 rgb apply	/gray23
 59  59  59 rgb apply	/grey23
 61  61  61 rgb apply	/gray24
 61  61  61 rgb apply	/grey24
 64  64  64 rgb apply	/gray25
 64  64  64 rgb apply	/grey25
 66  66  66 rgb apply	/gray26
 66  66  66 rgb apply	/grey26
 69  69  69 rgb apply	/gray27
 69  69  69 rgb apply	/grey27
 71  71  71 rgb apply	/gray28
 71  71  71 rgb apply	/grey28
 74  74  74 rgb apply	/gray29
 74  74  74 rgb apply	/grey29
 77  77  77 rgb apply	/gray30
 77  77  77 rgb apply	/grey30
 79  79  79 rgb apply	/gray31
 79  79  79 rgb apply	/grey31
 82  82  82 rgb apply	/gray32
 82  82  82 rgb apply	/grey32
 84  84  84 rgb apply	/gray33
 84  84  84 rgb apply	/grey33
 87  87  87 rgb apply	/gray34
 87  87  87 rgb apply	/grey34
 89  89  89 rgb apply	/gray35
 89  89  89 rgb apply	/grey35
 92  92  92 rgb apply	/gray36
 92  92  92 rgb apply	/grey36
 94  94  94 rgb apply	/gray37
 94  94  94 rgb apply	/grey37
 97  97  97 rgb apply	/gray38
 97  97  97 rgb apply	/grey38
 99  99  99 rgb apply	/gray39
 99  99  99 rgb apply	/grey39
102 102 102 rgb apply	/gray40
102 102 102 rgb apply	/grey40
105 105 105 rgb apply	/gray41
105 105 105 rgb apply	/grey41
107 107 107 rgb apply	/gray42
107 107 107 rgb apply	/grey42
110 110 110 rgb apply	/gray43
110 110 110 rgb apply	/grey43
112 112 112 rgb apply	/gray44
112 112 112 rgb apply	/grey44
115 115 115 rgb apply	/gray45
115 115 115 rgb apply	/grey45
117 117 117 rgb apply	/gray46
117 117 117 rgb apply	/grey46
120 120 120 rgb apply	/gray47
120 120 120 rgb apply	/grey47
122 122 122 rgb apply	/gray48
122 122 122 rgb apply	/grey48
125 125 125 rgb apply	/gray49
125 125 125 rgb apply	/grey49
127 127 127 rgb apply	/gray50
127 127 127 rgb apply	/grey50
130 130 130 rgb apply	/gray51
130 130 130 rgb apply	/grey51
133 133 133 rgb apply	/gray52
133 133 133 rgb apply	/grey52
135 135 135 rgb apply	/gray53
135 135 135 rgb apply	/grey53
138 138 138 rgb apply	/gray54
138 138 138 rgb apply	/grey54
140 140 140 rgb apply	/gray55
140 140 140 rgb apply	/grey55
143 143 143 rgb apply	/gray56
143 143 143 rgb apply	/grey56
145 145 145 rgb apply	/gray57
145 145 145 rgb apply	/grey57
148 148 148 rgb apply	/gray58
148 148 148 rgb apply	/grey58
150 150 150 rgb apply	/gray59
150 150 150 rgb apply	/grey59
153 153 153 rgb apply	/gray60
153 153 153 rgb apply	/grey60
156 156 156 rgb apply	/gray61
156 156 156 rgb apply	/grey61
158 158 158 rgb apply	/gray62
158 158 158 rgb apply	/grey62
161 161 161 rgb apply	/gray63
161 161 161 rgb apply	/grey63
163 163 163 rgb apply	/gray64
163 163 163 rgb apply	/grey64
166 166 166 rgb apply	/gray65
166 166 166 rgb apply	/grey65
168 168 168 rgb apply	/gray66
168 168 168 rgb apply	/grey66
171 171 171 rgb apply	/gray67
171 171 171 rgb apply	/grey67
173 173 173 rgb apply	/gray68
173 173 173 rgb apply	/grey68
176 176 176 rgb apply	/gray69
176 176 176 rgb apply	/grey69
179 179 179 rgb apply	/gray70
179 179 179 rgb apply	/grey70
181 181 181 rgb apply	/gray71
181 181 181 rgb apply	/grey71
184 184 184 rgb apply	/gray72
184 184 184 rgb apply	/grey72
186 186 186 rgb apply	/gray73
186 186 186 rgb apply	/grey73
189 189 189 rgb apply	/gray74
189 189 189 rgb apply	/grey74
191 191 191 rgb apply	/gray75
191 191 191 rgb apply	/grey75
194 194 194 rgb apply	/gray76
194 194 194 rgb apply	/grey76
196 196 196 rgb apply	/gray77
196 196 196 rgb apply	/grey77
199 199 199 rgb apply	/gray78
199 199 199 rgb apply	/grey78
201 201 201 rgb apply	/gray79
201 201 201 rgb apply	/grey79
204 204 204 rgb apply	/gray80
204 204 204 rgb apply	/grey80
207 207 207 rgb apply	/gray81
207 207 207 rgb apply	/grey81
209 209 209 rgb apply	/gray82
209 209 209 rgb apply	/grey82
212 212 212 rgb apply	/gray83
212 212 212 rgb apply	/grey83
214 214 214 rgb apply	/gray84
214 214 214 rgb apply	/grey84
217 217 217 rgb apply	/gray85
217 217 217 rgb apply	/grey85
219 219 219 rgb apply	/gray86
219 219 219 rgb apply	/grey86
222 222 222 rgb apply	/gray87
222 222 222 rgb apply	/grey87
224 224 224 rgb apply	/gray88
224 224 224 rgb apply	/grey88
227 227 227 rgb apply	/gray89
227 227 227 rgb apply	/grey89
229 229 229 rgb apply	/gray90
229 229 229 rgb apply	/grey90
232 232 232 rgb apply	/gray91
232 232 232 rgb apply	/grey91
235 235 235 rgb apply	/gray92
235 235 235 rgb apply	/grey92
237 237 237 rgb apply	/gray93
237 237 237 rgb apply	/grey93
240 240 240 rgb apply	/gray94
240 240 240 rgb apply	/grey94
242 242 242 rgb apply	/gray95
242 242 242 rgb apply	/grey95
245 245 245 rgb apply	/gray96
245 245 245 rgb apply	/grey96
247 247 247 rgb apply	/gray97
247 247 247 rgb apply	/grey97
250 250 250 rgb apply	/gray98
250 250 250 rgb apply	/grey98
252 252 252 rgb apply	/gray99
252 252 252 rgb apply	/grey99
255 255 255 rgb apply	/gray100
255 255 255 rgb apply	/grey100
169 169 169 rgb apply	/dark-grey
169 169 169 rgb apply	/dark-gray
0     0 139 rgb apply	/dark-blue
0   139 139 rgb apply	/dark-cyan
139   0 139 rgb apply	/dark-magenta
139   0   0 rgb apply	/dark-red
144 238 144 rgb apply	/light-green

%%%%%%%%%% rgb.ins %%%%%%%%%%


% the main body of the house
{ /v /u /face
  firebrick3 1.0 0.1 1.0
} cube
5.0 1.5 2.0 scale

% subtract away a bit to make the flat roof
{ /v /u /face
  face 5 eqi { grey66 } { gray20 } if
  1.0 0.1 1.0
} cube
4.99 0.12 1.99 scale
0.005 1.4 0.005 translate
difference

% subtract away a door
white matte apply cube
0.25 1.0 0.02 scale
2.5 -0.125 addf 0.0 -0.005 translate
difference

white matte apply cylinder
0.25 uscale
-90.0 rotatex
2.5 1.0 0.0 translate
difference

/house

{ /v /u /face
  dark-olive-green 1.0 0.0 1.0
} plane
0.0 -2.0 0.0 translate /grass


house -2.5 -2.0 4.0 translate
grass union
/scene

				% render
0.8 0.8 0.8 point		  % ambient light
[ ]				  % lights
scene				  % scene to render
3				  % tracing depth
90.0				  % field of view
400 240				  % image wid and height
"house.ppm"			  % output file
render