import Worker from 'worker-loader!./render';

const gml = [
  "   				% a sphere",
  "{ /v /u /face			  % bind arguments",
  "  0.8 0.2 v point		  % surface color",
  "  1.0 0.2 1.0			  % kd ks n",
  "} sphere /s",
  "",
  "{ /color",
  "  { /v /u /face",
  "    color 1.0 0.0 1.0",
  "  }",
  "} /matte",
  "",
  "1.0  0.2  0.2  point /white",
  "",
  "% a matte white plane",
  "white matte apply plane /p",
  "",
  "				% scene consisting of two spheres",
  "s -1.2 0.0 3.0 translate 	  % sphere at (-1, 0, 3)",
  "s  1.2 1.0 3.0 translate	  % sphere at (1, 1, 3)",
  "p  0.0 -3.0 0.0 translate	  % plane at Y = -3",
  "union union /scene		  % compose",
  "",
  "				% directional light",
  "1.0 -1.0 0.0 point		  % direction",
  "1.0  1.0 1.0 point light /l	  % directional light",
  "",
  "				% render",
  "0.4 0.4 0.4 point		  % ambient light",
  "[ l ]				  % lights",
  "scene				  % scene to render",
  "3				  % tracing depth",
  "90.0				  % field of view",
  "640 480				  % image wid and height",
  "\"spheres.ppm\"			  % output file",
  "render"
]

const canvas = document.getElementById("gml-canvas");
canvas.width = 640;
canvas.height = 480;

const ctx = canvas.getContext('2d');

let w = Worker();
let data = {y: 0};

w.onmessage = function (e) {
  if (e.data[0] === 'image') {
    data.y = 0;
  } else if (e.data[0] === 'line') {
    let buffer = e.data[1];
    let draw = () => {
      const imageData = new ImageData(buffer, canvas.width, 1);
      ctx.putImageData(imageData, 0, data.y);
      data.y = data.y + 1;
    }
    requestAnimationFrame(draw);
  }
};

console.log("rendering gml: " + gml);
w.postMessage([gml.join("\n")]);
