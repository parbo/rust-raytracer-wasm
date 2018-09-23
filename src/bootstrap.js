// A dependency graph that contains any wasm must all be imported
// asynchronously. This `bootstrap.js` file does the single async import, so
// that no one else needs to worry about it again.

let exports = { renderGml: null }

import("./index.js")
  .catch(e => console.error("Error importing `index.js`:", e))
  .then(mod => exports.renderGml = mod.renderGml);

function renderGml(args) {
  exports.renderGml(args)
}

export {
  renderGml
}
