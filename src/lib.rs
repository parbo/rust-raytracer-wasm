extern crate cfg_if;
extern crate wasm_bindgen;
extern crate rust_raytracer;
extern crate js_sys;

mod utils;

use wasm_bindgen::prelude::*;
use std::rc::Rc;

#[wasm_bindgen]
extern {
    #[wasm_bindgen(js_namespace = console)]
    fn log(msg: &str);
}

// A macro to provide `println!(..)`-style syntax for `console.log` logging.
macro_rules! log {
    ($($t:tt)*) => (log(&format!($($t)*)))
}

struct JsRenderer {
    w: i64,
    h: i64,
    line: Vec<u8>,
    new_image_function: js_sys::Function,
    push_line_function: js_sys::Function
}

impl JsRenderer {
    fn new(new_image_function: js_sys::Function, push_line_function: js_sys::Function) -> JsRenderer {
        JsRenderer {
            w: 0,
            h: 0,
            line: Vec::new(),
            new_image_function: new_image_function,
            push_line_function: push_line_function
        }
    }
}

impl rust_raytracer::render::Renderer for JsRenderer {
    fn new_image(&mut self, name: &str, w: i64, h: i64) {
        log!("new image: {} {} {}", name, w, h);
        self.w = w;
        self.h = h;
        let this = JsValue::NULL;
        let jsname = JsValue::from(name);
        let jsw = JsValue::from(w as u32);
        let jsh = JsValue::from(h as u32);
        let mut jsarr = js_sys::Array::new();
        jsarr.push(&jsname);
        jsarr.push(&jsw);
        jsarr.push(&jsh);
        let _ = self.new_image_function.apply(&this, &jsarr);
        self.line.clear();
        self.line.reserve(w as usize);
    }
    fn push_pixel(&mut self, p: rust_raytracer::render::Pixel) {
        self.line.push((255.0 * p[0].max(0.0).min(1.0)) as u8);
        self.line.push((255.0 * p[1].max(0.0).min(1.0)) as u8);
        self.line.push((255.0 * p[2].max(0.0).min(1.0)) as u8);
        self.line.push(255);

        if self.line.len() >= 4 * self.w as usize {
            let w = 4 * self.w as usize;
            let jsw = JsValue::from(w as u32);
            let line = js_sys::Uint8ClampedArray::new(&jsw);
            let view = js_sys::DataView::new(&line.buffer(), 0, w);
            for x in 0..w {
                view.set_uint8(x, self.line[x]);
            }
            self.line.clear();
            let this = JsValue::NULL;
            let mut jsarr = js_sys::Array::new();
            let jsline = JsValue::from(line);
            jsarr.push(&jsline);

            let _ = self.push_line_function.apply(&this, &jsarr);
        }
    }
}

#[wasm_bindgen]
pub fn render_gml(gml: &str, new_image: js_sys::Function, push_line: js_sys::Function) {
    let renderer = Box::new(JsRenderer::new(new_image, push_line));
    rust_raytracer::render::set_renderer(renderer);
    rust_raytracer::render::render_gml(gml);
}
