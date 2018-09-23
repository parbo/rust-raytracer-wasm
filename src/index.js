import Worker from 'worker-loader!./render';

function loadGml(file, onDone) {
  let xhr = new XMLHttpRequest();
  xhr.overrideMimeType('text/gml')
  xhr.onreadystatechange = function() {
    if (xhr.readyState == XMLHttpRequest.DONE) {
      onDone(xhr.responseText);
    }
  }
  xhr.open('GET', file, true);
  xhr.send();
}

function renderGml(name) {
  console.log("render: " + name);
  loadGml(name, (contents) => {
    let w = Worker();
    let data = {y: 0, w: 0, ctx: null};

    w.onmessage = function (e) {
      if (e.data[0] === 'image') {
        data.y = 0;
        const canvas = document.getElementById("gml-canvas");
        data.w = e.data[2];
        canvas.width = e.data[2];
        canvas.height = e.data[3];
        data.ctx = canvas.getContext('2d');
      } else if (e.data[0] === 'line') {
        let buffer = e.data[1];
        let draw = () => {
          const imageData = new ImageData(buffer, data.w, 1);
          data.ctx.putImageData(imageData, 0, data.y);
          data.y = data.y + 1;
        }
        requestAnimationFrame(draw);
      }
    };

    w.postMessage([contents]);
  });
}

export {
  renderGml
};
